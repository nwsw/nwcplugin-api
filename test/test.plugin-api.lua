------------------------------------------------------------------------------------
-- This script is intended only as a test mechanism for the new, evolving user
-- plugin api. This file will not appear in the official release of NWC 2.75, so
-- test objets that it adds should be used only for testing.
------------------------------------------------------------------------------------

-- Each test object created by this file starts with a definition using this
-- NewObjectSpec variable. You can search for this variable name to find each
-- new object definition in the file below.
local NewObjectSpec = '|User|...'

local DefaultChordFontFace = nwc.hasTypeface("MusikChordSerif") and "MusikChordSerif" or "Arial"

local function setPenOpts(defStyle)
	local penstyle = nwcuser.getUserProp("Pen") or (defStyle or "solid")
	local penwidth = tonumber(nwcuser.getUserProp("Thickness:")) or 175
	nwcdraw.setPen(penstyle, penwidth);
end

local function getSpan(defaultSpan)
	defaultSpan = defaultSpan or 2
	return tonumber(nwcuser.getUserProp("Span:") or defaultSpan)
end

local function getFont(defaultFont)
	defaultFont = defaultFont or "StaffItalic"

	local useFont = nwcuser.getUserProp("Font:") 

	if not useFont then
		local firstOfObj = nwcuser.find("first","user",nwcuser.getUserType())
		if firstOfObj then
			useFont = nwcuser.getUserProp(firstOfObj,"Font:") 
		end
	end

	if tonumber(useFont) ~= nil then
		useFont = "User"..useFont
	end

	return useFont or defaultFont
end


------------------------------------------------------------------------------------
-- NewObjectSpec = '|User|test.debug'
------------------------------------------------------------------------------------
local function draw_testDebug()
	local m1 = nwc.memusage()
	local m2 = "KB"

	nwcdraw.setFontClass("PageSmallText")
	local x1,y1 = nwcdraw.calcTextSize(m1)
	local x2,y2 = nwcdraw.calcTextSize(m2)
	--nwc.debug("Memory Used:",m1)
	nwcdraw.moveTo(-x1/2)
	nwcdraw.text(m1)
	nwcdraw.moveTo(-x2/2,-y1)
	nwcdraw.text(m2)
end

-- we only set a draw hook for this object, as their really is no need for
-- most users to add it
nwc.sethook("userdraw","test.debug",draw_testDebug)

------------------------------------------------------------------------------------
NewObjectSpec = '|User|test.boxtext|Angle:[#0-360]0|Pen:solid|Thickness:[#1-1000]350|Typeface:[*]Arial|Size:[#.#]6|Text:[*]Hello World'
------------------------------------------------------------------------------------
local function draw_test_boxtext()
	local xyar = nwcdraw.getAspectRatio()

	local function rotate(x,y,r)
		y = y / xyar
		return (x*math.cos(r) - y*math.sin(r)),((x*math.sin(r) + y*math.cos(r))*xyar)
	end

	local angle = tonumber(nwcuser.getUserProp("Angle:")) or 0
	nwcdraw.alignText("top","left")
	nwcdraw.setTypeface(nwcuser.getUserProp("Typeface:") or "Arial")
	nwcdraw.setFontSize(nwcuser.getUserProp("Size:"))
	setPenOpts()

	local t = nwcuser.getUserProp("Text:")
	local w,h = nwcdraw.calcTextSize(t)
	nwcdraw.angleText(t,angle)

	local angleRad = math.rad(angle)
	nwcdraw.moveTo(0,0)
	nwcdraw.line(rotate(0,-h,angleRad))
	nwcdraw.line(rotate(w,-h,angleRad))
	nwcdraw.line(rotate(w,0,angleRad))
	nwcdraw.line(0,0)
end

nwc.addUserObjType({
	spec = NewObjectSpec,
	draw = draw_test_boxtext,
	})

------------------------------------------------------------------------------------
NewObjectSpec = '|User|test.8va|Span:[#1-32]2|Pen:[@PenStyle]dash|Thickness:[#1-500]150'
------------------------------------------------------------------------------------
local function draw_test8va()
	local span = getSpan()
	local targetx,ytop,ybtm,termtype = nwcdraw.locate("note",span)

	nwcdraw.alignText("top","left")

	nwcdraw.setFontClass(getFont())
	local w,h = nwcdraw.calcTextSize("8")
	nwcdraw.moveTo(0,h/2)
	nwcdraw.text("8")
	nwcdraw.setFontSize(nwcdraw.getFontSize()*0.65)
	local w2,h2 = nwcdraw.calcTextSize("va")
	nwcdraw.text("va")

	setPenOpts("dash")
	nwcdraw.moveTo(w+w2+0.2,0)
	nwcdraw.line(targetx,0)
	nwcdraw.line(targetx,-2)
