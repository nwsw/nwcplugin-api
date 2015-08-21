# The `nwc` Object

The `nwc` object provides initialization and debugging methods for use the *NoteWorthy Composer* plugin system. These include:

<table>
<tr>
<td><a href='#txt'>txt</a></td>
<td><a href="#VERSION">VERSION</a></td>
<td><a href="#VERSIONTEXT">VERSIONTEXT</a></td>
<td><a href="#VERSIONKEY">VERSIONKEY</a></td>
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
<td><a href="#isset">isset</a></td>
<td><a href="#rawget">rawget</a></td>
</tr>
</table>

---------------------------------
<a name="VERSION"></a>
**nwc.VERSION**

This is a constant that indicates the current version of nwctxt when written to a file. It should generallly indicate the current program version as well, but VERSIONKEY will uniquely identify the sepcific instance of a program version.


---------------------------------
<a name="VERSIONTEXT"></a>
**nwc.VERSIONTEXT**

This is a constant that provides the user readable version text for the program. 


---------------------------------
<a name="VERSIONKEY"></a>
**nwc.VERSIONKEY**

This is a constant that uniquely identifies the current plugin API. It uses a series of version numbers, separated by dots, with each subsequent number being a more minor version indicator. There can be up to five version point release indicators, such as `2.74.97.35.1`.


---------------------------------
<a name="ntnidx"></a>
**nwc.ntnidx**

This is the default instance of a [ntnidx](nwc.ntnidx.md) reference object. It is used to reference an existing notation object in a NWC staff.


---------------------------------
<a name="drawpos"></a>
**nwc.drawpos**

This is the default instance of a [drawpos](nwc.drawpos.md) reference object. It is used to reference an existing notation drawing position while running an object's `width` and `draw` methods.


---------------------------------
<a name="getRunContext"></a>
**nwc.getRunContext**(), Returns 'context1','context2'

This returns a value pair that generally reveals the packages that are available in the currently running context. The returns pairs include:

| Returns | Description |
|:---------------:| -------------------- |
| `init`<br>**nil** | This is generally used while a script is being compiled and loaded into the NWC environment. The [nwc](nwc.md) package is available. |
| `obj`<br>`edit` | This is the context used for the `create`, `spin` and `menuClick` event methods. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), and [nwcui](nwcui.md) (except for `spin`). |
| `obj`<br>`fetch` | This is the context used for the `menuInit` event method. Available packages include [nwc](nwc.md) and [nwc.ntnidx](nwc.ntnidx.md). |
| `obj`<br>`predraw` | This is the context used for the `width` event method. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), and some parts of [nwcdraw](nwcdraw.md) and [nwc.drawpos](nwc.drawpos.md). |
| `obj`<br>`draw` | This is the context used for the `draw` event method. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), [nwcdraw](nwcdraw.md) and [nwc.drawpos](nwc.drawpos.md). |
| `obj`<br>`vplay` | This is the context used for the `transpose` event method. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), and read-only parts of [nwcplay](nwcplay.md). |
| `obj`<br>`play` | This is the context used for the `play` event method. Available packages include [nwc](nwc.md), [nwc.ntnidx](nwc.ntnidx.md), and [nwcplay](nwcplay.md). |


---------------------------------
<a name="hasTypeface"></a>
**nwc.hasTypeface**('font-typeface'), Returns Boolean

This method can be used to identify if a particular font typeface is available on the system before trying to use it. For best performance, it is recommended that this action be done within the plugin startup code. When the plugin is running in the Viewer, this method will trigger a dynamic load of eligible typefaces.


---------------------------------
<a name="isset"></a>
**nwc.isset**(t,'PropertyName'), Returns Boolean

This method can be used to determine if an object property is currently defined in `t`, which is passed into an object's event method.


---------------------------------
<a name="rawget"></a>
**nwc.rawget**(t,'PropertyName'), Returns 'PropertyValue'

This method can be used to retrieve the raw property value in the object's property table `t`. This method can be used to bypass the object's `spec` table. This also works for `ntnidx` user object refences.


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

---------------------------------
<a name="txt"></a>
**nwc.txt**

This is a collection of commonly used text data types used by NoteWorthy Composer. It can be iterated by a script to discover all of its contents. The following script yields the results table below:

