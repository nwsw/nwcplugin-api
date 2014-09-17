# The NoteWorthy Composer Plugin API

Plugin scripts are currently loaded for each new NWC editor window. The script is responsible for adding the necessary hook functions to enable their functionality. Currently, the script can assign a draw or play function for any user object type, while NWC handles the process of loading and saving the object, as well as controlling its visibility, position, and color properties. Each script is provided with a restricted/sandboxed environment that includes [nwc](nwc.md), [nwcplay](nwcplay.md), and [nwcdraw](nwcdraw.md) packages, which enable some specific methods for hooking into NWC, getting user object values, locating areas around the object, creating play back events, and drawing lines, curves and text.


## Plugin Initialization

When a plugin script is loaded, it is responsible for creating the necessary hooks into NWC. Currently, there are `play` and `draw` hook types. These can be created and assigned to NWC `User` object types. Refer to the `sethook` and `addUserObjType` methods in the [nwc](nwc.md) object specification. 