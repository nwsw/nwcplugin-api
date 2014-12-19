# The NoteWorthy Composer Plugin API

Plugin scripts are automatically loaded by NWC. Each plugin script is responsible for adding the necessary hook functions to enable their functionality.
Currently, the script can assign `play`, `draw`, and `width` functions to a new user object type.
NWC handles the process of loading and saving the user object, as well as controlling its visibility, position, and color properties.
Each script is provided with a restricted/sandboxed environment that provides some specific methods for hooking into NWC, 
getting user object values, locating areas around the object, creating play back events, and drawing lines, curves and text.

The following modules are available, depending on which hook is currently running:

- [nwc](nwc.md)

- [nwcplay](nwcplay.md)

- [nwcdraw](nwcdraw.md) 

The following reference objects are also available for use:

- [nwc.ntnidx](nwc.ntnidx.md)

- [nwc.drawpos](nwc.drawpos.md)


## Plugin Initialization

When a plugin script is loaded, it is responsible for creating the necessary hooks into NWC. 
Currently, there are `play`, `draw`, and `width` hook types. These can be created and assigned to NWC `User` object types.
Refer to the `sethook` and `addUserObjType` methods in the [nwc](nwc.md) object specification. 
