# `nwcStaffItem` Class
This package enables access to the notation items found within a staff. A `nwcStaffItem` object must be declared during plugin startup intialization before it can be used in a hook function.
This is done using the `nwcStaffItem.new()` method. Usually, each `nwcStaffItem` object must then be intialized in every hook event function using `nwcStaffItem:init()` to synchronize it with the currently 
active event hook.

The following methods are provided by the `nwcStaffItem` object:

<table>
<tr>
<td><a href="#new">new</a></td>
<td><a href="#init">init</a></td>
<td><a href="#locate">goto</a></td>
</tr><tr>
<td><a href="#getObjType">getObjType</a></td>
<td><a href="#getStaffPos">getStaffPos</a></td>
</tr>
</table>


## Available Methods

The following methods are available from `nwcStaffItem`:

------------------
<a name="new"></a>
**nwcStaffItem.new**(), returns {nwcStaffItem}

This creates a new object that can be used in event function.

New objects must be created during plugin startup. They cannot be created during event hook execution. Therefore, this method can only be used during plugin loading/initialization.


------------------
<a name="init"></a>
**nwcStaffItem.init**({nwcStaffItem},...)

This initializes one or more `nwcStaffItem` objects with the current user object's enviroment. This must be done before other methods can be used.

This must be done before its other methods can be used on the object. Multiple items
can be initialized by passing them into the function, as shown in this excerpt:

```Lua
local item1 = nwcStaffItem.init()
local item2 = nwcStaffItem.init()
local item3 = nwcStaffItem.init()

local function draw()
	nwcStaffItem.init(item1,item2,item3)
```

------------------
<a name="goto"></a>
**{nwcStaffItem}:goto**(StaffItemReference)

This initializes a `nwcStaffItem` object with the staff item indicated by the StaffItemReference paramater.

The StaffItemReference paramater can be a `nwcDrawPos` object, or an offset index from the current user object.

This method fulfills the same initialization requirement as the `init` method.


---------------------------------
<a name="getObjType"></a>
**{nwcStaffItem}:getObjType**(), Returns 'ObjType'

This method returns the name of the current staff object.


------------------
<a name="getStaffPos"></a>
**{nwcStaffItem}:getStaffPos**(), returns Number

This returns the staff position of the object. This works best with expression and user objects.
