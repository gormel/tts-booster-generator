--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]

--[[ The onLoad event is called after the game save finishes loading. --]]
function onLoad()
    --[[ print('onLoad!') --]]
end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    --[[ print('onUpdate loop!') --]]
end

function createBooster(player)
    local booster = {}
    local objects = player.getSelectedObjects()
    addCards(findDeck("commons", objects), booster, 11)
    addCards(findDeck("uncommons", objects), booster, 3)
    addCards(findDeck("rares", objects), booster, 1)

    local stack = booster[1]
    for i = 2, #booster do
        local card = booster[i]
        stack = stack.putObject(card)
    end
end

function addCards(deck, booster, count)
    local cards = deck.getObjects()
    for i = 1, count do
        local index = math.random(#cards)
        local card = cards[index]
        local takenCard = deck.takeObject({index = card.index})
        local clonedCard = takenCard.clone()
        deck.putObject(takenCard)
        table.insert(booster, clonedCard)
    end
end

function findDeck(name, objects)
    for i, obj in ipairs(objects) do
        if (obj.getName() == name) then
            return obj
        end
    end
    error("Failed to find deck '" .. name .. "'")
end
