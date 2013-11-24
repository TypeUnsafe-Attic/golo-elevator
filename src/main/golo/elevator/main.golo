module elevator.Main

import elevator.conf.jetty
import elevator.controllers.elevatorController
import elevator.services.elevatorService
import elevator.domain.elevator


function main = |args| {

  Jetty(null): init()
  let elevator = Elevator()
  ElevatorController(ElevatorService(elevator))
}