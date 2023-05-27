require("player")
require("ball")
require("ai")
require("background")
-- Set the initial game state and difficulty
difficulty="easy"
gamestate = "menu"

function love.load()
   music = love.audio.newSource("assets/theme.mp3", "stream")
   music:setLooping(true)
   music:play()
   Score = {player =0, ai = 0}
   font = love.graphics.newFont("assets/Franchise.ttf", 32)
   background=love.graphics.newImage("assets/background.png")

   obstacles = {} -- Initialize the obstacles table

   -- Add obstacles for the "hard" difficulty
   if difficulty == "hard" then
      table.insert(obstacles, {x = 100, y = 200, width = 100, height = 20}) -- Example obstacle
      
   end
-- Load player, ball, and AI
   Player:load()
   Ball:load()
   AI:load()

end

function love.update(dt)
   if gamestate == "play" then
      -- Update player, ball, and AI
      Player:update(dt)
      Ball:update(dt)
      AI:update(dt)
   end
end

function love.draw()
   love.graphics.setFont(font)
   if gamestate == "menu" then
      drawMenu()
   end
   if gamestate == "difficultySelect" then
      drawDifficulty()
   end
   if gamestate == "play" then 
      -- Clear the screen and draw the background
      Player.score = 0
      AI.score = 0
      love.graphics.draw(background,-50,-50)
      -- Draw player, ball, AI, Score, and obstacles
      Player:draw()
      Ball:draw()
      AI:draw()
      drawScore()
        -- Set AI speed based on the selected difficulty
      if difficulty == "easy" then
         AI.speed = 200
      end
      if difficulty == "medium" then
         AI.speed = 300
      end
      if difficulty == "hard" then
         love.graphics.setColor(0.5, 0.5, 0.5) -- Set obstacle color (gray)
         -- Draw obstacles
         for i, obstacle in ipairs(obstacles) do
            love.graphics.rectangle("fill", obstacle.x, obstacle.y, obstacle.width, obstacle.height) -- Draw obstacles
         end
         love.graphics.setColor(1, 1, 1) -- Reset color to white
      end
      -- Check for game over conditions
      if Score.player == 10 then
         love.graphics.print("Player Wins!", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2 - 100)
         Ball.speed=0
         Ball.xVel = -Ball.xVel 
         Ball.yVel = -Ball.yVel
         love.graphics.print("Press Space to go back to menu", love.graphics.getWidth()/2 - 300, love.graphics.getHeight()/2 - 200)
         if love.keyboard.isDown("space") then
            gamestate = "menu"
         end
      elseif Score.ai == 10 then
         love.graphics.print("AI Wins!", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2 - 100)
         Ball.speed = 0
         Ball.xVel = -Ball.xVel 
         Ball.yVel = -Ball.yVel
         love.graphics.print("Press Space to go back to menu", love.graphics.getWidth()/2 - 250, love.graphics.getHeight()/2 )
         if love.keyboard.isDown("space") then
            gamestate = "menu"
         end
      end
      -- Handle ball collision with obstacles in "hard" difficulty
      if difficulty == "hard" then
         for i, obstacle in ipairs(obstacles) do
            if checkCollision(Ball, obstacle) then
               -- Handle collision between ball and obstacle
               Ball.xVel = -Ball.xVel 
               Ball.yVel = -Ball.yVel
            end
         end
      end

   end
end

function drawMenu()
   -- Draw the menu background and menu options
   menubg=love.graphics.newImage("assets/airhockey4.jpg")
   love.graphics.draw(menubg,-50,0)
   love.graphics.print("Play (1)", 390,175)
   love.graphics.print("How to play (2)", 100,400)
   love.graphics.print("Quit (3)", 600,400)
   if love.keyboard.isDown("1") then
      gamestate = "difficultySelect"
      Score = {player =0, ai = 0}
   end
   -- Check for user input to transition to the appropriate game state
   if love.keyboard.isDown("2") then
      love.graphics.print("Use the mouse to move your paddle, First to 10 wins!",love.graphics.getWidth() /2 - 150, love.graphics.getHeight() - 25)
   end
   if love.keyboard.isDown("3") then
      love.event.quit()
   end
end

-- Draw the difficulty selection background and options
function drawDifficulty()
   love.graphics.draw(menubg, -50, 0)
   love.graphics.print("Easy (4)", 390, 175)
   love.graphics.print("Medium (5)", 100, 400)
   love.graphics.print("Hard (6)", 600, 400)
   -- Check for user input to set the difficulty and start the game
   if love.keyboard.isDown("4") then
      gamestate = "play"
      difficulty = "easy"
      Ball.speed = 600
   end
   if love.keyboard.isDown("5") then
      gamestate = "play"
      difficulty = "medium"
      Ball.speed = 800
   end
   if love.keyboard.isDown("6") then
      gamestate = "play"
      difficulty = "hard"
      Ball.speed = 1000
      obstacles = {} -- Initialize the obstacles table
       table.insert(obstacles, {x = 200, y = 100, width = 20, height = 50})
       table.insert(obstacles, {x = 650, y = 100, width = 20, height = 50})
       table.insert(obstacles, {x = 200, y = love.graphics.getHeight() - 200, width = 20, height = 50})
       table.insert(obstacles, {x = 650, y = love.graphics.getHeight() - 200, width = 20, height = 50})
       table.insert(obstacles, {x = 250, y = love.graphics.getHeight() - 50, width = 100, height = 20})
       table.insert(obstacles, {x =550, y = love.graphics.getHeight()  - 50, width = 100, height = 20})
       table.insert(obstacles, {x = 250, y = 50, width = 100, height = 20})
       table.insert(obstacles, {x =550, y = 50, width = 100, height = 20})
   end
end

function drawScore()
   -- Draw the current scores
   love.graphics.setFont(font)
   love.graphics.print("Player: "..Score.player,50,50)
   love.graphics.print("AI: "..Score.ai,love.graphics.getWidth() -150 ,50)
end

function checkCollision(a, b)
   -- Check collision between two objects (a and b)
   if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
      return true
   else
      return false
   end
end