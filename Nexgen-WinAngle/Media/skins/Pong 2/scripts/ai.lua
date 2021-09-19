local autoAI = {}


 AI = {
	  x = renderGetWidth() - player2ImgWidth * 2,
      y = renderGetHeight() - player2ImgHeight,
      speed = 500,
      score = 0,
	  vel = 0,
	  timer = 0,
	  rate = 0.5
	  
}


 AI2 = {
	  x = 0 + player1ImgWidth,
      y = renderGetHeight() - player1ImgHeight,
      speed = 500,
      score = 0,
	  vel = 0,
	  timer = 0,
	  rate = 0.5
	  
}


function autoAI.AIupdate(dt)
   AI:move(dt)
   AI.timer = AI.timer + dt
   if AI.timer > AI.rate then
      AI.timer = 0
      AI:acquireTarget()
   end
end


function AI:acquireTarget()

--down
   if ball.y + ballImgHeight < player1.y then
      AI.vel = -AI.speed

--up	  
   elseif ball.y > player1.y + player1ImgHeight   then
      AI.vel = AI.speed
	  
   else
      AI.vel = 0
   end
   
end

function AI:move(dt)
	  if player1.y < 0 then
                  player1.y = 0
	elseif player1.y > (renderGetHeight() - player1ImgHeight) then
                  player1.y = (renderGetHeight() - player1ImgHeight)
     end
   player1.y = player1.y + AI.vel * dt
end

----------------------------------------------------------------------------------------------

function autoAI.AI2update(dt)
   AI2:move(dt)
   AI2.timer = AI2.timer + dt
   if AI2.timer > AI2.rate then
      AI2.timer = 0
      AI2:acquireTarget()
   end
end


function AI2:acquireTarget()

--down
   if ball.y + ballImgHeight < player2.y then
      AI2.vel = -AI2.speed

--up	  
   elseif ball.y > player2.y + player2ImgHeight   then
      AI2.vel = AI2.speed
	  
   else
      AI2.vel = 0
   end
   
end

function AI2:move(dt)
	  if player2.y < 0 then
                  player2.y = 0
	elseif player2.y > (renderGetHeight() - player2ImgHeight) then
                  player2.y = (renderGetHeight() - player2ImgHeight)
     end
   player2.y = player2.y + AI2.vel * dt
end

return autoAI