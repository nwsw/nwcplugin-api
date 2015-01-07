# `ntnidx` References
This object references notation items found within a staff. An existing instance is available as `nwc.ntnidx` in the `nwc` module.
Additional `ntnidx` reference objects must be declared during the plugin `init` context.
This is done using the <a href="#new">new</a> method:

```Lua
local myNotationPtr = nwc.ntnidx.new()
```

The following methods are provided in the `ntnidx` object:
<a name="methodlist"></a>

<table>
<tr>
<td><a href="#new">new</a></td>
<td><a href="#reset">reset</a></td>
<td><a href="#find">find</a></td>
<td><a href="#durationBase">durationBase</a></td>
<td><a href="#indexOffset">indexOffset</a></td>
<td><a href="#isBeamed">isBeamed</a></td>
<td><a href="#isDotted">isDotted</a></td>
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
<td><a href="#staffPos">staffPos</a></td>
<td><a href="#stemDir">stemDir</a></td>
<td><a href="#userProp">userProp</a></td>
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
<a name="indexOffset"></a>
**{ntnidx}:indexOffset**(), Returns IntegerOffset

This returns the offset index from the current user object.


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
**{ntnidx}:isBeamed**([#NoteNumber]), returns 'BeamPosition' or false or nil

Returns **First**, **Middle**, or **End** when a valid note position is part of a beamed group.
Returns false when a valid note position is not part of a beam.


------------------
<a name="isDotted"></a>
**{ntnidx}:isDotted**([#NoteNumber]), returns #Number or false or nil

If this is a note position and is dotted, then the number of dots are returned. Returns false is this note position is not dotted. 
Returns nil if this is not a valid note or rest position.


------------------
<a name="isDotted"></a>
**{ntnidx}:isDotted**([#NoteNumber]), returns #Number or false or nil

If this is a note position and is dotted, then the number of dots are returned. Returns false is this note position is not dotted. 
Returns nil if this is not a valid note or rest position.


------------------
<a name="isGrace"></a>
**{ntnidx}:isGrace**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position is a grace note.


------------------
<a name="isLyricPos"></a>
**{ntnidx}:isLyricPos**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position accepts attached lyric text.


------------------
<a name="isMelisma"></a>
**{ntnidx}:isMelisma**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position accepts attached lyric text, and the position starts a melisma.


------------------
<a name="isMute"></a>
**{ntnidx}:isMute**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position has been specifically muted by the user.


------------------
<a name="isSlurIn"></a>
**{ntnidx}:isSlurIn**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position receives a built-in slur from earlier in the staff.


------------------
<a name="isSlurOut"></a>
**{ntnidx}:isSlurOut**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position starts or extends a slur.


------------------
<a name="isSplitVoice"></a>
**{ntnidx}:isSplitVoice**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position contains dual voicing, such as a split stem chord or a rest chord.


------------------
<a name="isTieIn"></a>
**{ntnidx}:isTieIn**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position receives a note tie from earlier in the staff.


------------------
<a name="isTieOut"></a>
**{ntnidx}:isTieOut**([#NoteNumber]), returns Boolean or nil

Returns **true** when a valid note position starts or extends a tie to the next note at its position.



------------------
<a name="isTriplet"></a>
**{ntnidx}:isTriplet**([#NoteNumber]), returns 'TripletPosition' or false or nil

Returns **First**, **Middle**, or **End** when a valid note position is part of a triplet grouping.
Returns false when a valid note position is not part of a triplet.


---------------------------------
<a name="propTable"></a>
**{ntnidx}:propTable**(), Returns PropertyTable

This method returns a table containing the nwctxt properties for the object.

---------------------------------
<a name="userType"></a>
**{ntnidx}:userType**(), Returns 'UserObjType'

This method returns the type of the current User object. If the item is not a User item, then Nil is returned.


---------------------------------
<a name="userProp"></a>
**{ntnidx}:userProp**('PropertyLabel'), Returns 'PropertyValue'

This returns the string value for any property that exists in the current user object, or Nil if this is not a User object.


---------------------------------
<a name="noteCount"></a>
**{ntnidx}:noteCount**(), Returns #NoteCount

This returns the number of notes found in the object.


---------------------------------
<a name="notePos"></a>
**{ntnidx}:notePos**(#NoteNumber), Returns #NotePosition

This returns the staff Y coordinate for the given NoteNumber. The NoteNumber must start from 1, and will yield valid positions up through `{ntnidx}:noteCount()` note numbers. This function returns Nil if there is no such note number.


---------------------------------
<a name="notePitchPos"></a>
**{ntnidx}:notePitchPos**(#NoteNumber), Returns 'PitchPosText'

This returns the PitchPos nwctxt for the given NoteNumber. The NoteNumber must start from 1, and will yield valid positions up through `{ntnidx}:noteCount()`. This function returns Nil if there is no such note number.

Note that unlike the **notePos** function, the position information contained in the 'PitchPosText' is an absolute staff position, and would need to be normalized with a user object's current staff position when using it for drawing.


---------------------------------
<a name="stemDir"></a>
**{ntnidx}:stemDir**(#NoteNumber), Returns `-1` or `1` or `nil`

This returns a number indicating the stem direction for any valid note position. This returns what is essentially a voicing direction for rests and notes without an actual stem.


---------------------------------
<a name="find"></a>
**{ntnidx}:find**({Action},['What',...]), Returns Boolean

This method can be used to find other items on the same staff as the current object. The following values are supported for the {Action} field:

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
   <br>This finds a matching user object. If 'UserObjType' is indicated, then only user objects of this type will be matched. If 'UserPropertyLabel' is indicated, then only user objects that contain a value for this property will be matched.
   
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
   
If a match is found, then the `ntnidx` object is moved to this new position, and true is returned.

If a match is not found, then the `ntnidx` object is unchanged, and false is returned.
