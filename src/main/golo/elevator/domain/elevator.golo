module elevator.domain.elevator

function Elevator = -> DynamicObject():
  passengers(0):
  cabinSize(0):
  lowerFloor(0):
  higherFloor(0):
  count(0):
  commands(list[
    "OPEN","CLOSE","UP",
    "OPEN","CLOSE","UP",
    "OPEN","CLOSE","UP",
    "OPEN","CLOSE","UP",
    "OPEN","CLOSE","UP",
    "OPEN","CLOSE","DOWN",
    "OPEN","CLOSE","DOWN",
    "OPEN","CLOSE","DOWN",
    "OPEN","CLOSE","DOWN",
    "OPEN","CLOSE","DOWN"
  ]):
  define("nextCommand", ^_nextCommand)


local function _nextCommand = |this| {
  let nextCommand = this: commands(): get( this: count() % this: commands(): size())
  this: count(this: count() + 1)
  return nextCommand
}