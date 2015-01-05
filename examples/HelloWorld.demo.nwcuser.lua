-- Version 0.0

--[[----------------------------------------------------------------
HelloWorld

This is a demonstration script. It simply prints 'Hello World!' into
the current staff.
--]]----------------------------------------------------------------

-- our object type is passed into the script
local userObjTypeName = ...

--------------------------------------------------------------------
-- the 'create' method is used to establish the object properties that will
-- control our plugin object
local function do_create(t)
	t.Text = 'Hello World!'
	t.Size = 3
end

--------------------------------------------------------------------
-- the 'spin' method is called whenever the user applied the +/- keys to our 
-- object from within the editor
local function do_spin(t,d)
	local n = (tonumber(t.Size) or 3) + ((d > 0) and 0.5 or -0.5)
	t.Size = math.max(n,1)
end

--------------------------------------------------------------------
-- the 'play' method is called whenever our notatation is compiled into a
-- midi performance
local function do_play()
	-- we don't play anything back here
end

--------------------------------------------------------------------
-- the 'width' and 'draw' methods are combined here, and are used in the
-- formatting and display of our object on the NWC staff
local drawpos = nwcdraw.user
--
local function do_draw()
	local msg = drawpos:objProp('Text')
	local n = math.max(1,tonumber(drawpos:objProp('Size')) or 3)

	nwcdraw.setFontClass('StaffBold')
	nwcdraw.setFontSize(n)

	local w,h,descent = nwcdraw.calcTextSize(msg)

	if not nwcdraw.isDrawing() then
		-- the user can always add spacers to control width and placement, but one
		-- is provided here for demonstration purposes...a dedicated width method
		-- could also be created for an object (it need not be done in 'draw')
		return w
	end

	nwcdraw.alignText('baseline','right')
	nwcdraw.text(msg)
end

--------------------------------------------------------------------
-- all object plug-ins must return the methods that they support in a
-- standard method table

return {
	create	= do_create,
	spin	= do_spin,
	play	= do_play,
	width	= do_draw,
	draw	= do_draw
	}
