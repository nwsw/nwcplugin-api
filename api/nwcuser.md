# The `nwcuser` Object

Each invocation of the `draw` and `play` hooks includes a `nwcuser` object for working with the current User item in the staff, and its surrounding items. It includes the following methods:

<table>
<tr>
<td><a href="#find">find</a></td>
<td><a href="#getNoteCount">getNoteCount</a></td>
<td><a href="#getNotePos">getNotePos</a></td>
<td><a href="#getObjType">getObjType</a></td>
</tr><tr>
<td><a href="#getUserProp">getUserProp</a></td>
<td><a href="#getUserType">getUserType</a></td>
</tr>
</table>


---------------------------------
<a name="getObjType"></a>
**nwcuser.getObjType**([#ItemIndexOffset]), Returns 'ObjType'

This method returns the name of the object at the indicated ItemIndexOffset, with the default being the current user object.


---------------------------------
<a name="getUserType"></a>
**nwcuser.getUserType**([#ItemIndexOffset]), Returns 'UserObjType'

This method returns the type of the current User object, or another User object indicated by ItemIndexOffset. If the item at the designated offset index is not a User item, then Nil is returned.


---------------------------------
<a name="getUserProp"></a>
**nwcuser.getUserProp**([#ItemIndexOffset], 'PropertyLabel'), Returns 'PropertyValue'

This returns the string value for any property that exists in the current user object, or another User object indicated by the optional ItemIndexOffset. If the item at the designated offset index is not a User item, or does not contain the requested property, then Nil is returned.


---------------------------------
<a name="getNoteCount"></a>
**nwcuser.getNoteCount**(#ItemIndexOffset), Returns #NoteCount

This returns the number of notes found at the position indicated by ItemIndexOffset.


---------------------------------
<a name="getNotePos"></a>
**nwcuser.getNotePos**(#ItemIndexOffset,#NoteNumber), Returns #NotePosition

This returns the staff Y coordinate for the given NoteNumber at the position indicated by ItemIndexOffset. The NoteNumber must starts from 1, and will yield valid positions up through nwcuser.getNoteCount note numbers. This function returns Nil if there is no such note number.


---------------------------------
<a name="find"></a>
**nwcuser.find**('action',...,'What',...), Returns #ItemIndexOffset

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

If a match is found, then a valid ItemIndexOffset is returned, which can be used in other functions that accept an ItemIndexOffset. WHen a match is not found, Nil is returned.

