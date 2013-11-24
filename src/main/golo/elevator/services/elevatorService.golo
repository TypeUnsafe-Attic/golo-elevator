module elevator.services.elevatorService


function ElevatorService = |elevator| -> DynamicObject():
  elevator(elevator):
  define("call",           ^_call):
  define("go",             ^_go):
  define("userHasEntered", ^_userHasEntered):
  define("userHasExited",  ^_userHasExited):
  define("reset",          ^_reset):
  define("nextCommand",    ^_nextCommand):
  freeze()


local function _call = |this, atFloor, toFloor| {
  return ""
}

local function _go = |this, floorToGo| {
  return ""
}

local function _userHasEntered = |this| {
  return ""
}

local function _userHasExited = |this| {
  return ""
}

local function _reset = |this, lowerFloor, higherFloor, cabinSize, cause| {
  this: elevator(): lowerFloor(lowerFloor)
  this: elevator(): higherFloor(higherFloor)
  this: elevator(): cabinSize(cabinSize)
  return ""
}

local function _nextCommand = |this| {
  return this: elevator(): nextCommand()
}
