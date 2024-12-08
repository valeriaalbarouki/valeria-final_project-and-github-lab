PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player
    print("A" .. self.player.playernum)

    self.animation = Animation {
        frames = {4},
        interval = 1
    }

    self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
    if self.player.playernum == 1 then
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walking')
        end

        if love.keyboard.wasPressed('up') then
            self.player:changeState('jump')
        end

        if love.keyboard.wasPressed('space') then
            PREV_STATE = 'idle'
            self.player:changeState('attack') 
        end

       
        for k, entity in pairs(self.player.level.entities) do
            if entity:collides(self.player) then
                gSounds['death']:play()
                gStateMachine:change('start')
            end
        end
    elseif self.player.playernum == 2 then 
        if love.keyboard.isDown('a') or love.keyboard.isDown('d') then
            self.player:changeState('walking')
        end

        if love.keyboard.wasPressed('w') then
            self.player:changeState('jump')
        end

        if love.keyboard.wasPressed('q') then
            PREV_STATE = 'idle'
            self.player:changeState('attack') 
        end

      
        for k, entity in pairs(self.player.level.entities) do
            if entity:collides(self.player) then
                gSounds['death']:play()
                gStateMachine:change('start')
            end
        end
    end
end
