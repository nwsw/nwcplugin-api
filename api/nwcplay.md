# The `nwcplay` Package

The `nwcplay` package is available during `play` and `transpose` events. The `play` event utilizes a Song Position Pointer and a memory buffer to capture a performance using MIDI events. The Song Position Pointer uses a Pulses per Quarter Note (PPQ) constant as the basis for an item's length/duration into the performance sequence.

The following are available:

<table>
<tr>
<td><a href="#PPQ">PPQ</a></td>
<td><a href="#MAXSPPOFFSET">MAXSPPOFFSET</a></td>
<td><a href="#user">user</a></td>
</tr><tr>
<td><a href="#calcDurLength">calcDurLength</a></td>
<td><a href="#getBarLength">getBarLength</a></td>
<td><a href="#getChannel">getChannel</a></td>
<td><a href="#getClef">getClef</a></td>
</tr><tr>
<td><a href="#getNoteNumber">getNoteNumber</a></td>
<td><a href="#getNoteVelocity">getNoteVelocity</a></td>
<td><a href="#getPerfStyle">getPerfStyle</a></td>
<td><a href="#getPort">getPort</a></td>
</tr><tr>
<td><a href="#getTimeSig">getTimeSig</a></td>
<td><a href="#getTransposition">getTransposition</a></td>
</tr><tr>
<td><a href="#midi">midi</a></td>
<td><a href="#note">note</a></td>
</tr>
</table>


------------------
## Package Details

<a name="PPQ"></a>
**nwcplay.PPQ**

This is a constant that expresses the Pulses Per Quarter Note used when rendering the notation to MIDI.


------------------
<a name="MAXSPPOFFSET"></a>
**nwcplay.MAXSPPOFFSET**

This is a constant that expresses the maximum SPP offset values that can be used for the <a href="#midi">midi</a> and <a href="#note">note</a> methods.


------------------
<a name="user"></a>
**nwcplay.user**

This is a [nwc.ntnidx](nwc.ntnidx.md) reference, initially bound to the current object.


------------------
<a name="getClef"></a>
**nwcplay.getClef**(), Returns 'ClefType'

This returns the active clef at the current play back position.


------------------
<a name="getPerfStyle"></a>
**nwcplay.getPerfStyle**(), Returns 'PerfStyle'

This returns the currently active performance style.


------------------
<a name="getNoteNumber"></a>
**nwcplay.getNoteNumber**([StaffPos]), Returns #NoteNumber

This returns the MIDI note number for the current position on the staff, based on the currently active clef, key, bar accidentals, and transposition. It accepts an offset index relative to the current object's staff position which defaults to 0 (the current object's position).

The `StaffPos` can also be a `nwctxt` specification, as returned by [ntnidx:notePitchPos()](nwc.ntnidx.md#notePitchPos).


------------------
<a name="getChannel"></a>
**nwcplay.getChannel**(), Returns #Channel

This returns the current 0 based MIDI channel number.


------------------
<a name="getPort"></a>
**nwcplay.getPort**(), Returns #Port

This returns the current 0 based MIDI port.


------------------
<a name="getTransposition"></a>
**nwcplay.getTransposition**(), Returns #Semitones

This returns the number of semitones of transposition that apply at the current play back position. This includes an octave offset specified by the clef.


------------------
<a name="getTimeSig"></a>
**nwcplay.getTimeSig**(), Returns #Numerator,#Denominator

This returns the time signature at the current play back position.


------------------
<a name="calcDurLength"></a>
**nwcplay.calcDurLength**('durName'), Returns #SongPulses

This returns the total song pulses associated with the `durName`.

`durName` must be one of the enumeration values from `nwc.txt.NoteDuration` or `nwc.txt.NoteDurBase`.


------------------
<a name="getBarLength"></a>
**nwcplay.getBarLength**(), Returns #SongPulses

This returns the total song pulses contained in the current measure.


------------------
<a name="getNoteVelocity"></a>
**nwcplay.getNoteVelocity**(), Returns #Velocity

This returns the default note velocity at the current play back position.


------------------
<a name="note"></a>
**nwcplay.note**(#offsetSPP,#durationPulses,#midiNoteNumber,[#velocity]), Returns Boolean [,'ErrorText']

This adds a note to the performance relative to the current time position of the object. The channel and port are set by the current staff environment. The durationPulses and offsetSPP are restricted to an area near the current play back position (MAXSPPOFFSET). If the velocity is not specified, then the current velocity from the staff position is used.

Returns false on error, and includes the error text as a second return value.


------------------
<a name="midi"></a>
**nwcplay.midi**(#offsetSPP,'Command',#midiData1,[#midiData2]), Returns Boolean [,'ErrorText']

This adds a midi message into the performance relative to the current time position of the object. The offsetSPP is restricted to an area near the current play back position (MAXSPPOFFSET). The channel and port are set by the current staff environment.

The command must be a valid, non-sysex midi command number, or one of the following command names: noteOff, noteOn, keyAftertouch, controller, patch, channelAftertouch, or pitchBend.

If midiData2 is not provided, then it will be zero.

Returns false on error, and includes the error text as a second return value.
