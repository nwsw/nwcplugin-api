-- Version 1.0

--[[----------------------------------------------------------------
xyAnalyzer.demo

This is a demonstration script. It spins through the {drawpos}:xy
methods, showing the coordinate that each returns for the drawpos
just preceding it.
--]]----------------------------------------------------------------

-- our object type is passed into the script
local userObjTypeName = ...

local function getMatchingTableEntry(t, fval)
	for i, v in ipairs(t) do
		if v == fval then return i end
	end
	return nil
end

--------------------------------------------------------------------
local validMethods = {'xyAnchor','xyTimeslot','xyLyric','xyRight','xyAlignAnchor','xyStemAnchor','xyStemTip','xyNoteHead','xyNoteAccidental'}
local validDirections = {'nil','-1','+1'}
local validLyricNumber = {'1','2','3','4'}
local validNoteNumber = {'nil','1','2','3'}
local validParm1 = {
	xyAnchor = validDirections,
	xyTimeslot = validDirections,
	xyLyric = validLyricNumber,
	xyRight = validDirections,
	xyAlignAnchor = validDirections,
	xyStemAnchor = validDirections,
	xyStemTip = validDirections,
	xyNoteHead = validNoteNumber,
	xyNoteAccidental = validNoteNumber,
	}

local obj_spec = {
	{ id='Method', label='drawidx Method', type='enum', default=validMethods[1], list=validMethods},
	{ id='Parm1', label='Function Parm 1', type='text', default='nil' },
}

local function do_create(t)
	t.Method = validMethods[1]
	t.Parm1 = 'nil' -- tonumber() will make this nil in the draw method
end

local function do_spin(t,d)
	local m = t.Method
	local p1 = t.Parm1
	local p1valid = validParm1[m] or validParm1.xyAnchor
	local i = getMatchingTableEntry(p1valid,p1) or 1

	i = i + d
	if p1valid[i] then
		t.Parm1 = p1valid[i]
		return
	end

	i = getMatchingTableEntry(validMethods,m)
	i = i + ((d > 0) and 1 or -1)

	if i < 1 then
		i = #validMethods
	elseif i > #validMethods then
		i = 1
	end

	t.Method = validMethods[i]
	p1valid = validParm1[t.Method]
	t.Parm1 = (d > 0) and p1valid[1] or p1valid[#p1valid]
end

--------------------------------------------------------------------
local user = nwcdraw.user
local dpos = nwc.drawpos
local idx = nwc.ntnidx
--
local function do_draw(t)
	local m = t.Method or validMethods[1]
	local p1 = tonumber(t.Parm1)

	local m_func = dpos[m]
	if not m_func then return end

	if p1 then m = m..'('..p1..')' else m = m..'()' end

	nwcdraw.setFont("Courier New",3)
	local w,h = nwcdraw.calcTextSize(m)

	if not nwcdraw.isDrawing() then return w end

	nwcdraw.alignText('top','right')

	if dpos:find("prior") then
		nwcdraw.text(m)

		local x,y,v3 = m_func(dpos,p1)
		if x then
			local cx = 0.3
			local cy = cx*nwcdraw.getAspectRatio()
			nwcdraw.moveTo(-w,0)
			nwcdraw.hintline(x,y)
			nwcdraw.ellipse(cx,cy)
			if v3 then
				nwcdraw.moveTo(0,-h)
				nwcdraw.text(v3)
			end
		else
			nwcdraw.moveTo(0,-h)
			nwcdraw.text('(nil)')
		end
	end
end

--------------------------------------------------------------------
return {
	spec	= obj_spec,
	create	= do_create,
	spin	= do_spin,
	width	= do_draw,
	draw	= do_draw,
	}
