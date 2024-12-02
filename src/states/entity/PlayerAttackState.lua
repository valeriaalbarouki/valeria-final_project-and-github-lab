PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player)
    self.player = player
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if self.player.direction == 'left' then
        hitboxWidth = 15
        hitboxHeight = 16
        hitboxX = self.player.x - hitboxWidth
        hitboxY = self.player.y + 2
    elseif self.player.direction == 'right' then
        hitboxWidth = 15
        hitboxHeight = 16
        hitboxX = self.player.x + self.player.width
        hitboxY = self.player.y + 2
    end

    -- separate hitbox for the player's sword; will only be active during this state
    self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)

    -- sword-left, sword-up, etc
    self.animation = Animation {
        frames = {6},
        interval = 1
    }

    self.player.currentAnimation = self.animation
end

function PlayerAttackState:update(dt)
    self.player.currentAnimation:update(dt)
    gSounds['sword']:stop()
    gSounds['sword']:play()
    
    -- check if hitbox collides with any entities in the scene
    for k, entity in pairs(self.player.level.entities) do
        if entity:collides(self.swordHitbox) then
            gSounds['kill']:play()
            gSounds['kill2']:play()
            self.player.score = self.player.score + 100
            table.remove(self.player.level.entities, k)
        end 
    end

    if (love.keyboard.wasPressed('space') and self.player.playernum == 1) or (love.keyboard.wasPressed('q') and self.player.playernum == 2) then
        self.player:changeState('attack')
    else 
        self.player:changeState(PREV_STATE)
    end

    if (love.keyboard.isDown('left') or love.keyboard.isDown('right') and self.player.playernum == 1) or (love.keyboard.isDown('a') or love.keyboard.isDown('d') and self.player.playernum == 2) then
        print('ha')
        self.player:changeState('walking')
    -- elseif love.keyboard.isDown('a') or love.keyboard.isDown('d') and self.player.playernum == 2 then 
    --     print('wa')
    --     self.player:changeState('walking')
    end

    if love.keyboard.wasPressed('up') and self.player.playenum == 1 then
        self.player:changeState('jump')
    elseif love.keyboard.wasPressed('w') and self.player.playernum == 2 then 
        self.player:changeState('jump')
    end

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHitbox.x, self.swordHitbox.y,
    --     self.swordHitbox.width, self.swordHitbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end