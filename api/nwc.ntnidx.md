# `ntnidx` References
This object references notation items found within a staff. An existing instance is available as `nwc.ntnidx` in the `nwc` module. Additional `ntnidx` reference objects must be declared during the plugin `init` context. This is done using the <a href="#new">new</a> method:

```Lua
local myNotationPtr = nwc.ntnidx.new()
```

> Care should be taken when sharing global object instances across multiple event methods, such as using the same object references between `create`, `draw`, and `width` events. These events can run concurrently while `nwcui` methods are invoked. For this reason, object references used across calls to `nwcui` methods should not be shared with other event handlers.

The following methods are provided in the `ntnidx` object:
<a name="methodlist"></a>

<table>
<tr>
<td><a href="#new">new</a></td>
<td><a href="#reset">reset</a></td>
<td><a href="#compareOps">&lt; &lt;= &gt; &gt;= ==</a></td>
</tr><tr>
<td><a href="#find">find</a></td>
<td><a href="#articulationCount">articulationCount</a></td>
<td><a href="#durationBase">durationBase</a></td>
<td><a href="#indexOffset">indexOffset</a></td>
</tr><tr>
<td><a href="#isBeamed">isBeamed</a></td>
<td><a href="#isDotted">isDotted</a></td>
<td><a href="#isCresc">isCresc</a></td>
<td><a href="#isDecresc">isDecresc</a></td>
</tr><tr>
<td><a href="#isAccented">isAccented</a></td>
<td><a href="#isMarcato">isMarcato</a></td>
<td><a href="#isStaccatissimo">isStaccatissimo</a></td>
<td><a href="#isStaccato">isStaccato</a></td>
<td><a href="#isTenuto">isTenuto</a></td>
</tr><tr>
<td><a href="#isGrace">isGrace</a></td>
<td><a href="#isLyricPos">isLyricPos</a></td>
<td><a href="#isMelisma">isMelisma</a></td>
<td><a href="#isMute">isMute</a></td>
<td><a href="#isSlurIn">isSlurIn</a></td>
</tr><tr>
<td><a href="#isSlurOut">isSlurOut</a></td>
<td><a href="#isSplitVoice">isSplitVoice</a></td>
<td><a href="#isTieIn">isTieIn</a></td>
<td><a href="#isTieOut">isTieOut</a></td>
<td><a href="#isTriplet">isTriplet</a></td>
</tr><tr>
<td><a href="#noteCount">noteCount</a></td>
<td><a href="#notePos">notePos</a></td>
<td><a href="#notePitchPos">notePitchPos</a></td>
<td><a href="#objProp">objProp</a></td>
<td><a href="#objType">objType</a></td>
</tr><tr>
<td><a href="#propTable">propTable</a></td>
<td><a href="#sppOffset">sppOffset</a></td>
<td><a href="#staffPos">staffPos</a></td>
<td><a href="#stemDir">stemDir</a></td>
<td><a href="#userProp">userProp</a></td>
</tr><tr>
<td><a href="#userType">userType</a></td>
</tr>
</table>


## Available Methods

The following methods are available from `ntnidx`:

------------------
<a name="new"></a>
**nwc.ntnidx.new**()

This creates a new `ntnidx` reference, which can only be done during the plugin's `init` context.

All `ntnidx` objects always reference the current user object when first used in an event hook.


------------------
<a name="reset"></a>
**{ntnidx}:reset**()

This sets a `ntnidx` reference back to the current user object.


------------------
<a name="compareOps"></a>
**{ntnidx}:(operators) &lt; &lt;= &gt; &gt;= ==**, Returns Boolean

`ntnidx` and `drawpos` objects can be compared using the standard operators. An object is *less than* other objects when it is located earlier in the staff.

```lua
local idx1 = nwc.ntnidx.new()
local idx2 = nwc.ntnidx.new()

...

if idx1 < idx2 then
	-- idx1 is located before idx2 on the staff
end

...

if idx2 > 0 then
	-- idx2 is located after the currently active user object
end
```

------------------
<a name="indexOffset"></a>
**{ntnidx}:indexOffset**(), Returns IntegerOffset

