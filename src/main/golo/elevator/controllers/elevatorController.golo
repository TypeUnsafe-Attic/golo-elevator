module elevator.controllers.elevatorController

import meeki.route

function ElevatorController = |elevatorService| {
 GET("/call",           ^call: bindTo(elevatorService))
 GET("/go",             ^go: bindTo(elevatorService))
 GET("/userHasEntered", ^userHasEntered: bindTo(elevatorService))
 GET("/userHasExited",  ^userHasExited: bindTo(elevatorService))
 GET("/nextCommand",    ^nextCommand: bindTo(elevatorService))
 GET("/reset",          ^reset: bindTo(elevatorService))
}

function call = |service, request, response| {
  let atFloor = request: queryParams("atFloor")?: toInteger()
  let toFloor = request: queryParams("to")
  println("/call -> atFloor: " + atFloor + ", to: " + toFloor)
  response: status(200)
  return service: call(atFloor, toFloor)
}

function go = |service, request, response| {
  let floorToGo = request: queryParams("floorToGo")?: toInteger()
  println("/go -> floorToGo: " + floorToGo)
  response: status(200)
  return service: go(floorToGo)
}

function userHasEntered = |service, request, response| {
  println("/userHasEntered")
  response: status(200)
  return service: userHasEntered()
}

function userHasExited = |service, request, response| {
  println("/userHasExited")
  response: status(200)
  return service: userHasExited()
}

function nextCommand = |service, request, response| {
  println("/nextCommand")
  response: status(200)
  return service: nextCommand()
}

function reset = |service, request, response| {
  let lowerFloor  = request: queryParams("lowerFloor")?: toInteger()
  let higherFloor = request: queryParams("higherFloor")?: toInteger()
  let cabinSize   = request: queryParams("cabinSize")?: toInteger()
  let cause       = request: queryParams("cause")
  println("/reset -> lowerFloor: " + lowerFloor +
          ", higherFloor: " + higherFloor + ", cabinSize: " + cabinSize +
          ", cause: " + cause)
  response: status(200)
  return service: reset(lowerFloor, higherFloor, cabinSize, cause)
}
