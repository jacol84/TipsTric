local hourOfTime = tonumber(os.date("%H")); dayOfWeek = tonumber(os.date("%w"))
local device = {id1 = 114, id2 = 39, controlDeviceId = 150}; scena = "Scene196"
local Result = {ON = "turnOn", OFF = "turnOff", KEEP = "keep"}


if(dayOfWeek == 0) then
   dayOfWeek = 7
end

local hist = 0.2

local grandmanderVal = {
    temp = tonumber(fibaro.getValue(device.id1, "value")),
    hourOfTime = hourOfTime,
    dayOfWeek = dayOfWeek
}

local grandmander = { 
    name = "Pokoj Babci",
    temp = 18,
    items = 
    {
        {
            rangH = {        { start = 7, endd = 21 }   },
            rangD = {        { start = 1, endd = 7 }    },    
            name = "tryb dzien od pon-nie",
            temp = 20
        }
    }
}

local livingroomVal = {
    temp = tonumber(fibaro.getValue(device.id2, "value")),
    hourOfTime = hourOfTime,
    dayOfWeek = dayOfWeek
}

local livingroom = {
    name = "Salon",
    temp = 18,
    items = 
        {
            {    
                rangH = {        { start = 6, endd = 8 },        { start = 13, endd = 21 }    },
                rangD = {        { start = 1, endd = 5 }    },
                name = "tryb dzien od pon-pt",
                temp = 20
            }
            , 
            {
                rangH = {        { start = 7, endd = 21 }   },
                rangD = {        { start = 6, endd = 7 }    },
                name = "tryb dzien od sob-nie",
                temp = 20
            }
        }
}

function less(rang, value) 
    -- fibaro.debug(scena, "less " .. rang.start .. "<=" .. value .. "<" ..rang.endd )
    return  rang.start <= value and rang.endd > value
end

function eqOrless(rang, value) 
    -- fibaro.debug(scena, "eqOrless " .. rang.start .. "<=" .. value .. "<=" ..rang.endd )
    return  rang.start <= value and rang.endd >= value
end

function openSwitch(room, roomVal)
    local itemsD = selectItems(room.items, "rangD", roomVal.dayOfWeek, eqOrless) 
    local itemsH = selectItems(itemsD, "rangH", roomVal.hourOfTime, less)
    local item = itemsH[0]
    local tempVal = getTempProces(item, room)

    local result = generateResult(tempVal, roomVal)

    fibaro.debug(scena, "temperatura w " .. room.name .. " jest " .. roomVal.temp .. " => jest " .. tempVal.name .. " => rezultat " .. result )

    return {
        result = result,
        message = "temperatura w " .. room.name .. " jest " .. roomVal.temp .. " => jest " .. tempVal.name .. " => rezultat " .. result
    }
end

function generateResult(tempVal, roomVal)
    if tempVal.temp >= (roomVal.temp - hist) then
        return Result.ON
    else if tempVal.temp >= (roomVal.temp + hist)  then
        return Result.KEEP
    else
        return Result.OFF
    end
end



function selectItems(items, name, value, operator )
    local result = {}; i = 0
    for k,item in pairs(items) do         
        for k,rangDay in pairs(item[name]) do 
            local isActive = operator(rangDay , value)
            -- fibaro.debug(scena, "selectItems " .. tostring(isActive) .. " " ..  item.name .. " " .. value .. " TO " .. rangDay.start )
            if isActive then
                -- fibaro.debug(scena, "selectItems " .. "dodane " .. item.name )
                result[i] = item
                i = i + 1
            end
        end
    end
    return result
end

function getTempProces(item, room) 
    if(item == nil ) then
        return  {temp = room.temp, name = "tryb noc" }
    else
        return  {temp = item.temp, name = item.name }
    end
end

local resultLR = openSwitch(livingroom, livingroomVal)
local resultGM = openSwitch(grandmander, grandmanderVal)
fibaro.debug(scena,"\n ".. resultLR.message .. "\n" .. resultGM.message)

if resultLR.result == Result.ON or resultGM.result == Result.ON  then
    fibaro.debug(scena,"turnOn")
    -- fibaro.call(device.controlDeviceId, "turnOff")
else if (resultLR.result == Result.OFF and resultGM.result == Result.OFF) then
    fibaro.debug(scena,"turnOff")
    -- fibaro.call(device.controlDeviceId, "turnOn")
else
    fibaro.debug(scena,"STAN NIE USTALONY !!!!!!!!! ach ta histereza")
end

if(resultLR.result == Result.ON) then
  fibaro.debug(scena, "isLivingroom extra action on ON")
else if (resultLR.result == Result.OFF) then
    fibaro.debug(scena, "isLivingroom extra action on OFF")
end
