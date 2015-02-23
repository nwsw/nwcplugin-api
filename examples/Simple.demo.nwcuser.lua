-- Version 0.0

--[[-----------------------------------------------------------------------------------------
Simple.demo

This is the object code for User objects of type Simple.demo.

--]]-----------------------------------------------------------------------------------------

-- our object type is passed into the script
local userObjTypeName = ...

---------------------------------------------------------------------------------------------
-- the 'create' method is used to establish the object properties that will
-- control our plugin object
local function do_create(t)
	t.Data = 1
end

---------------------------------------------------------------------------------------------
-- the 'audit' method is called whenever something has changed in the area of the object,
-- including the object itself
local function do_audit(t)
	if not (tonumber(t.Data) == 1) then
		-- for purposes of this demo, we ensure that t.Data is always 1
		t.Data = 1
	end
end

---------------------------------------------------------------------------------------------
-- the 'spin' method is called whenever the user applied the +/- keys to our 
-- object from within the editor
local function do_spin(t,d)
	t.Data = (tonumber(t.Data) or 0) + d
end

---------------------------------------------------------------------------------------------
-- the 'transpose' method is called whenever the user runs the Transpose Staff
-- command from within the editor
local function do_transpose(t,semitones,notepos,updpatch)
end

---------------------------------------------------------------------------------------------
-- the 'play' method is called whenever our notatation is compiled into a
-- midi performance
local function do_play(t)
end

---------------------------------------------------------------------------------------------
-- the 'width' and 'draw' methods are combined here, and are used in the
-- formatting and display of our object on the NWC staff
--
local function do_draw(t)
	nwcdraw.setFontClass('StaffBold')

	local w,h,descent = nwcdraw.calcTextSize(userObjTypeName)

	if not nwcdraw.isDrawing() then
		-- the user can always add spacers to control width and placement, but one
		-- is provided here for demonstration purposes...a dedicated width method
		-- could also be created for an object (it need not be done in 'draw')
		return w
	end

	nwcdraw.alignText('baseline','right')
	nwcdraw.text(userObjTypeName)
end

---------------------------------------------------------------------------------------------
-- all object plug-ins must return the methods that they support in a
-- standard method table; uncomment any additional methods as needed

return {
	create		= do_create,
	audit		= do_audit,
	spin		= do_spin,
--	transpose	= do_transpose,
--	play		= do_play,
	width		= do_draw,
	draw		= do_draw
	}
