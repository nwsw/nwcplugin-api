# The `nwcdraw` Object
Methods from the `nwcdraw` package can only be used within a draw hook called by the NWC program. The following methods are available from the `nwcdraw` package:

------------------
**nwcdraw.getAspectRatio**(), returns #X-DividedBy-Y

This provides an aspect ratio that can be used to normalize the X and Y coordinates within the userdraw function. 

------------------
**nwcdraw.locate**('ObjType', ['UserType'], [Count])

This function is used to locate the relative position of other areas of the current staff. It is generally used to get the location of the next **item**, **note**, **bar**, or **user** object in the current staff. When locating a user object, you must specify the user object type. The Count is used to skip through multiple matching objects, and can be negative to locate behind the current object.

This function returns multiple values:

- the right side boundary of the target item
- the current/upper position of the target item; bar locations always return the position of the current user object; chords return the highest note position
- the current/lower position of the target item; bar locations always return the position of the current user object; chords return the lowest note position
- the type of item that was located, which is one of 'item', 'note', 'bar', or 'user' (the requested item is not always found, so this indicates what was actually located)


------------------
**nwcdraw.setFontClass**('ClassName')

This method can be used to set the current font for text to one of the predefined font classes. These are the same nwctxt labels as used in the Font: field of Text Expressions.


------------------
**nwcdraw.setFont**('Typeface',#Size,['Style'])

This method can be used to set a new font for text. The Size is in Y coordinates, and can be negative to request that Windows match character height, rather than cell height. The Style is a string that may contain the following characters: 'b' for bold, 'i' for italic, and 'r' for regular text.


------------------
**nwcdraw.getTypeface**(), Returns 'Typeface'


------------------
**nwcdraw.getFontSize**(), Returns #Size


------------------
**nwcdraw.getFontStyle**(), Returns 'Style'


------------------
**nwcdraw.setTypeface**('Typeface')

This method can be used to replace the current Typeface for text. The remaining font attributes will remain unchanged.


------------------
**nwcdraw.setFontSize**(#Size)

This method can be used to change the size of the current font used for text. The remaining font attributes will remain unchanged.


------------------
**nwcdraw.setFontStyle**('Style')

This method can be used to change the style of the current font used for text. The remaining font attributes will remain unchanged.


------------------
**nwcdraw.calcTextSize**('MsgString',['Font']), returns #Width,#Height

This method can be used to get the displayed size of text.  The font is the same nwctxt labels as used in the Font: field of Text Expressions.


------------------
**nwcdraw.alignText**('VertAlign','HorizAlign')

This method sets the current alignment mode for drawing text. VertAlign must be one of 'top', 'baseline', or 'bottom'. HorizAlign must be one of 'left', 'center', or 'right'.


------------------
**nwcdraw.text**('MsgString')

This draws text at the current position, as set by a previous call to the nwcdraw.moveTo method.


------------------
**nwcdraw.angleText**('MsgString', #RotationAngle)

This rotates and draws the MsgString text, starting at the current position.


------------------
**nwcdraw.setPen**('PenStyle',#ThicknessMicrons)

The PenStyle can be one of 'solid', 'dot', or 'dash'. The ThicknessMicrons sets the line thiickness in microns.


------------------
**nwcdraw.moveTo**(#XCoord,[#YCoord])

This sets the current starting position for the next line. Only the X coordinate is required.


------------------
**nwcdraw.hintline**(#XCoord,#YCoord,[#XCoord],[#YCoord])

This draws an editor only hint line. This will only appear when in the editor and Viewer Mode is not enabled. This method works the same way as the **nwcdraw.line** method.


------------------
**nwcdraw.line**(#XCoord,#YCoord,[#XCoord],[#YCoord])

This draws a line using the current pen. Only the first X coordinate is required, as the rest default to the current drawing position (set by nwcdraw.moveTo).


------------------
**nwcdraw.curve**('Direction',#X1,#Y1,[#X2],[#Y2],[#X3],[#Y3])

This draws a horizontal curve, starting at (X1,Y1) and ending at (X3,Y3), which fits the point at (X2,Y2). The PenStyle is the same as for the "line" action. The 'Direction' should be either 'Upward' or 'Downward'.
