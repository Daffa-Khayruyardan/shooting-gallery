function love.load()
    love.window.setTitle("Shooting Gallery")

    target = {}
    target.x = 200
    target.y = 200
    target.radius = 50

    score = 0
    timer = 10

    gamefont = love.graphics.newFont(40)

    gameState = 1

    asset = {}
    asset.sky = love.graphics.newImage('assets/sky.png')
    asset.target = love.graphics.newImage("assets/target.png")
    asset.crosshair = love.graphics.newImage("assets/crosshairs.png")
end

function love.update(dt)
    if timer > 0 and gameState == 2 then
        timer = timer - dt
    end 
    
    if timer < 0 and gameState == 2 then 
        timer = 0
        gameState = 1
    end
end 

function love.draw()
    love.graphics.draw(asset.sky, 0,0)

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gamefont)

    if gameState == 2 then
        love.graphics.print("Score: " .. score,0,0)
        love.graphics.print("Timer: " .. math.ceil(timer),200,0)
    end

    love.mouse.setVisible(false)

    if gameState == 2 then
        love.graphics.draw(asset.target, target.x-50,target.y-50)
    end

    love.graphics.draw(asset.crosshair, love.mouse.getX() - 20, love.mouse.getY() - 20)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin", 0, 250, love.graphics.getWidth(), "center")
    end
end 

function love.mousepressed(x,y,button,istouch, presses) 
    -- click button to start the games
    if button == 1 and gameState == 2 then
        local mouseTarget = distance(x,y,target.x,target.y)

        if mouseTarget < target.radius then 
            score = score + 1

            displayWidth = love.graphics.getWidth()
            displayHeigth = love.graphics.getHeight()

            target.x = math.random(target.radius, displayWidth - target.radius)
            target.y = math.random(target.radius, displayHeigth - target.radius)
        elseif mouseTarget > target.radius and score > 0 then
            score = score -1
        end 
    elseif button == 2 then
        local mouseTarget = distance(x,y,target.x,target.y)

        if mouseTarget < target.radius then 
            score = score + 2
            timer = timer -1

            displayWidth = love.graphics.getWidth()
            displayHeigth = love.graphics.getHeight()

            target.x = math.random(target.radius, displayWidth - target.radius)
            target.y = math.random(target.radius, displayHeigth - target.radius)
        end 
    end

    if button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0   
    end 
end 

function distance(x1,y1,x2,y2) 
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end 