--      __     ___  ___  ____ --
--  __ / /__ _/ _ )/ _ \/  _/ --
-- / // / _ `/ _  / ___// /   --
-- \___/\_,_/____/_/  /___/   --
--------------------------------



--------------------
-- INIT Variables --
--------------------

local functs = {}

local playerNbt = {}

local maxStats = {
	100,
	100,
	100,
	100
}

local rawStats = {
	0,
	0,
	0,
	0
}

local NStats = {
	0,
	0,
	0,
	0
}

local doAnims = true

local anims = {
	nil,
	nil,
	nil,
	nil
}

local visualStats = {
	0,
	0,
	0,
	0
}

local actualStats = {
	0,
	0,
	0,
	0
}

local timer = 99

-- End INIT Variables --

----------------
-- Max Values --
----------------

function functs.setMaxStats(a,b,c,d)
	maxStats = {a,b,c,d}
	
	for key, value in pairs(maxStats) do
		if value == nil then
			maxStats[key] = 100
		end
	end
	
end

-- End Max Values --



----------------
-- Raw Values --
----------------

function updateRawStats()
	rawStats = {
		playerNbt["ForgeCaps"]["jab:player_variables"]["fat"],
-------------------------------------------------------------------------		
		playerNbt["ForgeCaps"]["jab:player_variables"]["stuffing"]  
		+  
		playerNbt["ForgeCaps"]["jab:player_variables"]["heavygas"]  
		+  
		playerNbt["ForgeCaps"]["jab:player_variables"]["neutralgas"]  
		+  
		playerNbt["ForgeCaps"]["jab:player_variables"]["buoyantgas"],
-------------------------------------------------------------------------
		playerNbt["ForgeCaps"]["jab:player_variables"]["stuffing"],
-------------------------------------------------------------------------
		playerNbt["ForgeCaps"]["jab:player_variables"]["heavygas"]  
		+  
		playerNbt["ForgeCaps"]["jab:player_variables"]["neutralgas"]  
		+  
		playerNbt["ForgeCaps"]["jab:player_variables"]["buoyantgas"]
	}
end

function functs.getRawStats()
	return
		rawStats
end

function functs.getFat()
	return 
		rawStats[1]
end

----------------

function functs.getFill()
	return 
		rawStats[2]
end

----------------

function functs.getStuffing()
	return 
		rawStats[3]
end

----------------

function functs.getInflation()
	return 
		rawStats[4]
end

-- End Raw Values --



-----------------------
-- Normalized Values --
-----------------------

function updateNStats()
	for key, value in pairs(NStats) do
		NStats[key] = (visualStats[key])/(maxStats[key])
	end
end

function functs.getNStats()
	return
		NStats
end

function functs.getNFat()
	return 
		NStats[1]
end

-------------------------------------

function functs.getNFill()
	return 
		NStats[2]
end

-------------------------------------

function functs.getNStuffing()
	return 
		NStats[3]
end

-------------------------------------

function functs.getNInflation()
	return 
		NStats[4]
end

-- End Normalized Values --



-------------------
-- Do Anim Logic --
-------------------

function functs.doAnimLogic(x)
	doAnims = x
end

-- End Do Anim Logic --



----------------
-- Animations --
----------------

function pings.statUpdate(a,b,c,d)
	actualStats = {a,b,c,d}
end

function updateVisualStats()
	for key, value in pairs(visualStats) do
		visualStats[key] = math.lerp(value,actualStats[key],.02)
	end
end

function functs.setAnims(a,b,c,d)
	anims = {a,b,c,d}
	for key, value in pairs(anims) do
		if value ~= nil then
			value:play()
			value:pause()
		end
	end
end

function jabAnims()
	for key, value in pairs(anims) do
		if value ~= nil and NStats[key] <= 1 then
			value:setTime(math.lerp(value:getTime(),value:getLength()*NStats[key],.9))
			value:setBlend(1)
			
		elseif value ~= nil then
			value:setTime(value:getLength())
			value:setBlend(NStats[key])
		end
	end
end

-- End Animations --



-------------
-- Updates --
-------------

function events.tick()
	playerNbt = player:getNbt()
	if playerNbt["ForgeCaps"]["jab:player_variables"] ~= nil then
		updateRawStats()
		if timer >= 10 then
			pings.statUpdate(functs.getFat(),functs.getFill(),functs.getStuffing(),functs.getInflation())
			timer = 0
		else
			timer = timer + 1
		end
	end
end

function events.render(_,context)
	updateVisualStats()
	updateNStats()
	if doAnims == true then
		jabAnims()
	end
end

-- End Updates --

return functs