

AI = {}


function AI:load()
   -- Set the AI's initial position, size, speed and load its image
   self.img = love.graphics.newImage("assets/paddleblue.png")
   self.width = self.img:getWidth()
   self.height = self.img:getHeight()
   self.x = love.graphics.getWidth() - self.width - 50
   self.y = love.graphics.getHeight() / 2
   self.yVel = 0
   self.speed = 350
   self.timer = 0
   self.rate = 0.1
end


function AI:update(dt)
   -- Move the AI
   self:move(dt)
   self.timer = self.timer + dt
   -- Update the AI's target position
   if self.timer > self.rate then
      self.timer = 0
      self:acquireTarget()
   end
end


function AI:move(dt)
   -- Move the AI
   self.y = self.y + self.yVel * dt
end


function AI:acquireTarget()
   -- Set the AI's target position based on the ball's position
   if Ball.y + Ball.height < self.y then
      self.yVel = -self.speed
   elseif Ball.y > self.y + self.height then
      self.yVel = self.speed
   else
      self.yVel = 0
   end
end


function AI:draw()
   -- Draw the AI
   love.graphics.draw(self.img, self.x, self.y)
end

