# `drawpos` References
This object enables reference access to different drawing positions on a visible staff. A `drawpos` object must be declared during plugin startup intialization before it can be used in a `draw` hook. 
This is done using the `nwc.newRef` method. Usually, each `drawpos` object must then be intialized in the `draw` event hook using the `nwcdraw.bind` function to synchronize it with the current 
user  object's environment.

The following methods are provided by the `drawpos` object:

<table>
<tr>
<td><a href="#locate">locate</a></td>
</tr><tr>
<td><a href="#isAutoInsert">isAutoInsert</a></td>
</tr>
</table>


## Available Methods

The following methods are available from `drawpos`:

------------------
<a name="locate"></a>
**{drawpos}:locate**({ref.ntnptr}), returns Boolean

This initializes a `drawpos` object with the indicated `ref.ntnptr` object, if it can be found. If the operation succeeds, the function will return true and
the `drawpos` object will now reflect the position of the `ref.ntnptr`. If the `ref.ntnptr` object could not be found in the current drawing system, then the function returns false
and the `drawpos` object is unchanged.


------------------
<a name="isAutoInsert"></a>
**{drawpos}:isAutoInsert**(), returns Boolean

This indicates if the current `drawpos` object has been automatically inserted into the current printed system. This will only be true when the drawing target is **print** and the
`drawpos` reflects some kind of signature data that has been automatically inserted into the printed system.

