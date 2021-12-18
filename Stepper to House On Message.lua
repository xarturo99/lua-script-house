--[[
    Script Name: 		Message responder
    Description: 		Respond for message on chat
    Author: 			Ascer - example
]]

local BACK_TO= {x = 32053, y = 31366, z = 8}
local BACKPACK_POSITION = { x = 32056, y = 31366, z = 8}
local BACKPACK_ID = 2866
local RESPOND_TO = {"Klempaniasz"}				-- respond for messages from this players (nick names)
local GO_TO_HOUSE = {"run"}
local LEAVE_HOUSE = {"leave"}
local CHECK_BACKPACK_OPEN = {"backpack"}
local SPELL_TO_LEAVE_HOUSE = "alana sio \"" .. Self.Name()


local flaga = false
local flagaleave = false
local flagafood = false

-- DONT EDIT BELOW THIS LINE

RESPOND_TO = table.lower(RESPOND_TO)

function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if table.find(RESPOND_TO, string.lower(msg.speaker)) then

            if table.find(GO_TO_HOUSE, string.lower(msg.message)) then
                createOrderToGoToTheHouse()
            end
            
            if table.find(LEAVE_HOUSE, string.lower(msg.message)) then
                createOrderToLeaveTheHouse()
            end
            if table.find(CHECK_BACKPACK_OPEN, string.lower(msg.message)) then
                createOrderToOpenBackpack()
            end   			
		end	
	end 
end 

function executeOrder()

    if(flaga) then
        for i=1, 10 do
            Self.WalkTo(BACK_TO.x,BACK_TO.y,BACK_TO.z)
            wait(200)
        end
        flaga = false
    end

    if(flagaleave) then
        Self.Say(SPELL_TO_LEAVE_HOUSE)
        flagaleave = false
    end

    if(flagafood) then
        Container.CloseAll()
        wait(2000)
        Self.OpenMainBackpack()
        wait(1000)
        Map.UseItem(BACKPACK_POSITION.x, BACKPACK_POSITION.y , BACKPACK_POSITION.z, BACKPACK_ID, 2, 200)
        flagafood = false
    end
end	

function createOrderToGoToTheHouse(msg)
    flaga = true
end

function createOrderToLeaveTheHouse(msg)
    flagaleave = true
end

function createOrderToOpenBackpack(msg)
    flagafood = true
end	

-- module to run in loop
Module.New("Message responder", function()
	executeOrder()
end)

-- register new proxy
Proxy.New("proxy")