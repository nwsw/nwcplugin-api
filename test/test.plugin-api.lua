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
local DefaultChordFontSize = (DefaultChordFontFace == "MusikChordSerif") and 8 or 5

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

local function allNotePos(itemOffset)
	local noteNum = 0
	return function()
		noteNum = noteNum+1
		return nwcuser.getNotePos(itemOffset,noteNum)
	end
end

local function getUserPoint(propName)
	local userpt = nwcuser.getUserProp(propName) or "0,0"
	local x = tonumber(userpt:match("([%.%d]+),")) or 0
	local y = tonumber(userpt:match(",([%.%-%d]+)")) or 0
	return x,y
end

local function fitPts(pts)
	local function getcp(p)
		local n = #p
		local cp = {}
		local tmp = {}
		local b = 2.0

		cp[1] = p[1] / b
		for i=1,n-1 do
			tmp[i+1] = 1 / b
			b = ((i < (n-1)) and 4.0 or 3.5) - tmp[i+1]
			cp[i+1] = (p[i+1] - cp[i]) / b
		end

		for i=1,n-1 do
			cp[n-i] = cp[n-i] - (tmp[n-i+1] * cp[n-i+1])
		end

		return cp
	end

	local n = #pts - 1

	assert(n > 0)

	if n == 1 then
		local cp1 = {(2* pts[1][1] + pts[2][1]) / 3, (2 * pts[1][2] + pts[2][2]) / 3}
		return {cp1,{(2*cp1[1] - pts[1][1]), (2*cp1[2] - pts[1][2])}}
	end

	local ipos = {}

	-- intermediate X positions
	ipos[1] = pts[1][1] + 2*pts[2][1]

	for i = 2,n-1 do
		ipos[i] = 4*pts[i][1] + 2*pts[i + 1][1]
	end

	ipos[n] = (8*pts[n][1] + pts[n+1][1]) / 2.0

	local x = getcp(ipos)

	-- intermediate Y positions
	ipos[1] = pts[1][2] + 2 * pts[2][2]

	for i=2,n-1 do
		ipos[i] = 4*pts[i][2] + 2*pts[i + 1][2]
	end

	ipos[n] = (8*pts[n][2] + pts[n+1][2]) / 2.0

	local y = getcp(ipos)

	local cp = {}
	for i=1,n do
		local cp1 = {x[i], y[i]}
		local cp2

		if i < (n-1) then
			cp2 = {(2*pts[i + 1][1] - x[i + 1]), (2*pts[i + 1][2] - y[i + 1])}
		else
			cp2 = {((pts[n][1] + x[n - 1]) / 2), ((pts[n][2] + y[n - 1]) / 2)}
		end

		cp[i] = {cp1,cp2}
	end

	return cp
end

local function freehandLine(x1,y1,x2,y2,driftmax)
	local xdiff = x2 - x1
	local ydiff = y2 - y1
	local linelen = math.sqrt(xdiff^2 + ydiff^2)
	local xdrift,ydrift = 0,0
	local numsegs = 2
	local pts = {{x1,y1}}

	if math.abs(ydiff) > math.abs(xdiff) then
		-- create random deviation using change in y
		numsegs = math.min(64,math.max(2,math.floor(math.abs(ydiff)/3)))
		xdrift = tonumber(driftmax) or 0.2
	else
		-- create random deviation using change in x
		numsegs = math.min(64,math.max(2,math.floor(math.abs(xdiff)/3)))
		ydrift = tonumber(driftmax) or 0.4
	end

	for i=1,numsegs-1 do
		local r = math.random() - 0.5
		local x = x1 + (i*xdiff)/numsegs + r*xdrift
		local y = y1 + (i*ydiff)/numsegs + r*ydrift

		table.insert(pts,{x,y})
	end

	table.insert(pts,{x2,y2})

	local cp = fitPts(pts)

	nwcdraw.moveTo(x1,y1)
	for i=2,#pts do
		local cp1,cp2 = cp[i-1][1],cp[i-1][2]
		nwcdraw.bezier(
			cp1[1],cp1[2],
			cp2[1],cp2[2],
			pts[i][1],pts[i][2]
			)
	end
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
NewObjectSpec = '|User|test.boxtext|Angle:[#0-360]0|Pen:solid|Thickness:[#1-1000]350|Typeface:[*]Arial|Size:[#.#]6|Text:[*]"Hello World"'
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

	local t = nwcuser.getUserProp("Text:")
	local w,h = nwcdraw.calcTextSize(t)
	nwcdraw.angleText(t,angle)

	if nwcuser.getUserProp("Thickness:") == "0" then return end
	local angleRad = math.rad(angle)
	setPenOpts()
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
NewObjectSpec = '|User|test.notelines'
------------------------------------------------------------------------------------
local function draw_test_notelines()
	local nextNote = nwcuser.find("next","note")
	if not nextNote then return end

	setPenOpts()
	local xpos = nwcdraw.locate("item",nextNote)
	
	for np in allNotePos(nextNote) do
		nwcdraw.moveTo(0,0)
		nwcdraw.line(xpos,np)
	end
end

nwc.addUserObjType({
	spec = NewObjectSpec,
	draw = draw_test_notelines,
	})

------------------------------------------------------------------------------------
NewObjectSpec = '|User|test.freehand|pt1:[@Coordinate]0,0|pt2:[@Coordinate]0,8|drift:[#.#]0.25'
------------------------------------------------------------------------------------
local function draw_test_freehand()
	local x1,y1 = getUserPoint("pt1")
	local x2,y2 = getUserPoint("pt2")

	if (x2 == x1) and (y2 == y1) then return end

	local drift = tonumber(nwcuser.getUserProp("drift")) or 0.25
	setPenOpts()

	freehandLine(x1,y1,x2,y2,drift)
end

nwc.addUserObjType({
	spec = NewObjectSpec,
	draw = draw_test_freehand,
	})

------------------------------------------------------------------------------------
NewObjectSpec = '|User|test.tracenotespan|Span:[#2-32]2'
------------------------------------------------------------------------------------
local function draw_test_tracenotespan()
	local span = getSpan()
	local targetx,ytop,ybtm,termtype = nwcdraw.locate("note",span)

	setPenOpts()

	if span > 1 then
		local pts = {}
		for i=1,span do
			targetx,ytop,ybtm,termtype = nwcdraw.locate("note",i)
			table.insert(pts,{targetx,ytop})
		end
			
		nwcdraw.hintline(pts[1][1],pts[1][2])

		local cp = fitPts(pts)

		nwcdraw.moveTo(pts[1][1],pts[1][2])
		for i=2,#pts do
			local cp1,cp2 = cp[i-1][1],cp[i-1][2]
			nwcdraw.bezier(
				cp1[1],cp1[2],
				cp2[1],cp2[2],
				pts[i][1],pts[i][2]
				)
		end
	end
end

nwc.addUserObjType({
	spec = NewObjectSpec,
	draw = draw_test_tracenotespan,
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

	nwcdraw.setFont(DefaultChordFontFace,DefaultChordFontSize)
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
