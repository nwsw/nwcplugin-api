---------------------------------------------------------------------------------------------------------
-- You can use this function to help in migrating to the new nwc.ntnidx and nwc.drawpos system,
-- which no longer offers a nwcdraw.locate method. To use it, replace all 'nwcdraw.locate' calls
-- with a call to 'mylocate'
local function mylocate(ObjType,parm2,parm3)
	local user = nwcdraw.user
	local foundIt = true
	local objfind = string.lower(ObjType)
	local p2find = (objfind == "user") and parm2
	local count = (p2find and parm3 or parm2) or 1
	local countinc = (count > 0) and 1 or -1
	local dirfind = (count > 0) and "next" or "prior"

	if objfind == "item" then objfind = nil end
	if not p2find then p2find = nil end

	while foundIt and not (count == 0) do
		foundIt = user:find(dirfind,objfind,p2find)
		count = count - countinc
	end

	if not foundIt then
		user:find((countinc < 0) and "first" or "last")
	end

	local x,y = user:xyRight()
	local y2 = y
	local retName = (foundIt and ObjType) or string.lower(user:objType())

	local noteCount = user:noteCount()
	if noteCount > 0 then
		y = user:notePos(1)
		y2 = user:notePos(noteCount)
	end

	return x,y,y2,retName
end
---------------------------------------------------------------------------------------------------------
