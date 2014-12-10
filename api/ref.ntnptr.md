# `ntnptr` References
This object type enables reference access to the notation items found within a staff. A `ntnptr` object must be declared during plugin startup intialization before it can be used in a hook function.
This is done using the `nwc.newRef` method. Usually, each `ntnptr` object must then be intialized in every hook event function using the appropriate `bind` function to synchronize it with the currently 
active event hook.

The following methods are provided by the `ntnptr` object:

<table>
<tr>
<td><a href="#locate">goto</a></td>
</tr><tr>
<td><a href="#getObjType">getObjType</a></td>
<td><a href="#getStaffPos">getStaffPos</a></td>
</tr>
</table>


## Available Methods

The following methods are available from `ntnptr`:

------------------
<a name="goto"></a>
**{ntnptr}:goto**(Reference)

This initializes a `ntnptr` object with the staff item indicated by the `Reference` paramater.

The `Reference` paramater can be a `ref.drawpos` object, or an offset index from the current user object.


---------------------------------
<a name="getObjType"></a>
**{ntnptr}:getObjType**(), Returns 'ObjType'

This method returns the name of the current staff object.


------------------
<a name="getStaffPos"></a>
**{ntnptr}:getStaffPos**(), returns Number

This returns the staff position of the object. This works best with expression and user objects.
