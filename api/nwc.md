# The `nwc` Object

The `nwc` object provides initialization and debugging methods for use the *NoteWorthy Composer* plugin system. These include:

<table>
<tr>
<td><a href="#VERSION">VERSION</a></td>
</tr><tr>
<td><a href="#drawpos">drawpos</a></td>
<td><a href="#ntnidx">ntnidx</a></td>
</tr><tr>
<td><a href="#churnCount">churnCount</a></td>
<td><a href="#churnRate">churnRate</a></td>
<td><a href="#debug">debug</a></td>
<td><a href="#memusage">memusage</a></td>
</tr><tr>
<td><a href="#getRunContext">getRunContext</a></td>
<td><a href="#hasTypeface">hasTypeface</a></td>
</tr>
</table>

---------------------------------
<a name="VERSION"></a>
**nwc.VERSION**

This is a constant that indicates the current version of nwctxt when written to a file. It should generallly indicate the current program version as well.


---------------------------------
<a name="ntnidx"></a>
**nwc.ntnidx**

This is the default instance of a [ntnidx](nwc.ntnidx.md) reference object. It is used to reference an existing notation object in a NWC staff.


---------------------------------
<a name="drawpos"></a>
**nwc.drawpos**

This is the default instance of a [drawpos](nwc.drawpos.md) reference object. It is used to reference an existing notation drawing position while running a user object's `width` and `draw` methods.


---------------------------------
<a name="getRunContext"></a>
**nwc.getRunContext**(), Returns 'context1','context2'

This returns a value pair that generally reveals the packages that are available in the currently running context. The possible returns pairs include:

| Returns | Description |
|:---------------:| -------------------- |
| `init`<br>**nil** | This is generally used while a script is being compiled and loaded into the NWC environment. The [nwc](nwc.md) package is available. |
| `nwcuser`<br>`edit` | This is the context used for the `create` and `spin` event methods in `nwcuser`. Available packages include [nwc](nwc.md) and  [nwc.ntnidx](nwc.ntnidx.md). |
| `nwcuser`<br>`predraw` | This is the context used for the `nwcuser` `width` event method. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), and some parts of [nwcdraw](nwcdraw.md) and [nwc.drawpos](nwc.drawpos.md). |
| `nwcuser`<br>`draw` | This is the context used for the `nwcuser` `draw` event method. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), [nwcdraw](nwcdraw.md) and [nwc.drawpos](nwc.drawpos.md). |
| `nwcuser`<br>`play` | This is the context used for the `nwcuser` `play` event method. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), and [nwcplay](nwcplay.md). |


---------------------------------
<a name="hasTypeface"></a>
**nwc.hasTypeface**('font-typeface'), Returns Boolean

This method can be used to identify if a particular font typeface is available on the system before trying to use it. For best performance, it is recommended that this action be done within the plugin startup code.


---------------------------------
<a name="memusage"></a>
**nwc.memusage**(), Returns Integer

This returns how much memory (in KB) is used by the Lua machine.


---------------------------------
<a name="churnCount"></a>
**nwc.churnCount**(), Returns Integer

This returns the count of new memory requests since the plugin engine was started.

Note that printing or displaying this number will often generate memory churn when the number is converted to a string.


---------------------------------
<a name="churnRate"></a>
**nwc.churnRate**(), Returns Number

This returns a ratio of memory requests versus  plugin method calls. Lower numbers are better.

Note that printing or displaying this result will often generate memory churn when the number is converted to a string.


---------------------------------
<a name="debug"></a>
**nwc.debug**('Message',...)

This directs a message to the debug console. You can also use `print` to do the same thing.
