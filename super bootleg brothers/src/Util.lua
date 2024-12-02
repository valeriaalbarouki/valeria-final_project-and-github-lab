function GenerateQuads1(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet 
end

function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local chars = {}

    -- for y = 0, sheetHeight - 1 do
    --     for x = 0, sheetWidth - 1 do
    --         spritesheet[sheetCounter] =
    --             love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
    --             tileheight, atlas:getDimensions())
    --         sheetCounter = sheetCounter + 1
    --     end
    -- end

    chars[1] = love.graphics.newImage('graphics/nezuko_run_1.png')
    chars[2] = love.graphics.newImage('graphics/nezuko_run_2.png')
    chars[3] = love.graphics.newImage('graphics/nezuko_run_3.png')
    chars[4] = love.graphics.newImage('graphics/nezuko_idle.png')
    chars[5] = love.graphics.newImage('graphics/nezuko_jump.png')
    chars[6] = love.graphics.newImage('graphics/nezuko_kick.png')
    chars[7] = love.graphics.newImage('graphics/nezuko_fall.png')

    return chars 
end

--[[
    Divides quads we've generated via slicing our tile sheet into separate tile sets.
]]
function GenerateTileSets(quads, setsX, setsY, sizeX, sizeY)
    local tilesets = {}
    local tableCounter = 0
    local sheetWidth = setsX * sizeX
    local sheetHeight = setsY * sizeY

    -- for each tile set on the X and Y
    for tilesetY = 1, setsY do
        for tilesetX = 1, setsX do
            
            -- tileset table
            table.insert(tilesets, {})
            tableCounter = tableCounter + 1

            for y = sizeY * (tilesetY - 1) + 1, sizeY * (tilesetY - 1) + 1 + sizeY do
                for x = sizeX * (tilesetX - 1) + 1, sizeX * (tilesetX - 1) + 1 + sizeX do
                    table.insert(tilesets[tableCounter], quads[sheetWidth * (y - 1) + x])
                end
            end
        end
    end

    return tilesets
end