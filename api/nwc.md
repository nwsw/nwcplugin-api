# **The nwc package:**

<hr>
**nwc.sethook**('HookType',...)

This enables a script to hook into existing events or areas of NWC. Possible HookType values include:

  "**userdraw**" -> 'UserObjType', _Lua-function_
  This enables a local drawing function found in the script to use methods from the nwcdraw package to render any user objects that use this object type.
  
  "**userplay**" -> 'UserObjType', _Lua-function_
  
  This enables a local play function, which can use methods from the nwcplay package to send custom MIDI messages for this object type.
  
<hr>
**nwc.addUserObjType**({UserObjectSpecTable})
  
This enables the creation of a new user object type. The UserObjectSpecTable supports the following keys:

  **spec** = 'Object_nwctxt'
  
  The spec key should provide a string that depicts the user object as it should exist initially when added to a staff.
  
  **draw** = _Lua-function_
  This is the userdraw hook function.
  
  **play** = _Lua-function_
  This is the userplay hook function.

<hr>
**nwc.hasTypeface**('font-typeface'), Returns Boolean

This method can be used to identify if a particular font typeface is available on the system before trying to use it. For best performance, it is recommended that this action be done within the plugin startup code.

<hr>
**nwc.memusage**()

Each editor window uses its own Lua machine. This returns how much memory (in KB) is used by the current window's Lua instance.

<hr>
**nwc.debug**('Message',...)

This directs a message to the debug console.
