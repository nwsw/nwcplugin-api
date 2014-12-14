# `drawpos` References
This object enables reference access to different drawing positions on a visible staff. A `drawpos` object must be declared during plugin startup intialization before it can be used in a `draw` hook. 
This is done using the `nwc.newRef` method.

The following methods are provided by the `drawpos` object:

<table>
<tr>
<td><a href="#gotoRef">gotoRef</a></td>
<td><a href="#isAutoInsert">isAutoInsert</a></td>
<td><a href="#reset">reset</a></td>
</tr><tr>
<td><a href="#xyAnchor">xyAnchor</a></td>
<td><a href="#xyTimeslot">xyTimeslot</a></td>
</tr>
</table>


## Available Methods

The following methods are available from `drawpos`:

------------------
<a name="reset"></a>
**{drawpos}:reset**()

This sets a `drawpos` reference back to the current user object.


------------------
<a name="gotoRef"></a>
**{drawpos}:gotoRef**({ntnptr}), returns Boolean

This moves a `drawpos` object to reference the drawing position for [ntnptr](ref.ntnptr.md), if it can be found. If the operation succeeds, the function will return true and
the `drawpos` will reference the mew position. If `ntnptr` could not be found in the current drawing system, then the function returns false
and the `drawpos` object is unchanged.


------------------
<a name="isAutoInsert"></a>
**{drawpos}:isAutoInsert**(), returns Boolean

This indicates if the current `drawpos` object has been automatically inserted into the current printed system. This will only be true when the drawing target is **print** and the
`drawpos` reflects some kind of signature data that has been automatically inserted into the printed system.


------------------
<a name="xyAnchor"></a>
**{drawpos}:xyAnchor**(), returns #X,#Y

This returns the anchoring coordinate for the object at `{drawpos}`.


------------------
<a name="xyTimeslot"></a>
**{drawpos}:xyTimeslot**(), returns #X,#Y

This returns the anchoring timeslot coordinate for the note or rest located at `{drawpos}`.

