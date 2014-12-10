# `nwcDrawPos` Class
This package enables access to different drawing positions on a visible staff. A `nwcDrawPos` object must be declared during plugin startup intialization before it can be used in a `draw` hook. 
This is done using the `nwcDrawPos.new()` method. Usually, each `nwcDrawPos` object must then be intialized in the `draw` event hook using `nwcDrawPos:init()` to synchronize it with the current 
user  object's environment.

The following methods are provided by the `nwcDrawPos` object:

<table>
<tr>
<td><a href="#new">new</a></td>
<td><a href="#init">init</a></td>
<td><a href="#locate">locate</a></td>
</tr><tr>
<td><a href="#isAutoInsert">isAutoInsert</a></td>
</tr>
</table>


## Available Methods

The following methods are available from `nwcDrawPos`:

------------------
<a name="new"></a>
**nwcDrawPos.new**(), returns {nwcDrawPos}

This creates a new object that can be used later in draw based event hooks.

New objects must be created during plugin startup. They cannot be created during event hook execution. Therefore, this method can only be used during plugin loading/initialization.


------------------
<a name="init"></a>
**{nwcDrawPos}:init**(...)

This initializes one or more `nwcDrawPos` objects with the current user object's enviroment. This must be done before its other methods can be used on the object. Multiple draw positions 
can be initialized by passing them into the function, as shown in this excerpt:

```Lua
local drawpos1 = nwcDrawPos.init()
local drawpos2 = nwcDrawPos.init()
local drawpos3 = nwcDrawPos.init()

local function draw()
	nwcDrawPos.init(drawpos1,drawpos2,drawpos3)
```

------------------
<a name="locate"></a>
**{nwcDrawPos}:locate**({nwcStaffItem}), returns Boolean

This initializes a `nwcDrawPos` object with the location of the indicated `nwcStaffItem` object, if it can be found. If the operation succeeds, the function will return true and
the `nwcDrawPos` object will now reflect the position of the `nwcStaffItem`. If the `nwcStaffItem` object could not be found in the current drawing system, then the function returns false
and the `nwcDrawPos` object is unchanged.

When successful, this method fulfills the same initialization requirement as the `init` method.


------------------
<a name="isAutoInsert"></a>
**{nwcDrawPos}:isAutoInsert**(), returns Boolean

This indicates if the current `nwcDrawPos` object has been automatically inserted into the current printed system. This will only be true when the drawing target is **print** and the
`nwcDrawPos` reflects some kind of signature data that has been automatically inserted into the printed system.

