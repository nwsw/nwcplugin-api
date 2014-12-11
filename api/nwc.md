# The `nwc` Object

The `nwc` object provides setup and initialization methods for hooking into the *NoteWorthy Composer* system. These include:

<table>
<tr>
<td><a href="#VERSION">VERSION</a></td>
</tr><tr>
<td><a href="#addUserObjType">addUserObjType</a></td>
<td><a href="#debug">debug</a></td>
<td><a href="#hasTypeface">hasTypeface</a></td>
<td><a href="#memusage">memusage</a></td>
</tr><tr>
<td><a href="#newRef">newRef</a></td>
<td><a href="#sethook">sethook</a></td>
</tr>
</table>

---------------------------------
<a name="VERSION"></a>
**nwc.VERSION**

This is a constant that indicates the current version of nwctxt when written to a file. It should generallly indicate the current program version as well.


---------------------------------
<a name="newRef"></a>
**nwc.newRef**('RefType'), Returns {RefObject}

This creates a new reference object that can be used in an event hook to access existing NWC objects. 
New reference objects must be created during plugin startup. They cannot be created during event hook
execution.

The 'RefType' must be one of the following string values:

 - '[ntnptr](ref.ntnptr.md)'

 - '[drawpos](ref.drawpos.md)'


---------------------------------
<a name="sethook"></a>
**nwc.sethook**('HookType',...)

This enables a script to hook into existing events or areas of NWC. Possible HookType values include:

 - "**userdraw**" -> 'UserObjType', *Lua-function*
   <br>This enables a local drawing function found in the script to use methods from the nwcdraw package to render any user objects that use this object type.
   
 - "**userplay**" -> 'UserObjType', *Lua-function*
   <br>This enables a local play function, which can use methods from the nwcplay package to send custom MIDI messages for this object type.


---------------------------------
<a name="addUserObjType"></a>
**nwc.addUserObjType**({UserObjectSpecTable})
  
This enables the creation of a new user object type. The UserObjectSpecTable supports the following keys:

- **spec** = 'Object_nwctxt'
<br>The spec key should provide a string that depicts the user object as it should exist initially when added to a staff.
  
- **width** = *Lua-function*
<br>This is the `width` predraw hook function that can be used to increase the horizontal space allotted to a user object. This hook can only be set from here.
  
- **draw** = *Lua-function*
<br>This is the userdraw hook function.
  
- **play** = *Lua-function*
<br>This is the userplay hook function.


---------------------------------
<a name="hasTypeface"></a>
**nwc.hasTypeface**('font-typeface'), Returns Boolean

This method can be used to identify if a particular font typeface is available on the system before trying to use it. For best performance, it is recommended that this action be done within the plugin startup code.


---------------------------------
<a name="memusage"></a>
**nwc.memusage**()

This returns how much memory (in KB) is used by the Lua machine.


---------------------------------
<a name="debug"></a>
**nwc.debug**('Message',...)

This directs a message to the debug console. You can also use `print` to do the same thing.
