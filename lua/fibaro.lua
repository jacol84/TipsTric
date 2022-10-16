local hourOfTime = tonumber(os.date("%H"))
local dayOfWeek = tonumber(os.date("%w"))
local idDevice_1 = 114 --tu trzeba podac id pomiaru 1
local idDevice_2 = 39 -- tu trzeba podać id pomiaru 2
local controlDeviceId = 150 --tu trzeba podac id ktorym chcesz sterowac
local scena = "Scene195"

local T1_1 = tonumber(fibaro.getValue(idDevice_1, "value"))
local T2_1 = tonumber(fibaro.getValue(idDevice_2, "value"))


local temp = {    t1 = 20,    t2 = 18    }

local grantM = { 
    name = "Pokoj Babci",
    temp = tonumber(fibaro.getValue(idDevice_1, "value")),
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
    temp = tonumber(fibaro.getValue(idDevice_2, "value")),
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


function openSwitch(room)

    local itemByDay = selectItemByDay(room.items)
    local tempInRomm = selectIsDay(itemByDay.rangH)

    if tempInRomm.temp >= room.temp then
        fibaro.debug(scena, "temperatura w " .. room.name .. " jest " .. room.temp .. " obecnie jest " .. itemByDay.name .. " jest " ..tempInRomm.name .. " zal" )
        return true
    end
    fibaro.debug(scena, "temperatura w " .. room.name .. " jest " .. room.temp .. " obecnie jest " .. itemByDay.name .. " jest " ..tempInRomm.name .. " wyl" )
    return false
end

function selectItemByDay(items)
    for k,item in pairs(items) do 
        for k,rangDay in pairs(item.rangD) do 
            -- fibaro.debug(scena, "selectItemByDay " .. dayOfWeek .. " TO " .. rangDay.start )

            if rangDay.start <= dayOfWeek and rangDay.endd >= dayOfWeek then
                return item
            end
        end
    end
    return { name="brak" }
end


function selectIsDay(ranges)
    for k, rang in pairs(ranges) do 
        -- fibaro.debug(scena, "selectIsDay " .. hourOfTime .. " TO " .. rang.start .. " TO " .. rang.endd )
        if rang.start <= hourOfTime and rang.endd > hourOfTime then
            return { isDay=true, temp=temp.t1 , name = "tryb dzin" }
        end
    end
    return { isDay=false, temp=temp.t2, name = "tryb noc" }
end

switchGrant = openSwitch(grantM)
switchLiwingroom = openSwitch(livingroom)

if switchGrant or switchLiwingroom then
    fibaro.debug(scena,"turnOn")
    -- fibaro.call(controlDeviceId, "turnOff")
else
    fibaro.debug(scena,"turnOff")
    -- fibaro.call(controlDeviceId, "turnOn")
end
