# NWC User Object Plugin API

## User Object Type Naming Conventions
Starting in version 2.75, NoteWorthy Composer includes support for a new User object type. These objects include a sub-type which can
be subclassed using specially crafted Lua scripts. A basic NWC User object can be represented in `nwctxt` as follows:


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

## Support Packages

The following support packages are available for use by the user object plugin, depending on which event method is currently executing in context:

- [nwc](nwc.md)

- [nwcui](nwcui.md)

- [nwcplay](nwcplay.md)

- [nwcdraw](nwcdraw.md) 

The following reference objects are also available for use:

- [nwc.ntnidx](nwc.ntnidx.md)

- [nwc.drawpos](nwc.drawpos.md)
