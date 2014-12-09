# The `drawpos` Object
This package enables access to different drawing positions on a visible staff. A `drawpos` object must be declared during plugin startup intialization before it can be used in a `draw` hook. 
This is done using the `drawpos.new()` method. Usually, each `drawpos` object must then be intialized in the `draw` event hook using `drawpos:init()` to synchronize it with the current 
user  object's environment.

The following methods are provided by the `drawpos` object:

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

The following methods are available from `drawpos`:

------------------
<a name="new"></a>
**drawpos.new**(), returns {drawpos-object}

This creates a new object that can later be used in a `draw` even hook function.

New drawpos objects must be created during plugin startup. They cannot be created during event hook execution. Therefore, this method can only be used during plugin loading/initialization.


------------------
<a name="init"></a>
**{drawpos}:init**()

This initializes a `drawpos` object with the current user object's enviroment. This must be done before its other methods can be used.


------------------
<a name="locate"></a>
**{drawpos}:locate**({nwcitem-object}), returns Boolean

This initializes a `drawpos` object with the location of the indicated `nwcitem` object, if it can be found. If the operation succeeds, the function will return true and
the `drawpos` object will now reflect the `nwcitem` position. If the `nwcitem` object could not be found in the current drawing system, then the function returns false
and the `drawpos` object is unchanged.

When successful, this method fulfills the same initialization requirement as the `init` method.


------------------
<a name="isAutoInsert"></a>
**{drawpos}:isAutoInsert**(), returns Boolean

This indicates if the current `drawpos` object has been automatically inserted into the current printed system. This will only be true when the drawing target is **print** and the
`drawpos` reflects some kind of signature data that has been automatically inserted into the printed system.