```Lua
print('| nwc.txt | Contains |')
print('|:--------:|:---------|')
local typnames = {}
for typname in pairs(nwc.txt) do table.insert(typnames,typname) end
table.sort(typnames)
for i,typname in ipairs(typnames) do
	print('| `'..typname..'` | ',tostring(nwc.txt[typname]),' |')
end
```

| nwc.txt | Contains |
|:--------:|:---------|
| `AttachLyricSyllable` |  Default, Always, Never  |
| `BarLineType` |  Single, Double, BrokenSingle, BrokenDouble, SectionOpen, SectionClose, LocalRepeatOpen, LocalRepeatClose, MasterRepeatOpen, MasterRepeatClose, Transparent  |
| `BoundaryTypes` |  Reset, NewSize, Collapse, EndCollapse, Gap, NewSystem  |
| `ClefType` |  Treble, Bass, Alto, Tenor, Percussion  |
| `DrawFillStyle` |  fill, stroke, strokeandfill  |
| `DrawPenStyle` |  solid, dot, dash  |
| `DrawTextAlign` |  left, center, right  |
| `DrawTextVAlign` |  top, middle, baseline, bottom  |
| `DynamicLevels` |  ppp, pp, p, mp, mf, f, ff, fff  |
| `DynamicVariance` |  Crescendo, Decrescendo, Diminuendo, Rinforzando, Sforzando  |
| `ExpressionJustify` |  Left, Center, Right  |
| `ExpressionPlacement` |  BestFit, BestFitForward, AsStaffSignature, AtNextNote  |
| `FlowDirTypes` |  Coda, Segno, Fine, ToCoda, DaCapo, DCalCoda, DCalFine, DalSegno, DSalCoda, DSalFine  |
| `ItemColor` |  Default, Highlight 1, Highlight 2, Highlight 3, Highlight 4, Highlight 5, Highlight 6, Highlight 7  |
| `ItemVisibility` |  Default, Always, TopStaff, SingleStaff, MultiStaff, Never  |
| `Lyric2NoteAlignment` |  Start of Accidental/Note, Standard Rules  |
| `LyricAlignment` |  Bottom, Top  |
| `MPCControllers` |  tempo, vol, pan, bc, pitch, mod, foot, portamento, datamsb, bal, exp, fx1, fx2, reverb, tremolo, chorus, detune, phaser  |
| `MPCStyle` |  Absolute, Linear Sweep  |
| `MeasureNumStyles` |  None, Plain, Circled, Boxed  |
| `NoteConnectState` |  None, First, Middle, End  |
| `NoteDuration` |  Whole, Half, Quarter, Eighth, Sixteenth, Thirtysecond, Sixtyfourth  |
| `NoteScale` |  A, B, C, D, E, F, G  |
| `ObjLabels` |  Clef, Key, Bar, Ending, Instrument, TimeSig, Tempo, Dynamic, Note, Rest, Chord, SustainPedal, Flow, MPC, TempoVariance, DynamicVariance, PerformanceStyle, Text, RestChord, ChordName, Spacer, RestMultiBar, Boundary, Marker, User  |
| `OctaveShift` |  None, Octave Up, Octave Down  |
| `PerformanceStyle` |  Ad Libitum, Animato, Cantabile, Con brio, Dolce, Espressivo, Grazioso, Legato, Maestoso, Marcato, Meno mosso, Poco a poco, Più mosso, Semplice, Simile, Solo, Sostenuto, Sotto Voce, Staccato, Subito, Tenuto, Tutti, Volta Subito  |
| `PlayMidiCmds` |  noteOff, noteOn, keyAftertouch, controller, patch, channelAftertouch, pitchBend  |
| `SpecialSignatures` |  Standard, Common, AllaBreve  |
| `StaffEndBarLineType` |  Section Close, Master Repeat Close, Single, Double, Open (hidden)  |
| `StaffLabelStyles` |  None, First System, Top Systems, All Systems  |
| `SustainPedalStatus` |  Down, Released  |
| `TempoBase` |  Eighth, Eighth Dotted, Quarter, Quarter Dotted, Half, Half Dotted  |
| `TempoVariance` |  Breath Mark, Caesura, Fermata, Accelerando, Allargando, Rallentando, Ritardando, Ritenuto, Rubato, Stringendo  |
| `TextExpressionFonts` |  StaffSymbols, StaffCueSymbols, StaffItalic, StaffBold, StaffLyric, PageTitleText, PageText, PageSmallText, User1, User2, User3, User4, User5, User6  |
| `TieDir` |  Default, Upward, Downward  |
