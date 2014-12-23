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

All of the information retrieval methods from [nwc.ntnidx](nwc.ntnidx.md#methodlist) are also supported.


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
**{drawpos}:lyricSyllable**(#LyricLine,[#Offset]), returns 'Syllable','Separator'

This returns lyric text (syllable and separator) attached to the current `drawpos`. The `LyricLine` number starts from 1.

`Offset` can optionally be used to get the current position's neighboring syllables, but the `drawpos` must itself maintain a valid non-zero lyric counter before this can be done.
An `Offset` of -1 will return the syllable and separator just before the current position, if one exists.

Returns nil for 'Syllable' if the `#LyricLine` does not exist, or the drawpos is not eligible for a syllable (does not have a non-zero lyric counter).

Returns nil for 'Separator' if none exists, such as for the last syllable and later empty syllables in a `LyricLine`.


------------------
<a name="xyAnchor"></a>
**{drawpos}:xyAnchor**(), returns #X,#Y

This returns the anchoring coordinate for the object at `{drawpos}`.


------------------
<a name="xyLyric"></a>
**{drawpos}:xyLyric**(#LyricRow), returns #X,#Y,'Alignment'

This returns the anchoring coordinate and alignment for a lyric syllable in the designated #LyricRow at this `drawpos`.
The 'Alignment' will be either **Left** or **Center**.

Returns nil if the `drawpos`is not eligible for a lyric, or the #LyricRow does not exist.


------------------
<a name="xyTimeslot"></a>
**{drawpos}:xyTimeslot**(), returns #X,#Y

This returns the anchoring timeslot coordinate for the note or rest located at `{drawpos}`.


------------------
<a name="xyRight"></a>
**{drawpos}:xyRight**(), returns #X,#Y

This returns the right side egde coordinate for the position located at `{drawpos}`.
