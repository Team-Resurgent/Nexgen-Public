local movement = {}

function movement.Move(dt,direction,shipTable)
      if direction == "Left" and shipTable.x > 0 then -- ensure ship is always in window
            shipTable.x = shipTable.x - (shipTable.speed * dt)
      end

      if direction == "Right" and shipTable.x < (renderGetWidth() - shipTable.shipWidth) then -- ensure ship is always in window
            shipTable.x = shipTable.x + (shipTable.speed * dt)
      end

      if direction == "Down" and shipTable.y > 0 then -- ensure ship is always in window
            shipTable.y = shipTable.y - (shipTable.speed * dt)
      end

      if direction == "Up" and shipTable.y < (renderGetHeight() - shipTable.shipHeight) then -- ensure ship is always in window
            shipTable.y = shipTable.y + (shipTable.speed * dt)
      end
end

return movement