StartState = Class{__includes = BaseState}

function StartState:init()
    self.map = LevelMaker.generate(100, 10)
    self.background = math.random(3)
    PLAYERSCORE_STORE = 0
    LEVEL = 1
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function saveMaxScore()
    local saveData = require("saveData")
    t = {}
    t.settings = {graphics = "good"}
    t.settings.window = {x = 10, y = 20}
    t.save = {}
    t.save.scene = "boss"

    saveData.save(t, "test")

    local t2 = saveData.load("test")
    print(t2.settings.graphics)
    print(t2.settings.window.x, t2.settings.window.y)
    print(t2.save.scene)
end

function StartState:render()
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0)
    love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0,
        gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
    self.map:render()

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Super Bootleg Brothers.', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Super Bootleg Brothers.', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press Enter', 1, VIRTUAL_HEIGHT / 2 + 36, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 35, VIRTUAL_WIDTH, 'center')
end