PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(player)
    self.player = player
    self.animation = Animation {
        frames = {1, 2, 3},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)
    self.player.currentAnimation:update(dt)

    -- idle if we're not pressing anything at all
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') and self.player.playernum == 1 then
        self.player:changeState('idle')
    elseif not love.keyboard.isDown('a') and not love.keyboard.isDown('d') and self.player.playernum == 2 then 
        self.player:changeState('idle')
    else
        local tileBottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)
        local tileBottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1, self.player.y + self.player.height)

        -- temporarily shift player down a pixel to test for game objects beneath
        self.player.y = self.player.y + 1 

        local collidedObjects = self.player:checkObjectCollisions()

        self.player.y = self.player.y - 1

        -- check to see whether there are any tiles beneath us
        if #collidedObjects == 0 and (tileBottomLeft and tileBottomRight) and (not tileBottomLeft:collidable() and not tileBottomRight:collidable()) then
            self.player.dy = 0
            self.player:changeState('falling')
        elseif (love.keyboard.isDown('left') and self.player.playernum == 1) or (love.keyboard.isDown('a') and self.player.playernum == 2) then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
            self.player.direction = 'left'
            self.player:checkLeftCollisions(dt)
        elseif (love.keyboard.isDown('right') and self.player.playernum == 1) or (love.keyboard.isDown('d') and self.player.playernum == 2) then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
            self.player.direction = 'right'
            self.player:checkRightCollisions(dt)
        end
    end

    -- check if we've collided with any entities and die if so
    for k, entity in pairs(self.player.level.entities) do
        if entity:collides(self.player) then
            gSounds['death']:play()
            gStateMachine:change('start')
        end
    end

    if (love.keyboard.wasPressed('up') and self.player.playernum == 1) or (love.keyboard.wasPressed('w') and self.player.playernum == 2) then
        self.player:changeState('jump')
    end

    if (love.keyboard.isDown('space') and self.player.playernum == 1) or (love.keyboard.wasPressed('q') and self.player.playernum == 2) then
        self.player:changeState('attack')
    end 
end