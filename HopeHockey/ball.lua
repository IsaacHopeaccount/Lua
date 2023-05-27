

Ball = {}

-- Load the ball properties and set its initial position, size, and velocity
function Ball:load()
   self.img = love.graphics.newImage("assets/puck2.png")
   self.x = love.graphics.getWidth() / 2
   self.y = love.graphics.getHeight() / 2
   self.width = 20
   self.height = 20
   self.speed = 600
   self.xVel = -self.speed
   self.yVel = 0
end

-- Update the ball's movement and handle collisions
function Ball:update(dt)
   self:move(dt)
   self:collide()
end

-- Check for collisions with walls, player, and AI paddle, and handle accordingly
function Ball:collide()
   self:collideWall()
   self:collidePlayer()
   self:collideAI()
   self:score()
end

-- Handle collisions with the top and bottom walls by changing the vertical velocity
function Ball:collideWall()

   if self.y < 0 then
      self.y = 0
      self.yVel = -self.yVel
   elseif self.y + self.height > love.graphics.getHeight() then
      self.y = love.graphics.getHeight() - self.height
      self.yVel = -self.yVel
   end
end

-- Handle collision with the player paddle by changing the ball's velocity based on the collision position
function Ball:collidePlayer()
   if checkCollision(self, Player) then
      self.xVel = self.speed
      local middleBall = self.y + self.height / 2
      local middlePlayer = Player.y + Player.height / 2
      local collisionPosition = middleBall - middlePlayer
      self.yVel = collisionPosition * 5
   end
end

-- Handle collision with the AI paddle by changing the ball's velocity based on the collision position
function Ball:collideAI()

   if checkCollision(self, AI) then
      self.xVel = -self.speed
      local middleBall = self.y + self.height / 2
      local middleAI = AI.y + AI.height / 2
      local collisionPosition = middleBall - middleAI
      self.yVel = collisionPosition * 5
   end

end

-- Move the ball based on its velocity and the frame rate
function Ball:move(dt)
   self.x = self.x + self.xVel * dt
   self.y = self.y + self.yVel * dt
end

-- Handle scoring when the ball crosses the boundaries of the play area
function Ball:score()
   if self.x < 0 then
      self:resetPosition(1)
      Score.ai = Score.ai + 1
      sound = love.audio.newSource("assets/score.wav", "static")
      sound:play()
   end

   if self.x + self.width > love.graphics.getWidth() then
      self:resetPosition(-1)
      Score.player = Score.player + 1
      sound = love.audio.newSource("assets/score.wav", "static")
      sound:play()
   end

   if self.x + self.width > love.graphics.getWidth() then
      self.x = love.graphics.getWidth /2 - self.width / 2
      self.y = love.graphics.getHeight() / 2 - self.height / 2
      self.yVel = 0
      self.xVel = -self.speed
   end

end

-- Center the ball when a point is scored
function Ball:resetPosition(modifier)
   self.x = love.graphics.getWidth() / 2 - self.width / 2
   self.y = love.graphics.getHeight() / 2 - self.height / 2
   self.yVel = 0
   self.xVel = self.speed * modifier
end

-- Draw the ball on the screen
function Ball:draw()
   love.graphics.draw(self.img, self.x, self.y)
end
