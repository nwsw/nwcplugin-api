# `drawpos` References
This object enables reference access to different drawing positions on a visible staff.

A `drawpos` object must be declared during plugin startup intialization before it can be used in a `draw` hook.
An existing instance is always available as `nwc.drawpos`.

Additional `drawpos` reference objects can be declared during plugin `init` via the <a href="#new">new</a> method:

```Lua
local myDrawPos = nwc.drawpos.new()
```

Any `drawpos` object can only be used in `user,predraw` or `user,draw` contexts. They are not active in any other context.

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
<td><a href="#width">width</a></td>
</tr><tr>
<td><a href="#xyAlignAnchor">xyAlignAnchor</a></td>
<td><a href="#xyAnchor">xyAnchor</a></td>
<td><a href="#xyLyric">xyLyric</a></td>
<td><a href="#xyRight">xyRight</a></td>
</tr><tr>
<td><a href="#xyNoteAccidental">xyNoteAccidental</a></td>
<td><a href="#xyNoteHead">xyNoteHead</a></td>
<td><a href="#xyStemAnchor">xyStemAnchor</a></td>
<td><a href="#xyStemTip">xyStemTip</a></td>
</tr><tr>
<td><a href="#xyTimeslot">xyTimeslot</a></td>
</tr>
</table>

All of the information retrieval methods from [nwc.ntnidx](nwc.ntnidx.md#methodlist) are also supported.


## Available Methods

------------------
<a name="new"></a>
**nwc.drawpos.new**()

This creates a new `drawpos` reference, which must be done during the plugin's `init` context.

All `drawpos` objects initially reference the current object when they are first used in an event hook.


------------------
<a name="reset"></a>
**{drawpos}:reset**()

This sets a `drawpos` reference back to the current target object.


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

This method cannot be used on positions that have `isAutoInsert()` as true.

`Offset` can optionally be used to get the current position's neighboring syllables. An `Offset` of -1 will return the text and separator just before the current position.
An `Offset` of 1 will return the lyric text just after the current position. The lyric does not have to actually be visible in the current drawing canvas.

Returns nil for 'Syllable' if the `#LyricLine` does not exist, or the drawpos is not eligible for a syllable and no `Offset` was specified.

Returns nil for 'Separator' if none exists, such as for the last syllable and later empty syllables in a `LyricLine`.


------------------
<a name="width"></a>
**{drawpos}:width**(), returns #Width

This returns the width of the current drawpos.


------------------
<a name="xyAlignAnchor"></a>
**{drawpos}:xyAlignAnchor**([#Direction]), returns #X,#Y

This returns a boundary alignment coordinate for the object at `{drawpos}`. The optional `Direction` can be +1 or -1, which indicates the upper (+1) or lower (-1) boundary alignment position should be returned.

------------------
<a name="xyAnchor"></a>
**{drawpos}:xyAnchor**(), returns #X,#Y

This returns the anchoring coordinate for the object at `{drawpos}`.


------------------
<a name="xyLyric"></a>
**{drawpos}:xyLyric**(#LyricRow), returns #X,#Y,['Alignment']

This returns the anchoring coordinate and alignment for a lyric syllable in the designated #LyricRow at this `drawpos`.
The 'Alignment' will be either **Left** or **Center**.

If the current `drawpos` is not eligible for lyric text, then this function returns the X,Y coordinate in the lyric row just below the position. Alignment is not returned
in this circumstance.

Returns nil if the #LyricRow does not exist.


------------------
<a name="xyNoteAccidental"></a>
**{drawpos}:xyNoteAccidental**([#NoteNumber]), returns #X,#Y,#AccIndicator

This returns the anchoring position for a target note's accidental in `{drawpos}`. The optional `NoteNumber` is used to indicate a member note in a chord. The `AccIndicator` will be an offset value indicating the pitch shift associated with the accidental (one of -2, -1, 0, 1, or 2), or `nil` if no accidental is assigned to the target note.

Returns `nil` when a note is not found.


------------------
<a name="xyNoteHead"></a>
**{drawpos}:xyNoteHead**([#NoteNumber]), returns #X,#Y,#GlyphIndicator

This returns the anchoring position for a target note head in `{drawpos}`. The optional `NoteNumber` is used to indicate a member note in a chord.

`GlyphIndicator` is the ordinal value for the *nwctxt* character representation of the note head. For example:

```Lua
string.byte("o") -- indicates a standard notehead
string.byte("z") -- indicates a blank notehead
string.byte("x") -- indicates a X notehead
```

Returns `nil` when a note is not found.


------------------
<a name="xyStemAnchor"></a>
**{drawpos}:xyStemAnchor**([#Direction]), returns #X,#Y

This returns the anchoring stem position for a note object at `{drawpos}`. The optional `Direction` can be +1, 0, or -1, which indicates the direction of the requested stem. An unspecified or zero `Direction` will return the dominant/default stem. If the current `drawpos` does not have a matching stem, then `nil` is returned.


------------------
<a name="xyStemTip"></a>
**{drawpos}:xyStemTip**([#Direction]), returns #X,#Y

When a note object at `{drawpos}` has a stem matching the indicated `Direction`, then the stem's end-point coordinate is returned. As with the `xyStemAnchor` function, the optional `Direction` can be +1, 0, or -1, which indicates the direction of the requested stem. An unspecified or zero `Direction` will return the dominant/default stem. If the current `drawpos` does not have a matching stem, then `nil` is returned.


------------------
<a name="xyTimeslot"></a>
**{drawpos}:xyTimeslot**(), returns #X,#Y

This returns the anchoring timeslot coordinate for the note or rest located at `{drawpos}`.


------------------
<a name="xyRight"></a>
**{drawpos}:xyRight**(), returns #X,#Y

This returns the right side egde coordinate for the position located at `{drawpos}`.