This returns the offset index from the current user object.


------------------
<a name="sppOffset"></a>
**{ntnidx}:sppOffset**(), Returns IntegerOffset

This returns the relative song position pointer offset from the current user object. This value is suitable for use in [nwcplay](nwcplay.md) functions. This value will be negative when the current `ntnidx` is behind the current anchoring index.


---------------------------------
<a name="objType"></a>
**{ntnidx}:objType**(), Returns 'ObjType'

This method returns the name of the current staff object.


---------------------------------
<a name="objProp"></a>
**{ntnidx}:objProp**('PropertyName'), Returns 'PropertyValue'

This returns the nwctxt property value for the current object, or Nil if this property would not appear in the nwctxt depiction of the object.


------------------
<a name="staffPos"></a>
**{ntnidx}:staffPos**(), returns Number

This returns the staff position of the object. This works best with expression and user objects.


------------------
<a name="durationBase"></a>
**{ntnidx}:durationBase**([#NoteNumber]), returns 'Duration' or nil

Returns the note position's named duration.
Returns nil if this is not a valid note or rest position.


------------------
<a name="isBeamed"></a>
**{ntnidx}:isBeamed**([#NoteNumber]), returns 'BeamStatus' or false or `nil

Returns **First**, **Middle**, or **End** when a valid note position is part of a beamed group. Returns `false` when a valid note position is not part of a beam.


------------------
<a name="isDotted"></a>
**{ntnidx}:isDotted**([#NoteNumber]), returns #Number or false or nil

If this is a note position and is dotted, then the number of dots are returned. Returns `false` if this note position is not dotted. Returns nil if this is not a valid note or rest position.


------------------
<a name="isDotted"></a>
**{ntnidx}:isDotted**([#NoteNumber]), returns #Number or false or nil

If this is a note position and is dotted, then the number of dots are returned. Returns `false` if this note position is not dotted. Returns nil if this is not a valid note or rest position.


------------------
<a name="isGrace"></a>
**{ntnidx}:isGrace**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position is a grace note.


------------------
<a name="isLyricPos"></a>
**{ntnidx}:isLyricPos**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position accepts attached lyric text.


------------------
<a name="isMelisma"></a>
**{ntnidx}:isMelisma**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position accepts attached lyric text, and the position starts a melisma.


------------------
<a name="isMute"></a>
**{ntnidx}:isMute**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been specifically muted by the user.


------------------
<a name="isSlurIn"></a>
**{ntnidx}:isSlurIn**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position receives a built-in slur from earlier in the staff.


------------------
<a name="isSlurOut"></a>
**{ntnidx}:isSlurOut**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position starts or extends a slur.


------------------
<a name="isSplitVoice"></a>
**{ntnidx}:isSplitVoice**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position contains dual voicing, such as a split stem chord or a rest chord.


------------------
<a name="isTieIn"></a>
**{ntnidx}:isTieIn**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position receives a note tie from earlier in the staff.


------------------
<a name="isTieOut"></a>
**{ntnidx}:isTieOut**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position starts or extends a tie to the next note at its position.


------------------
<a name="isCresc"></a>
**{ntnidx}:isCresc**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been marked with Cresc.


------------------
<a name="isDecresc"></a>
**{ntnidx}:isDecresc**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been marked with Decresc.


------------------
<a name="articulationCount"></a>
**{ntnidx}:articulationCount**([#NoteNumber]), returns Number or nil

When on a valid note position, this returns the number of articulations found .


------------------
<a name="isAccented"></a>
**{ntnidx}:isAccented**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been marked with an Accent.


------------------
<a name="isMarcato"></a>
**{ntnidx}:isMarcato**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been marked with Marcato.


------------------
<a name="isStaccatissimo"></a>
**{ntnidx}:isStaccatissimo**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been marked with Staccatissimo.


------------------
<a name="isStaccato"></a>
**{ntnidx}:isStaccato**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been marked with Staccato.


------------------
<a name="isTenuto"></a>
**{ntnidx}:isTenuto**([#NoteNumber]), returns Boolean or nil

Returns `true` when a valid note position has been marked with Tenuto.


------------------
<a name="isTriplet"></a>
**{ntnidx}:isTriplet**([#NoteNumber]), returns 'TripletPosition' or false or nil

Returns **First**, **Middle**, or **End** when a valid note position is part of a triplet grouping. Returns `false` when a valid note position is not part of a triplet.


---------------------------------
<a name="propTable"></a>
**{ntnidx}:propTable**(), Returns PropertyTable

This method returns a table containing the nwctxt properties for the object.

---------------------------------
<a name="userType"></a>
**{ntnidx}:userType**(), Returns 'UserObjType'

This method returns the type of the current User object. If the item is not a User item, then `nil` is returned.


---------------------------------
<a name="userProp"></a>
**{ntnidx}:userProp**('PropertyLabel'), Returns 'PropertyValue'

This returns the value for any custom property that exists in the current User object, or `nil` if this is not a User object. This value is filtered through the object's `spec` table.


---------------------------------
<a name="noteCount"></a>
**{ntnidx}:noteCount**(), Returns #NoteCount

This returns the number of notes found in the object.


---------------------------------
<a name="notePos"></a>
**{ntnidx}:notePos**(#NoteNumber), Returns #NotePosition

This returns the staff Y coordinate for the given NoteNumber. The NoteNumber must start from 1, and will yield valid positions up through [{ntnidx}:noteCount()](#noteCount) note numbers. This function returns `nil` if there is no such note number.


---------------------------------
<a name="notePitchPos"></a>
**{ntnidx}:notePitchPos**(#NoteNumber), Returns 'PitchPosText'

This returns the PitchPos nwctxt for the given NoteNumber. The NoteNumber must start from 1, and will yield valid positions up through [{ntnidx}:noteCount()](#noteCount). This function returns `nil` if there is no such note number.

Unlike the `notePos` function, the position information contained in the `PitchPosText` uses an absolute staff position, and would need to be normalized with a user object's current staff position when drawing.


---------------------------------
<a name="stemDir"></a>
**{ntnidx}:stemDir**(#NoteNumber), Returns -1,1, or nil

This returns a number indicating the stem direction for any valid note position. This returns what is essentially a voicing direction for rests and notes without an actual stem.


---------------------------------
<a name="find"></a>
**{ntnidx}:find**(Action,['What',...]), Returns Boolean

This method can be used to find other items on the same staff as the current object. The following values are supported for the `Action` field:

 - [nwc.ntnidx](nwc.ntnidx.md)
   <br>Finds the `ntnidx` referenced object.
 - [nwc.drawpos](nwc.drawpos.md)
   <br>Finds the `drawpos` object.
 - **'next'**
   <br>Finds the next match to the right of the current object.
 - **'prior'**
   <br>Finds the prior match to the left of the current object.
 - **'first'**
   <br>Finds the first match from the start of the staff.
 - **'last'**
   <br>Finds the last match from the end of the staff.

The following values are supported for the optional 'What' field:

 - **user**, ['UserObjType', 'UserPropertyLabel']
   <br>This finds a matching user object. If 'UserObjType' is indicated, then only user objects of this type will be matched. If 'UserPropertyLabel' is indicated, then only user objects that contain a value for this property will be matched. The object's static `spec` table is not used in this process.
   
 - **objType**, ['Type', ...]
   <br>This finds a matching object type, as returned from the `objType()` method. Multiple object type strings can be included in the method call, and this will match against any included type.
   
 - **duration**
   <br>This matches any non-grace note or rest items.
   
 - **note**
   <br>This matches any items that contain one or more notes.
   
 - **noteOrRest**
   <br>This matches any note or rest item, including grace notes.
   
 - **noteAt**, #NotePosition
   <br>This matches any item that contains a note at the designated NotePosition.

 - **bar**
   <br>This matches any bar line.
   
 - **clef**
   <br>This matches any clef.
   
 - **key**
   <br>This matches any key signature.
   
 - **timesig**
   <br>This matches any time signature.
   
 - **dynamic**
   <br>This matches any dynamic.
   
If a match is found, then the `ntnidx` object is moved to this new position, and `true` is returned.

If a match is not found, then the `ntnidx` object is unchanged, and `false` is returned.
