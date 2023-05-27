Player = {}

function Player:load()
   -- Set the player's initial position
   self.x = 50
   self.y = love.graphics.getHeight() / 2
   -- Load the player's image and set its width and height
   self.img = love.graphics.newImage("assets/paddle2.png")
   self.width = self.img:getWidth() 
   self.height = self.img:getHeight() 
   -- Set the player's speed and initialize the timer
   self.speed = 500
   self.timer = 0
   self.rate = 2
end


function Player:update(dt)
   -- Move the player
   self:move(dt)
   self:checkBoundaries()
end


function Player:move(dt)
   -- Move the player with the mouse
   if love.mouse.isDown(1) then
      self.y = love.mouse.getY()
   end

end

function Player:checkBoundaries()
   -- Prevent the player from moving off the screen
   if self.y < 0 then
      self.y = 0
   elseif self.y + self.height > love.graphics.getHeight() then
      self.y = love.graphics.getHeight() - self.height
   end
end


function Player:draw()
   -- Draw the player
   love.graphics.draw(self.img, self.x, self.y)
end