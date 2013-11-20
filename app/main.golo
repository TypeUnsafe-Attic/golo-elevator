module golo.code.elevator

import elevator

function main = |args| {
  let app = Application()

  app: staticFileLocation(java.io.File( "." ): getCanonicalPath() + "/app/public")
  app: port(80)

  let elevator = Elevator()

  # Get about information
  app: GET("/about",|request, response|{
      return "42"
  })

  # TODO:
  # OPEN (and CLOSE) commands only if a passenger at the floor

  #/reset means the building server think the cabin has made an impossible move
  #going below the lowest floor for instance,
  #or moving while the doors are open.
  #So the server issues a reset to the cabin, meaning the cabin is back at it's starting position
  #s03e01.4 /reset?lowerFloor=0&higherFloor=19&cause=information+message
  #s03e01.7 /reset?lowerFloor=0&higherFloor=19&cabinSize=30&cause=information+message
  app: GET("/reset", |request, response| {

    #s03e01.4
    if request: queryParams("lowerFloor") isnt null {
      elevator: setFloors(
          request: queryParams("lowerFloor"): toInteger()
        , request: queryParams("higherFloor"): toInteger()
      )
      elevator: cabinSize(request: queryParams("cabinSize"): toInteger())

    } else { # omnibus s03e01.0
        elevator: setFloors(0,5)
        elevator: cabinSize(100)
    }

    println("/reset ->" +
      " lowerFloor : " + elevator: lowerFloor() +
      " higherFloor : " + elevator: higherFloor() +
      " cabinSize : " + elevator: cabinSize() +
      " cause : " + request: queryParams("cause")
    )

    #elevator: cause(request: queryParams("cause"): toInteger())

    response: status(200)
    #elevator: initializeWithSteps(): atFloor(0)
    elevator: atFloor(0)
    return response
  })

  app: GET("/nextCommand", |request, response| {
    # UP|DOWN|OPEN|CLOSE|NOTHING
    let nextCommand = elevator: nextCommand()
    println("/nextCommand -> " + nextCommand +
      " atFloor : " + elevator: atFloor() +
      " floorToGo : " + elevator: floorToGo() +
      " nextFloor : " + elevator: floor())

    response: status(200)
    return nextCommand
  })

  #/call?atFloor=[0-5] means someone is waiting to get into the cabin at floor atFloor
  app: GET("/call", |request, response| {
    let floor = request: queryParams("atFloor"): toInteger()
    let direction = request: queryParams("to")
    println("/call -> Floor : " + floor + " Direction : " + direction)

    elevator: atFloor(floor)

    response: status(200)
    return response
  })
  #/go?floorToGo=[0-5] means someone, who just got into the cabin, wants to leave at floor floorToGo
  app: GET("/go", |request, response| {
    let floor = request: queryParams("floorToGo"): toInteger()
    elevator: floorToGo(floor)
    println("/go -> floorToGo : " + floor)
    response: status(200)
    return response
  })
  #/userHasEntered means someone just entered the cabin
  app: GET("/userHasEntered", |request, response| {
    elevator: passengers(elevator: passengers() + 1)
    println("/userHasEntered -> passengers : " + elevator: passengers())

    # what to do if passengers exceed CabinSize ?
    # send request to the other server ?
    # add command to the elevator -> NOTHING

    response: status(200)
    return response
  })
  #/userHasExited means someone just exited the cabin
  #For the building server to be happy you just need to answer with a 200 OK an empty answer
  app: GET("/userHasExited", |request, response| {
    elevator: passengers(elevator: passengers() - 1)
    println("/userHasExited -> passengers : " + elevator: passengers())
    response: status(200)
    return response
  })

}

