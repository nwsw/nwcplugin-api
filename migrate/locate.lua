---------------------------------------------------------------------------------------------------------
-- You can use this function to help in migrating to the new nwc.ntnidx and nwc.drawpos system,
-- which no longer offers locate methods. To use it, replace all '(nwcdraw|nwcplay).locate' calls
-- with a call to 'mylocate'
local function mylocate(ObjType,parm2,parm3)
	local isDraw = nwcdraw.isDrawing()
	local searchObj = isDraw and nwc.drawpos or nwc.ntnidx
	local foundIt = true
	local objfind = string.lower(ObjType)
	local p2find = (objfind == "user") and parm2
	local count = (p2find and parm3 or parm2) or 1
	local countinc = (count > 0) and 1 or -1
	local dirfind = (count > 0) and "next" or "prior"

	if objfind == "item" then objfind = nil end
	if not p2find then p2find = nil end

	while foundIt and not (count == 0) do
		foundIt = searchObj:find(dirfind,objfind,p2find)
		count = count - countinc
	end

	if not foundIt then
		searchObj:find((countinc < 0) and "first" or "last")
	end

	local retName = (foundIt and ObjType) or string.lower(searchObj:objType())

	if isDraw then
		local x,y = searchObj:xyRight()
		local y2 = y

		local noteCount = searchObj:noteCount()
		if noteCount > 0 then
			y = searchObj:notePos(1)
			y2 = searchObj:notePos(noteCount)
		end

		return x,y,y2,retName
	end

	-- if searchObj is after current user position, then we need the song position of the item just after the target
	if searchObj > 0 then searchObj:find('next') end

	return searchObj:sppOffset(),retName
end
---------------------------------------------------------------------------------------------------------
