# The `nwcplay` Object

Methods from the `nwcplay` object can only be used while running within a *play hook* called by the NWC program. The following methods are available from the `nwcplay` package:


## About Play Song Position

The `play` hook utilizes a Song Position Pointer and a MIDI buffer to create a performance using MIDI events. The Song Position Pointer uses a Pulses per Quarter Note (PPQ) constant as the basis for an item's length/duration into the performance sequence.

## Available Methods

The following are available from the `nwcplay` object:


------------------
**nwcplay.PPQ**

This is a constant that expresses the Pulses Per Quarter Note used when rendering the notation to MIDI.


------------------
**nwcplay.getClef**(), Returns 'ClefType'

This returns the active clef at the current play back position.


------------------
**nwcplay.getTransposition**(), Returns #Semitones

This returns the number of semitones of transposition that apply at the current play back position. This includes an octave offset specified by the clef.


------------------
**nwcplay.getTimeSig**(), Returns #Numerator,#Denominator

This returns the time signature at the current play back position.


------------------
**nwcplay.getBarLength**(), Returns #SongPulses

This returns the total song pulses contained in the current measure/bar.


------------------
**nwcplay.getNoteVelocity**(), Returns #Velocity

This returns the default note velocity at the current play back position.


------------------
**nwcplay.locate**('ObjType', ['UserType'], [Count])

This function is used to locate the the play time offset to adjacent items in the current staff. It is generally used to get the song position of the next **item**, **note**, **bar**, or **user** object in the current staff. When locating a user object, you must specify the user object type. The Count is used to skip through multiple matching objects, and can be negative to locate behind the current object.

This function returns multiple values:

- the play back duration to the item
- the type of item that was located, which is one of 'item', 'note', 'bar', or 'user' (the requested item is not always found, so this indicates what was actually located)


------------------
**nwcplay.note**(#offsetSPP,#durationPulses,#midiNoteNumber,[#velocity])

This adds a note to the performance relative to the current time position of the user object. The channel and port are set by the current staff environment. The durationPulses and offsetSPP are restricted to an area near the current play back position. If the velocity is not specified, then the current velocity from the staff position is used.


------------------
**nwcplay.midi**(#offsetSPP,'Command',#midiData1,[#midiData2])

This adds a midi message into the performance relative to the current time position of the user object. The channel and port are set by the current staff environment.

The command must be a valid, non-sysex midi command number, or one of the following command names: noteOff, noteOn, keyAftertouch, controller, patch, channelAftertouch, or pitchBend.

If midiData2 is not provided, then it will be zero in the message.
