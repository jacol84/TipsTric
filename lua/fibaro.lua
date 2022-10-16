local hourOfTime = tonumber(os.date("%H"))
local dayOfWeek = tonumber(os.date("%w"))
local device = {id1 = 114, id2 = 39, controlDeviceId = 150} -- tu trzeba podać id pomiaru 1 i 2
local scena = "Scene195"

local temp = {    t1 = 20,    t2 = 18    }

local grantM = { 
    name = "Pokoj Babci",
    temp = tonumber(fibaro.getValue(device.id1, "value")),
    items = 
    {
        {
            rangH = {        { start = 7, endd = 21 }   },
            rangD = {        { start = 1, endd = 7 }    },    
            name = "caly tydzine pon-nie"
        }
    }
}


local livingroom = {
    name = "Salon",
    temp = tonumber(fibaro.getValue(device.id2, "value")),
    items = 
        {
            {    
                rangH = {        { start = 6, endd = 8 },        { start = 13, endd = 21 }    },
                rangD = {        { start = 1, endd = 5 }    },
                name = "tydzien pon-pt"
            }
            , 
            {
                rangH = {        { start = 7, endd = 21 }   },
                rangD = {        { start = 6, endd = 7 }    },
                name = "weekend sob-nie"
            }
        }
}

function less(rang, value) 
    return  rangDay.start <= value and rangDay.endd > value
end

function eqOrless(rang, value) 
    return  rangDay.start <= value and rangDay.endd >= value
end

function openSwitch(room)
    local itemsD = selectItems(room.items, "rangD", dayOfWeek, eqOrless) 
    local itemsH = selectItems(itemsD, "rangH", hourOfTime, less)
    local item = itemsH[0]
    local tempInRomm = getTempProces(itemsH)

    if tempInRomm.temp >= room.temp then
        fibaro.debug(scena, "temperatura w " .. room.name .. " jest " .. room.temp .. " obecnie jest " .. item.name .. " jest " .. tempInRomm.name .. " zal" )
        return true
    end
    fibaro.debug(scena, "temperatura w " .. room.name .. " jest " .. room.temp .. " obecnie jest " .. item.name .. " jest " .. tempInRomm.name .. " wyl" )
    return false
end

function selectItems(items, name, value, operator )
    local result = {}
    for k,item in pairs(items) do         
        for k,rangDay in pairs(item[name]) do 
            -- fibaro.debug(scena, "selectItemsByDay " .. dayOfWeek .. " TO " .. rangDay.start )
            if operator(rangDay , value) then
                table.insert( result, item)
            end
        end
    end
    return result
end

function getTempProces(items) 
    if(table.getn(itemsH) > 0) then
        return  { isDay=true, temp=temp.t1 , name = "tryb dzin" }
    else
        return  { isDay=false, temp=temp.t2, name = "tryb noc" }
    end
end


if openSwitch(grantM) or openSwitch(livingroom) then
    fibaro.debug(scena,"turnOn")
    -- fibaro.call(device.controlDeviceId, "turnOff")
else
    fibaro.debug(scena,"turnOff")
    -- fibaro.call(device.controlDeviceId, "turnOn")
end
