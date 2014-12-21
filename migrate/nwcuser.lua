---------------------------------------------------------------------------------------------------------
-- You can use this nwcuser object to help in migrating to the new nwc.ntnidx and nwc.drawpos system,
-- which no longer support a nwcuser object
local nwcuser = {}
 
nwcuser.item = nwc.ntnidx.new()
 
nwcuser.gotoPos = function(idx)
	nwcuser.item:reset()
	idx = idx or 0
	while (idx < 0) and nwcuser.item:find("prior") do idx = idx + 1	end
	while (idx > 0) and nwcuser.item:find("next") do idx = idx - 1	end
end

nwcuser.getObjType = function(idx)
	nwcuser.gotoPos(idx)
	return nwcuser.item:objType()
end
 
nwcuser.getStaffPos = function(idx)
	nwcuser.gotoPos(idx)
	return nwcuser.item:staffPos()
end
 
nwcuser.getPropTable = function(idx)
	nwcuser.gotoPos(idx)
	return nwcuser.item:propTable()
end
 
nwcuser.getUserType = function(idx)
	nwcuser.gotoPos(idx)
	return nwcuser.item:userType()
end
 
nwcuser.getUserProp = function(p1,...)
	local args = {...}
	nwcuser.item:reset()
	if #args > 0 then
		nwcuser.gotoPos(p1)
		return nwcuser.item:userProp(...)
	else
		return nwcuser.item:userProp(p1)
	end
end
 
nwcuser.getNoteCount = function(idx)
	nwcuser.gotoPos(idx)
	return nwcuser.item:noteCount()
end
 
nwcuser.getNotePos = function(idx,...)
	local args = {...}
	nwcuser.item:reset()
	if #args > 0 then
		nwcuser.gotoPos(idx)
		return nwcuser.item:notePos(...)
	else
		return nwcuser.item:notePos(idx)
	end
end
 
nwcuser.getNotePitchPos = function(idx,...)
	local args = {...}
	nwcuser.item:reset()
	if #args > 0 then
		nwcuser.gotoPos(idx)
		return nwcuser.item:notePitchPos(...)
	else
		return nwcuser.item:notePitchPos(idx)
	end
end
 
nwcuser.find = function(action,...)
	nwcuser.item:reset()
	assert((action ~= "before") and (action ~= "after"),"manual script fix required for before/after find operation")
	if not nwcuser.item:find(action,...) then return Nil end
	return nwcuser.item:indexOffset()
end
 
---------------------------------------------------------------------------------------------------------
