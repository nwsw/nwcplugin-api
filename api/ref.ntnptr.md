# `ntnptr` References
This object type enables reference access to the notation items found within a staff. A `ntnptr` object must be declared during plugin startup intialization before it can be used in a hook function.
This is done using the `nwc.newRef` method. Usually, each `ntnptr` object must then be intialized in every hook event function using the appropriate `bind` function to synchronize it with the currently 
active event hook.

The following methods are provided by the `ntnptr` object:

<table>
<tr>
<td><a href="#find">find</a></td>
<td><a href="#locate">goto</a></td>
<td><a href="#noteCount">noteCount</a></td>
<td><a href="#notePos">notePos</a></td>
<td><a href="#notePitchPos">notePitchPos</a></td>
</tr><tr>
<td><a href="#objType">objType</a></td>
<td><a href="#propTable">propTable</a></td>
<td><a href="#staffPos">staffPos</a></td>
<td><a href="#userProp">userProp</a></td>
<td><a href="#userType">userType</a></td>
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
<a name="objType"></a>
**{ntnptr}:objType**(), Returns 'ObjType'

This method returns the name of the current staff object.


------------------
<a name="staffPos"></a>
**{ntnptr}:staffPos**(), returns Number

This returns the staff position of the object. This works best with expression and user objects.


---------------------------------
<a name="propTable"></a>
**{ntnptr}:propTable**(), Returns PropertyTable

This method returns a table containing the nwctxt properties for the object at the ItemIndexOffset, with the default being the current user object.

---------------------------------
<a name="userType"></a>
**{ntnptr}:userType**(), Returns 'UserObjType'

This method returns the type of the current User object, or another User object indicated by ItemIndexOffset. If the item at the designated offset index is not a User item, then Nil is returned.


---------------------------------
<a name="userProp"></a>
**{ntnptr}:userProp**('PropertyLabel'), Returns 'PropertyValue'

This returns the string value for any property that exists in the current user object, or another User object indicated by the optional ItemIndexOffset. If the item at the designated offset index is not a User item, or does not contain the requested property, then Nil is returned.


---------------------------------
<a name="noteCount"></a>
**{ntnptr}:noteCount**(), Returns #NoteCount

This returns the number of notes found at the position indicated by ItemIndexOffset.


---------------------------------
<a name="notePos"></a>
**{ntnptr}:notePos**(#NoteNumber), Returns #NotePosition

This returns the staff Y coordinate for the given NoteNumber at the position indicated by ItemIndexOffset. The NoteNumber must starts from 1, and will yield valid positions up through `{ntnptr}:noteCount` note numbers. This function returns Nil if there is no such note number.


---------------------------------
<a name="notePitchPos"></a>
**{ntnptr}:notePitchPos**(#NoteNumber), Returns 'PitchPosText'

This returns the PitchPos nwctxt for the given NoteNumber at the position indicated by ItemIndexOffset. The NoteNumber must starts from 1, and will yield valid positions up through ntnptr}:noteCount note numbers. This function returns Nil if there is no such note number.

Note that unlike the **getNotePos** function, the position information contained in the 'PitchPosText' is an absolute staff position, and would need to be normalized with a user object's current staff position when using it for drawing.


---------------------------------
<a name="find"></a>
**{ntnptr}:find**('action',...,'What',...), Returns Boolean

This method can be used to find other items on the same staff as the current user object. The following values are supported for the 'action' field:

 - **next**
   <br>Finds the next match to the right of the current user object.
   
 - **prior**
   <br>Finds the prior match to the left of the current user object.
   
 - **first**
   <br>Finds the first match from the start of the staff.
   
 - **last**
   <br>Finds the last match from the end of the staff.
   
 - **before**, #ItemIndexOffset
   <br>Finds the prior match to the left of the specified ItemIndexOffset.

 - **after**, #ItemIndexOffset
   <br>Finds the next match to the right of the specified ItemIndexOffset.

The following values are supported for the 'What' field:

 - **user**, ['UserObjType', 'UserPropertyLabel']
   <br>This finds a matching user object. If 'UserObjType' is indicated, then only user objects of this type will be matched. If 'UserPropertyLabel' is indicated, then only user objects that contain a value for this property will be matched.
   
 - **duration**
   <br>This matches any non-grace note or rest items.
   
 - **note**
   <br>This matches any items that contain one or more notes.
   
 - **noteOrRest**
   <br>This matches any note or rest item, including grace notes and rests.
   
 - **bar**
   <br>This matches any bar line.
   
 - **noteAt**, #NotePosition
   <br>This matches any item that contains a note at the designated NotePosition.

If a match is found, then the `ntnptr` object is moved to this new position, and true is returned.

If a match is not found, then the `ntnptr` object is unchanged, and false is returned.
