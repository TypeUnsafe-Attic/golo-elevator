module elevator

function Elevator = ->
  DynamicObject()
      :commands(list[])
      :addCommand(|this, command|{
        this: commands(): add(command)
        return this
      })
      :nextCommand(|this|{
        var nextCommand = "NOTHING"

        if this: passengers() <= this: cabinSize() {
          nextCommand = this: commands(): pollFirst()
          if nextCommand is null {
              this: initializeCommands()
              nextCommand = this: commands(): pollFirst()
          }
        } # else too much people -> don't move!

        case {
          when nextCommand: equals("UP") {
            this: floor(this: floor() + 1)
          }
          when nextCommand: equals("DOWN") {
            this: floor(this: floor() - 1)
          }
          otherwise {
            # foo
          }
        }

        return nextCommand
      })
      :atFloor(0)
      :floorToGo(0) # or list ?
      :floor(0)
      :initializeCommands(|this|{
        this: higherFloor(): times({
          this: addCommand("OPEN"): addCommand("CLOSE"): addCommand("UP")
          #this: addCommand("UP")
        })
        this: higherFloor(): times({
          this: addCommand("OPEN"): addCommand("CLOSE"): addCommand("DOWN")
          #this: addCommand("DOWN")
        })
        return this
      })
      :setFloors(|this, lower, higher|{
        this: lowerFloor(lower)
        this: higherFloor(higher)
        this: initializeCommands()
        # here set steps
        return this
      })
      :passengers(0)
      :cabinSize(0)