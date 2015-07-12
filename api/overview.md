# NWC User Object Plugin API

## User Object Type Naming Conventions
Starting in version 2.75, NoteWorthy Composer includes support for a new `User` object type.
These objects include a sub-type which can be subclassed using specially crafted Lua scripts.
A basic NWC User object can be represented in `nwctxt` as follows:


```nwctxt
|User|<Object-Type-Name>|<Property_1>:<Value_1>...|<Property_n>:<Value_n>
```

Each `<Object-Type-Name>` object can be subclassed with a Lua script that has a specific naming convention:

`<Object-Type-Name>.nwcuser.lua`


The `<Object-Type-Name>` must start with a letter, and is currently restricted to the ASCII character set. It is recommended that all object types include a short author identifier with a dot prefix. For example, all user object types created by Noteworthy Software will always include a `.nw` extension to uniquely identify them.

## Event Methods - Hooking into NWC

Each user object type's Lua script must return an event method table that will be used to subclass all NWC User objects that share the matching `<Object-Type-Name>`. This should be done at the end of the plugin's script:

```Lua
return {
	create	= local function(t) end,
	audit	= local function(t) end,
	spin	= local function(t,dir) end,
	transpose = local function(t,semitones,notepos,updpatch) end,
	play	= local function(t) end,
	width	= local function(t) return 0 end,
	draw	= local function(t) end
	}
```

This method table is used as an event dispatch mechanism which forwards the listed events into the user object's plugin module. The supported event methods which can be optionally subclassed by a user object plugin include:

| Method    | Parameters | Event    |
|:---------:|:----------:|:-------------- |
|  create   | **t**      | A new object of this type is being added to the staff. Parameter `t` provides read/write access to the properties for this user object. |
|  audit   | **t**      | This is called whenever something has changed in the area of the object, including the object itself. Parameter `t` provides read/write access to the properties for this user object. |
|  spin     | **t**<br>**dir** | The user applies a '+'/'-' increment/decrement operation against the user object while in the editor. Parameter `t` provides read/write access to the properties for this user object. Parameter `dir` is 1 or -1 to indicate the direction of the spin action.|
|  transpose     | **t**<br>**semitones**<br>**notepos**<br>**updpatch** | The staff is being transposed by the user. Parameter `t` provides read/write access to the properties for this user object. Parameter `semitones` can be anything from -12 up to 12. The `notepos` indicates the preferred amount of shift that should be applied to a note position on the staff, and should be between -7 and 7. The `updpatch` indicates if the play back instrument will be transposed accordingly.|
|  play     | **t** | The staff notation is being compiled into a performance using a buffered sequence of MIDI events. Parameter `t` provides read access to the properties for this user object. |
|  width    | **t** | The user object is being evaluated for inclusion in a displayable medium, such as an editor view or printed page, and it is given an opportunity to request a reserved width on the staff. The method should retuurn a required width, or no width will be reserved for the user object. Parameter `t` provides read access to the properties for this user object. |
|  draw     | **t** | The user object needs to be rendered into a window or onto a printed page. Parameter `t` provides read access to the properties for this user object. |

## Object Field Spec - Defining Object Parameters

Although not required, it is recommended that an object's event method table return an additional `spec` entry. This is used to:

- document the custom properties supported by the user object plugin
- filter the values returned to the script for these properties
- define a `click` handler that allows the script to control how a field is updated when accessed from the editor's right click menu

The `spec` table should list all of the possible fields that are supported by the user object type, and describe the nature of the value that each field will contain. The following example demonstrates all of the available types that are supported by the `spec` table:

```Lua
local obj_spec = {
	field1 = {type='bool',default=true},
	field2 = {type='int',default=0,min=0,max=100},
	field3 = {type='float',default=0.0,min=-5.0,max=5.0,step=0.1},
	field4 = {type='text',default='mytext'},
	field5 = {type='enum',default='Quarter',list=nwc.txt.NoteDuration},
	field6 = {type='enum',default='Quarter',list={'Whole', 'Half', 'Quarter', 'Eighth', 'Sixteenth', 'Thirtysecond', 'Sixtyfourth'}},
 }
```

The `obj_spec` should be included in the table returned by the plugin:

```Lua
return {
	spec = obj_spec,
	create = do_create,
	...
 }
```

When this is done, all property values for a user object of this type will be filtered through the lens of its `spec` table. If a property does not exist in the object, then the `default` value from the spec will be returned. For properties of type `bool`, any of the following case insensitive values will result in a true return value: `y, yes, true, 1`. Any other value will yield false. Numeric values (`int` or `float`) that are out of range will return the `min` or `max`, depending on which extreme was exceeded. For `enum` fields, the `default` will be returned if the current property value is not found in the enumerated list. The list is case sensitive.

The object's `spec` table is also utilized when an object is right clicked from the editor. A property menu is generated from the definitions found in the table, making `bool` and `enum` properties changeable from within the menu.

## The `click` Handler
The actual action associated with each menu item can be implemented by the script. This is done by adding a `click` handler for the field's definition in the `spec` table:

```Lua
local listTestOptions = {'Configure Spin...', 'Assign New Font...','Change x1'}

local function doClick(t,fieldName,enumValue)
	nwcui.msgbox('doClick(t,"'..fieldName..'",'..(enumValue and ('"'..enumValue..'"') or 'nil')..')')

	if enumValue and enumValue:match("x1") then
		t.x1 = t.x1 + 0.25
	end
end

local testspec  = {
	TestOptions = { type='enum', default=false, list=listTestOptions, click=doClick },
	TestCmd = { type='text', click=doClick },
	x1 = {type='float',default=0, min=-5, max=5, step=0 },
	}
```

The `click` handler must be a local Lua function that accepts three parameters:

1. the object `t` which provides read/write access to the target object (if required)
2. the `fieldName` from the `spec` table
3. the `enumValue` is the user clicked value from `list` table for `enum` fields, otherwise it is `nil`

The `click` handler is free to change any values in the object via the `t` argument. The program takes care of managing the editor's undo mechanism. If a prompt/dialog is cancelled by the user while in a `click` function, any changes made to the object are ignored.

## Support Packages

The following support packages are available for use by the user object plugin, depending on which event method is currently executing in context:

- [nwc](nwc.md)

- [nwcui](nwcui.md)

- [nwcplay](nwcplay.md)

- [nwcdraw](nwcdraw.md) 

The following reference objects are also available for use:

- [nwc.ntnidx](nwc.ntnidx.md)

- [nwc.drawpos](nwc.drawpos.md)
