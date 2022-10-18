local hourOfTime = tonumber(os.date("%H")); dayOfWeek = tonumber(os.date("%w"))
local device = {id1 = 114, id2 = 39, controlDeviceId = 150}; scena = "Scene196"
local Result = {ON = "turnOn", OFF = "turnOff", KEEP = "keep"}
local temp = {t1 = 18, t2 = 20.0, hist = 0.2}

if(dayOfWeek == 0) then  dayOfWeek = 7 end

local grandmanderVal = { temp = tonumber(fibaro.getValue(device.id1, "value")), hourOfTime = hourOfTime, dayOfWeek = dayOfWeek }

local grandmander = { 
    name = "Pokoj Babci",
    temp = temp.t1,
    items = 
    {
        {
            rangH = {        { start = 7, endd = 21 }   },
            rangD = {        { start = 1, endd = 7 }    },    
            name = "tryb dzien od pon-nie",
            temp = temp.t2
        }
    }
}

local livingroomVal = { temp = tonumber(fibaro.getValue(device.id2, "value")),  hourOfTime = hourOfTime, dayOfWeek = dayOfWeek }

local livingroom = {
    name = "Salon",
    temp = temp.t1,
    items = 
        {
            {    
                rangH = {        { start = 6, endd = 8 },        { start = 13, endd = 21 }    },
                rangD = {        { start = 1, endd = 5 }    },
                name = "tryb dzien od pon-pt",
                temp = temp.t2
            }, 
            {
                rangH = {        { start = 7, endd = 21 }   },
                rangD = {        { start = 6, endd = 7 }    },
                name = "tryb dzien od sob-nie",
                temp = temp.t2
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
    -- fibaro.debug(scena, "temperatura w " .. room.name .. " jest " .. roomVal.temp .. " max " .. tempVal.temp .." => jest " .. tempVal.name .. " => rezultat " .. result )
    return {
        result = result,
        message = "temperatura w " .. room.name .. " jest " .. roomVal.temp .. " max " .. tempVal.temp .." => jest " .. tempVal.name .. " => rezultat " .. result
    }
end

function generateResult(tempVal, roomVal)
    -- fibaro.debug(scena, tempVal.temp .. ">>>>>" .. " >= " .. (tempVal.temp - temp.hist) .. " xx " .. roomVal.temp ..  " >= " ..  tempVal.temp + temp.hist )
    if roomVal.temp <= (tempVal.temp - temp.hist) then return Result.ON elseif roomVal.temp <= (tempVal.temp + temp.hist)  then return Result.KEEP else return Result.OFF end
end

function selectItems(items, name, value, operator )
    local result = {}; i = 0
    for k,item in pairs(items) do         
        for k,rangDay in pairs(item[name]) do 
            local isActive = operator(rangDay , value)
            -- fibaro.debug(scena, "selectItems " .. tostring(isActive) .. " " ..  item.name .. " " .. value .. " TO " .. rangDay.start )
            if isActive then result[i] = item;  i = i + 1 end
        end
    end
    return result
end

function getTempProces(item, room) 
    if(item == nil ) then return  {temp = room.temp, name = "tryb noc" }  else return  {temp = item.temp, name = item.name } end
end

local resultLR = openSwitch(livingroom, livingroomVal)
local resultGM = openSwitch(grandmander, grandmanderVal)
local message = "<br>" .. resultLR.message .. "<br>" .. resultGM.message

if resultLR.result == Result.ON or resultGM.result == Result.ON  then
    message  = "akcja na piecu turnOn" .. message 
    -- fibaro.call(device.controlDeviceId, Result.ON)
elseif (resultLR.result == Result.OFF and resultGM.result == Result.OFF) then
    message  = "akcja na piecu turnOff" .. message 
    -- fibaro.call(device.controlDeviceId, Result.OFF)
else
    message  = "STAN NIEUSTALONY !!!!!!!!! ach ta histereza" .. message 
end

fibaro.debug(scena, message)

if(resultLR.result == Result.ON) then
  fibaro.debug(scena, "isLivingroom extra action on ON")
elseif (resultLR.result == Result.OFF) then
    fibaro.debug(scena, "isLivingroom extra action on OFF")
end