end

nwc.addUserObjType({
	spec = NewObjectSpec,
	draw = draw_test8va,
	})

------------------------------------------------------------------------------------
NewObjectSpec = '|User|test.slur|Span:[#1-32]2|Dir:[@SlurDirection]Upward|Pen:[@PenStyle]dash|Thickness:[#1-500]240|Arcpt:[@Coordinate]0.35,3|EndOffset:[@Coordinate]-0.3,2.0'
------------------------------------------------------------------------------------
local function draw_testSlur()
	local direction = nwcuser.getUserProp("Dir") or "Upward"
	local span = getSpan()
	local arcpt = nwcuser.getUserProp("Arcpt") or "0.5,0"
	local arcpt_x = tonumber(arcpt:match("([%.%d]+),"))
	local arcpt_Y = tonumber(arcpt:match(",([%.%-%d]+)"))
	local x_dest,staffposTop,staffposBtm,objtype = nwcdraw.locate("note",span)
	local endoffset = nwcuser.getUserProp("EndOffset")
	local target_y = staffposTop
	
	if (direction == "Downward") then target_y = staffposBtm end

	if endoffset then
		x_dest = x_dest + tonumber(endoffset:match("([%.%-%d]+)"));
		target_y = target_y + tonumber(endoffset:match(",([%.%-%d]+)"));
	end

	arcpt_x = arcpt_x*x_dest

	setPenOpts()
	nwcdraw.curve(direction,0,0,arcpt_x,arcpt_Y,x_dest,target_y)
end

nwc.addUserObjType({
	spec = NewObjectSpec,
	draw = draw_testSlur,
	})

------------------------------------------------------------------------------------
NewObjectSpec = '|User|test.chordfun|Span:[#1-32]1|Name:[*]C'
------------------------------------------------------------------------------------

local chordKeys = {
	['']	=	{1,5,8},
	['M']	=	{1,5,8},
	['m']	=	{1,4,8},
	['dim']	=	{1,4,7},
	['aug']	=	{1,5,9},
	['sus']	=	{1,6,8},
	['6']	=	{1,5,8,10},
	['m6']	=	{1,4,8,10},
	['7']	=	{1,5,8,11},
	['dim7']=	{1,4,7,10},
	['m7']	=	{1,4,8,11},
	['m7b5']=	{1,4,7,11},
	['M7']	=	{1,5,8,12},
	['7sus']=	{1,6,8,11},
	['9']	=	{1,5,8,11,15},
	['m9']	=	{1,4,8,11,15},
	['M9']	=	{1,5,8,12,15},
	}

local notenameShift = {
	['Cb']=-1,['C']=0,['C#']=1,
	['Db']=1,['D']=2,['D#']=3,
	['Eb']=3,['E']=4,['E#']=5,
	['Fb']=4,['F']=5,['F#']=6,
	['Gb']=6,['G']=7,['G#']=8,
	['Ab']=8,['A']=9,['A#']=10,
	['Bb']=10,['B']=11,['B#']=12,
	}
	
local function getNoteBaseAndChordList(fullname)
	if not fullname then return end
	local n,c = fullname:match("^([A-G][b#]?)(.*)$")
	if not n then return end
	if not notenameShift[n] then return end
	local k = chordKeys[c]
	if k then return n,k end
end

local function draw_testChordFun()
	local fullname = nwcuser.getUserProp("Name:")
	local n,k = getNoteBaseAndChordList(fullname)
	if not k then
		fullname = "??"
	end

	nwcdraw.setFontClass(getFont())
	nwcdraw.alignText("baseline","center")
	nwcdraw.text(fullname)

	local span = getSpan()
	if span > 1 then
		local w = nwcdraw.locate("note",span)
		nwcdraw.hintline(w)
	end
end

local function play_testChordFun()
	local fullname = nwcuser.getUserProp("Name:")
	local n,k = getNoteBaseAndChordList(fullname)
	if not k then return end
	local span = getSpan(1)
	local duration = nwcplay.locate("note",span)
	local nshift = notenameShift[n]

	duration = (duration > 0) and duration or nwcplay.PPQ

	if k then
		local arpeggioShift = (duration >= nwcplay.PPQ) and (nwcplay.PPQ/16) or 0
		for i, v in ipairs(k) do
			local thisShift = i*arpeggioShift
			nwcplay.note(thisShift, duration-thisShift, 47+v+nshift)
		end
	end
end

nwc.addUserObjType({
	spec = NewObjectSpec,
	draw = draw_testChordFun,
	play = play_testChordFun,
	})

------------------------------------------------------------------------------------
