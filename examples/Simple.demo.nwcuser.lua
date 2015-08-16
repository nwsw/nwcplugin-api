-- Version 0.0

--[[--------------------------------------------------------------------------
This is a new plugin object. This comnment will appear each time a user
selects this object type for insertion into the staff.

@field1
This is the help text for field1.

@field2
This is the help text for field2.

@field3
This is the help text for field3.

--]]--------------------------------------------------------------------------

-- our object type is passed into the script
local userObjTypeName = ...

-- things work best when all fields supported by the plugin are published in a
-- spec table
local object_spec = {
	{ id='field1', label='Field 1', type='text', default='' },
	{ id='field2', label='Field 2', type='enum', default='value1', list={'value1','value2','value3'} },
	{ id='field3', label='Field 3', type='int', default=0, min=0, max=20, step=2 },
}

------------------------------------------------------------------------------
-- the 'create' method is used to establish the object properties that will
-- control our plugin object
local function do_create(t)
	t.field1 = 'Hello'
end

------------------------------------------------------------------------------
-- the 'audit' method is called whenever the object is first opened or pasted
-- into the editor
local function do_audit(t)
end

------------------------------------------------------------------------------
-- the 'spin' method is called whenever the user applied the +/- keys to our
-- object from within the editor
local function do_spin(t,d)
	t.field3 = t.field3 + d

	-- assigning this to itself enforces the spec table min and max
	t.field3 = t.field3
end

------------------------------------------------------------------------------
-- the 'transpose' method is called whenever the user runs the Transpose Staff
-- command from within the editor
local function do_transpose(t,semitones,notepos,updpatch)
end

------------------------------------------------------------------------------
-- the 'play' method is called whenever our notatation is compiled into a
-- midi performance
local function do_play(t)
end

------------------------------------------------------------------------------
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

	nwcdraw.alignText('baseline','left')
	nwcdraw.moveTo(-nwcdraw.width())
	nwcdraw.text(userObjTypeName)
end

------------------------------------------------------------------------------
-- all object plug-ins must return the methods that they support in a
-- standard method table; uncomment any additional methods as needed

return {
	spec		= object_spec,
	create		= do_create,
--	audit		= do_audit,
	spin		= do_spin,
--	transpose	= do_transpose,
--	play		= do_play,
	width		= do_draw,
	draw		= do_draw
	}
