
-- Create the Background class
Background = {}


function Background:load()
   -- Load the background image
   self.image = love.graphics.newImage("assets/background.png")
end

function Background:update(dt)

end

function Background:draw()
   -- Draw the background image
   love.graphics.draw(self.image, 0, 0)
end