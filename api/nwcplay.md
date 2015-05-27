# The `nwcplay` Package

The `nwcplay` package is available during `play` and `transpose` events. The `play` event utilizes a Song Position Pointer and a memory buffer to capture a performance using MIDI events. The Song Position Pointer uses a Pulses per Quarter Note (PPQ) constant as the basis for an item's length/duration into the performance sequence.

The following are available:

<table>
<tr>
<td><a href="#PPQ">PPQ</a></td>
<td><a href="#user">user</a></td>
</tr><tr>
<td><a href="#getBarLength">getBarLength</a></td>
<td><a href="#getChannel">getChannel</a></td>
<td><a href="#getClef">getClef</a></td>
<td><a href="#getNoteVelocity">getNoteVelocity</a></td>
</tr><tr>
<td><a href="#getPort">getPort</a></td>
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
<a name="user"></a>
**nwcplay.user**

This is a [nwc.ntnidx](nwc.ntnidx.md) reference, initially bound to the current user object.


------------------
<a name="getClef"></a>
**nwcplay.getClef**(), Returns 'ClefType'

This returns the active clef at the current play back position.


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
<a name="getBarLength"></a>
**nwcplay.getBarLength**(), Returns #SongPulses

This returns the total song pulses contained in the current measure.


------------------
<a name="getNoteVelocity"></a>
**nwcplay.getNoteVelocity**(), Returns #Velocity

This returns the default note velocity at the current play back position.


------------------
<a name="note"></a>
**nwcplay.note**(#offsetSPP,#durationPulses,#midiNoteNumber,[#velocity])

This adds a note to the performance relative to the current time position of the user object. The channel and port are set by the current staff environment. The durationPulses and offsetSPP are restricted to an area near the current play back position. If the velocity is not specified, then the current velocity from the staff position is used.


------------------
<a name="midi"></a>
**nwcplay.midi**(#offsetSPP,'Command',#midiData1,[#midiData2])

This adds a midi message into the performance relative to the current time position of the user object. The channel and port are set by the current staff environment.

The command must be a valid, non-sysex midi command number, or one of the following command names: noteOff, noteOn, keyAftertouch, controller, patch, channelAftertouch, or pitchBend.

If midiData2 is not provided, then it will be zero.
