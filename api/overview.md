# NWC Object Plugin API

## Object Type Naming Conventions
NoteWorthy Composer Version 2.75 includes support for a new generic object type, that internally is of type `User`.
This object includes a sub-type which can be subclassed using Lua plugin scripts. An example custom NWC object represented by `nwctxt`
is shown here:


```nwctxt
|User|<Object-Type-Name>|<Property_1>:<Value_1>...|<Property_n>:<Value_n>
```

Each `<Object-Type-Name>` object can be subclassed with a Lua script that has a specific naming convention:

`<Object-Type-Name>.nwcuser.lua`


The `<Object-Type-Name>` must start with a letter, and is currently restricted to the ASCII character set. It is recommended that all object types include a short author identifier with a dot prefix. For example, all object types created by Noteworthy Software will always include a `.nw` extension to uniquely identify them.

## Event Methods - Hooking into NWC

Each object type's Lua script must return an event method table that will be used to subclass any objects that share the matching `<Object-Type-Name>`. This should be done at the end of the plugin's script:

```Lua
return {
	spec      = {{id='field1',type='text',default=''},{id='field2',type='text',default=''}},
	menu      = {{type='command',name='cmd1...',separator=false,checkmark=false,disable=false,data=1},
	             {type='command',name='cmd2...',separator=true,checkmark=true,disable=false,data=2}},
	menuInit  = function(t) end,
	menuClick = function(t,menu,choice) end,
	create    = function(t) end,
	audit     = function(t) end,
	spin      = function(t,dir) end,
	onChar    = function(t,c) end,
	transpose = function(t,semitones,notepos,updpatch) end,
	play      = function(t) end,
	width     = function(t) return 0 end,
	draw      = function(t) end
	}
```

This method table is used as an event dispatch mechanism which forwards the listed events into the object's plugin module. The supported event methods are:

| Method    | Parameters | Event    |
|:---------:|:----------:|:-------------- |
|  create   | **t**      | A new object is being added to the staff. Parameter `t` provides read/write access to the properties for this object. |
|  audit   | **t**      | This is called when an object is loaded (via file/clipboard) or a _View->Refresh Score_ is performed. Parameter `t` provides read/write access to the properties for this object. |
|  spin     | **t**<br>**dir** | The user applies a '+'/'-' increment/decrement operation against the object while in the editor. Parameter `t` provides read/write access to the properties for this object. Parameter `dir` is 1 or -1 to indicate the direction of the spin action.|
|  onChar   | **t**<br>**c** | The user has pressed a character on the computer keyboard while targeting this object (it is selected by itself from within the editor). Parameter `t` provides read/write access to the properties for this object. Parameter `c` is the numeric character key that has been pressed. Returns `true` if the plugin has responded to the key withs an action. Returns `false` if the key should be handled in the standard fashion by the editor. |
|  transpose     | **t**<br>**semitones**<br>**notepos**<br>**updpatch** | The staff is being transposed by the user. Parameter `t` provides read/write access to the properties for this object. Parameter `semitones` can be anything from -12 up to 12. The `notepos` indicates the preferred amount of shift that should be applied to a note position on the staff, and should be between -7 and 7. The `updpatch` indicates if the play back instrument will be transposed accordingly.|
|  play     | **t** | The staff notation is being compiled into a performance using a buffered sequence of MIDI events. Parameter `t` provides read access to the properties for this object. |
|  width    | **t** | The object is being evaluated for inclusion in a displayable medium, such as an editor view or printed page, and it is given an opportunity to request a reserved width on the staff. The method should retuurn a required width, or no width will be reserved for the object. Parameter `t` provides read access to the properties for this object. |
|  draw     | **t** | The object needs to be rendered into a window or onto a printed page. Parameter `t` provides read access to the properties for this object. |
|  menuInit | **t** | The object has been right clicked in the editor, and a menu is about to be presented. Parameter `t` provides read access to the properties for this object, which can be used to alter the contents of the its `menu` table. |
| menuClick | **t**<br>**menuidx**<br>**choice** | A choice has been selected from the object's right click menu. Parameter `t` provides read/write access to the properties for this object. The `menuidx` is the key into the `menu` table, and `choice` is the **list** choice index, or **nil** for menu commands. |

