# `drawpos` References
This object enables reference access to different drawing positions on a visible staff.

A `drawpos` object must be declared during plugin startup intialization before it can be used in a `draw` hook. 
An existing instance is always available as `nwc.drawpos`.

Additional `drawpos` reference objects can be declared during plugin `init` via the <a href="#new">new</a> method:

```Lua
local myDrawPos = nwc.drawpos.new()
```

Any `drawpos` object must be used in `user:predraw` or `user:draw` contexts. They are not active on other contexts.

The following methods are provided by the `drawpos` object:

<table>
<tr>
<td><a href="#new">new</a></td>
</tr><tr>
<td><a href="#isAutoInsert">isAutoInsert</a></td>
<td><a href="#isHidden">isHidden</a></td>
<td><a href="#reset">reset</a></td>
</tr><tr>
<td><a href="#syllableCounter">syllableCounter</a></td>
<td><a href="#barCounter">barCounter</a></td>
<td><a href="#lyricSyllable">lyricSyllable</a></td>
</tr><tr>
<td><a href="#xyAnchor">xyAnchor</a></td>
<td><a href="#xyLyric">xyLyric</a></td>
<td><a href="#xyTimeslot">xyTimeslot</a></td>
<td><a href="#xyRight">xyRight</a></td>
</tr>
</table>

The following methods from [nwc.ntnidx](nwc.ntnidx.md) are also supported.

<table>
<tr>
<td><a href="nwc.ntnidx.md#find">find</a></td>
<td><a href="nwc.ntnidx.md#indexOffset">indexOffset</a></td>
<td><a href="nwc.ntnidx.md#noteCount">noteCount</a></td>
<td><a href="nwc.ntnidx.md#notePos">notePos</a></td>
<td><a href="nwc.ntnidx.md#notePitchPos">notePitchPos</a></td>
</tr><tr>
<td><a href="nwc.ntnidx.md#objType">objType</a></td>
<td><a href="nwc.ntnidx.md#propTable">propTable</a></td>
<td><a href="nwc.ntnidx.md#staffPos">staffPos</a></td>
<td><a href="nwc.ntnidx.md#userProp">userProp</a></td>
<td><a href="nwc.ntnidx.md#userType">userType</a></td>
</tr>
</table>


## Available Methods

------------------
<a name="new"></a>
**nwc.drawpos.new**()

This creates a new `drawpos` reference, which must be done during the plugin's `init` context.

All `drawpos` objects initially reference the current user object when they are first used in an event hook.


------------------
<a name="reset"></a>
**{drawpos}:reset**()

This sets a `drawpos` reference back to the current user object.


------------------
<a name="isAutoInsert"></a>
**{drawpos}:isAutoInsert**(), returns Boolean

This indicates if the current `drawpos` object has been automatically inserted into the current printed system. This will only be true when the drawing target is **print** and the
`drawpos` reflects some kind of signature data that has been automatically inserted into the printed system.


------------------
<a name="isHidden"></a>
**{drawpos}:isHidden**(), returns Boolean

This indicates if the current `drawpos` object is hidden and will not be shown on the printed copy of the work.


------------------
<a name="syllableCounter"></a>
**{drawpos}:syllableCounter**(), Number

This returns the lyric syllable counter for a note, or 0 for all other items.


------------------
<a name="barCounter"></a>
**{drawpos}:barCounter**(), returns Number

This returns the bar count for bar items, or 0 for all other items.


------------------
<a name="lyricSyllable"></a>
**{drawpos}:lyricSyllable**(#LyricLine), returns String or Nil

This returns the lyric text attached to a note, or Nil if no text exists. The #LyricLine number starts from 1.


------------------
<a name="xyAnchor"></a>
**{drawpos}:xyAnchor**(), returns #X,#Y

This returns the anchoring coordinate for the object at `{drawpos}`.


------------------
<a name="xyLyric"></a>
**{drawpos}:xyLyric**(#LyricRow), returns #X,#Y,'Alignment'

This returns the anchoring coordinate and alignment for a lyric syllable in the designated #LyricRow at this `drawpos`.
The 'Alignment' will be either **Left** or **Center**.

Returns nil if the `drawpos`is not eligible for a lyric, or the #LyricRow is not found.


------------------
<a name="xyTimeslot"></a>
**{drawpos}:xyTimeslot**(), returns #X,#Y

This returns the anchoring timeslot coordinate for the note or rest located at `{drawpos}`.


------------------
<a name="xyRight"></a>
**{drawpos}:xyRight**(), returns #X,#Y

This returns the right side egde coordinate for the position located at `{drawpos}`.
