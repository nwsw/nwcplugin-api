-- Version 0.1

--[[----------------------------------------------------------------
xyAnalyzer.demo

This is a demonstration script. It spinds through the {drawpos}:xy
methods, showing the coordinate that each returns for the drawpos
just before it.
--]]----------------------------------------------------------------

-- our object type is passed into the script
local userObjTypeName = ...

local EXTRAWIDTH = 2

local function getMatchingTableEntry(t, fval)
	for i, v in ipairs(t) do
		if v == fval then return i end
	end
	return nil
end

--------------------------------------------------------------------
local validMethods = {"xyAnchor","xyTimeslot","xyLyric","xyRight","xyAlignAnchor","xyStemAnchor","xyStemTip"}

local function do_create(t)
	t.Method = validMethods[1]
	t.Parm1 = 0
end

local function do_spin(t,d)
	local m = t.Method or validMethods[1]
	local i = getMatchingTableEntry(validMethods,m)
	i = i + ((d > 0) and 1 or -1)

	if i < 1 then
		i = #validMethods
	elseif i > #validMethods then
		i = 1
	end

	t.Method = validMethods[i]
end

--------------------------------------------------------------------
local user = nwcdraw.user
local dpos = nwc.drawpos
local idx = nwc.ntnidx
--
local function do_draw()
	local m = user:userProp('Method') or validMethods[1]
	local p1 = tonumber(user:userProp('Parm1'))

	local m_func = dpos[m]
	if not m_func then return end

	if p1 then m = m..'('..p1..')' else m = m..'()' end
	local w,h = nwcdraw.calcTextSize(m)

	if not nwcdraw.isDrawing() then return w + EXTRAWIDTH end

	nwcdraw.alignText('bottom','right')

	if dpos:find("prior") then
		nwcdraw.text(m)

		local x,y = m_func(dpos,p1)
		if x then
			nwcdraw.moveTo(0,0)
			nwcdraw.hintline(x,y)
			nwcdraw.ellipse(0.33,.75)
		else
			nwcdraw.moveTo(0,-h)
			nwcdraw.text('(nil)')
		end
	end
end

--------------------------------------------------------------------
return {
	create	= do_create,
	spin	= do_spin,
	width = do_draw,
	draw = do_draw,
	}