## The `spec` Table - Defining Object Properties

Although not required, it is recommended that an object's event method table return an additional `spec` entry. This is used to:

- document the properties supported by the plugin
- filter the values returned to the script for these properties

The `spec` table should list all of the possible fields (16 fields maximum) that are supported by the object type, and describe the nature of the value that each field will contain. The following example demonstrates all of the available types that are supported by the `spec` table:

```Lua
local obj_spec = {
	{id='field1',label='Enable field&1',type='bool',default=true},
	{id='field2',type='int',default=0,min=0,max=100},
	{id='field3',type='float',default=0.0,min=-5.0,max=5.0,step=0.1},
	{id='field4',type='text',default='mytext'},
	{id='field5',label='What duration',type='enum',default='Quarter',list=nwc.txt.NoteDuration},
	{id='field6',label='Select from list',type='enum',default='Quarter',list={'Whole', 'Half', 'Quarter', 'Eighth', 'Sixteenth', 'Thirtysecond', 'Sixtyfourth'}},
 }
```

Some additional notes about the field types:

- The `label`value is optional. When provided, it will be used in the NWC property sheet.
- When not specified, the default `min` is -1000 and default `max` is 1000.

The `obj_spec` should be included in the table returned by the plugin:

```Lua
return {
	spec = obj_spec,
	create = do_create,
	...
 }
```

When this is done, all property values for an object will be filtered through the lens of its `spec` table. If a property does not exist in the object, then the `default` value from the spec will be returned. For properties of type `bool`, any of the following case insensitive values will result in a true return value: `y, yes, true, 1`. Any other value will yield false. Numeric values (`int` or `float`) that are out of range will return the `min` or `max`, depending on which extreme was exceeded. For `enum` fields, the `default` will be returned if the current property value is not found in the enumerated list. The list is generally case sensitive, but you should not use duplicate values of differing case.

## The `menu` Table - Custom Command Actions
An object's event method table can return an additional `menu` entry. This is used to construct a context menu when an object's anchor is right clicked in the editor. It is also accessible when the object is selected by itself in the editor. Each active menu entry triggers an `menuClick` event when an item is selected by the user.

The following example demonstrates the `menu` table:

```Lua
local menu1List = {'subCommand 1','subCommand 2','subCommand 3','subCommand 4','subCommand 5'}

local obj_menu = {
	{type='choice',name='Menu Command 1',separator=false,disable=false,default=nil,list=menu1List,data=nil}
	{type='command',name='Menu Command 2...',separator=true,disable=false,checkmark=true,data={custom1='anything'}},
 }

local function obj_menuInit(t)
	-- this can change obj_menu as needed
	obj_menu[2].checkmark = t.opt1
end

local function obj_menuClick(t,menuidx,choice)
	if menuidx == 1 then
		print('Menu1 Clicked',obj_menu[1].name,obj_menu[1].list[choice])
	elseif menuidx == 2 then
		print('Menu2 Clicked',obj_menu[2].name)
	end
end


```

The `menu` and its supporting events must be included in the table returned by the plugin:

```Lua
return {
	...
	menu      = obj_menu,
	menuInit  = obj_menuInit,
	menuClick = obj_menuClick,
	...
 }
```

The `menuClick` event handler is free to change any values in the object via the `t` argument. The program takes care of managing the editor's undo mechanism. If a prompt/dialog is canceled by the user while in the `menuClick` function, any changes made to the object are ignored. A custom 'data' field can be included in any `menu` table entry, and can be assigned any values that might be needed in the `menuInit` or `menuClick` functions.

## Support Packages

The following support packages are available for use by the object plugin, depending on which event method is currently executing in context:

- [nwc](nwc.md)

- [nwcui](nwcui.md)

- [nwcplay](nwcplay.md)

- [nwcdraw](nwcdraw.md)

The following reference objects are also available for use:

- [nwc.ntnidx](nwc.ntnidx.md)

- [nwc.drawpos](nwc.drawpos.md)
