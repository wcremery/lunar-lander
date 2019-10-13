-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local largeur, hauteur
local forceX, forceY
local Lander = {}

Lander.x = 0
Lander.y = 0
Lander.angle = 1.5 * math.pi
Lander.vx = 0
Lander.vy = 0
Lander.vitesse = 3
Lander.vitesseMax = 50
Lander.engineOn = false
Lander.imgShip = love.graphics.newImage("images/ship.png")
Lander.imgEngine = love.graphics.newImage("images/engine.png")
Lander.mort = false

function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  Lander.x = largeur/2
  Lander.y = hauteur/2
  
end

function love.update(dt)
  
  forceX = math.cos(Lander.angle) * (Lander.vitesse * dt)
  forceY = math.sin(Lander.angle) * (Lander.vitesse * dt)
  
  if love.keyboard.isDown("up") then
    
    Lander.engineOn = true
    
    if math.abs(Lander.vy) <= Lander.vitesseMax * dt then
      Lander.vy = Lander.vy + forceY
    else
      if Lander.vy < 0 then
        Lander.vy = -Lander.vitesseMax * dt
      else
        Lander.vy = Lander.vitesseMax * dt
      end
    end

    if math.abs(Lander.vx) <= Lander.vitesseMax * dt then
      Lander.vx = Lander.vx + forceX
    else
      if Lander.vx < 0 then
        Lander.vx = -Lander.vitesseMax * dt
      else
        Lander.vx = Lander.vitesseMax * dt
      end
    end
    
  else
  
    Lander.engineOn = false
    
    if Lander.vx < 0 then
      Lander.vx = Lander.vx + 0.2 * dt
    else
      Lander.vx = Lander.vx - 0.2 * dt
    end
    
    if Lander.vy < 0 then
        Lander.vy = Lander.vy + 0.2 * dt
      else
        Lander.vy = Lander.vy - 0.2 * dt
    end
      
  end
  
  if love.keyboard.isDown("left") then
    
    Lander.angle = Lander.angle - 1 * dt
    
  end
  
  if love.keyboard.isDown("right") then
    
    Lander.angle = Lander.angle + 1 * dt
    
  end
  
  if Lander.x < (200+150) and Lander.x > (200-150) and Lander.y > (450-150) and Lander.y < (450+150) then
    print ("alerte !!!")
  end
  if Lander.x < (200+100) and Lander.x > (200-100) and Lander.y > (450-100) and Lander.y < (450+100) then
    print ("collision !!!")
  end
  
  Lander.y = (Lander.y + Lander.vy) % hauteur
  Lander.x = (Lander.x + Lander.vx) % largeur
  
end

function love.draw()
  
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", 200, 450, 100)
  love.graphics.setColor(1, 1, 1)
  
  love.graphics.print("x : "..Lander.x.."\ny : "..Lander.y)
  if not Lander.mort then
    love.graphics.draw(Lander.imgShip, Lander.x, Lander.y, Lander.angle, 1, 1, Lander.imgShip:getWidth()/2, Lander.imgShip:getHeight()/2)
    
    if Lander.engineOn then
      
      love.graphics.draw(Lander.imgEngine, Lander.x, Lander.y, Lander.angle, 1, 1, Lander.imgEngine:getWidth()/2, Lander.imgEngine:getHeight()/2)
      
    end
  end
  
  --love.graphics.print("vitesse x : "..Lander.vx.."\nvitesse y : "..Lander.vy)
  
  
end

function love.keypressed(key)
  
  print(key)
  
end
  