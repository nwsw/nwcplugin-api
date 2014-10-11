# The `nwcdraw` Object
Methods from the `nwcdraw` package can only be used within a draw hook called by the NWC program. 


## About Drawing Coordinates

The draw hook has a two dimensional, floating point, coordinate system relative to its current position in the staff. The point (0,0) is the base point for the object. The **x dimension** uses a notehead width resolution, much like the Spacer object. The **y dimension** uses a staff position system, which is the same as is used by Expression objects. Therefore, a coordinate of (1.5, 2.0) would be one and a half noteheads to the right and two steps up the staff from the user object anchor position.


## Available Methods

The following methods are available from the `nwcdraw` package:

------------------
**nwcdraw.getAspectRatio**(), returns #X-DividedBy-Y

This provides an aspect ratio that can be used to normalize the X and Y coordinates within the userdraw function. 


------------------
**nwcdraw.getTarget**(), returns 'Target'

This indicates the drawing target, which will be one of the following: **edit**, **view**, **print**, or **selector**.


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
**nwcdraw.text**('MsgString', [#RotationAngle])

This draws text at the current position, as set by a previous call to the nwcdraw.moveTo method. The text can be rotated around the current position using the #RotationAngle, which is specified from 0 to 360 degrees, with 0 as the default.


------------------
**nwcdraw.strokeText**('MsgString', [#RotationAngle])

This will render the text using the current pen. The #RotationAngle is the same as for **nwcdraw.text**.


------------------
**nwcdraw.setPen**('PenStyle',#ThicknessMicrons)

The PenStyle can be one of 'solid', 'dot', or 'dash'. The ThicknessMicrons sets the line thiickness in microns.


------------------
**nwcdraw.setWhiteout**([false])

This turns on **whiteout** mode, where everything is drawn in the background color. When printing, this sets the drawing color to White. Specifying **false** in the function call will turn off **whiteout** mode.


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
**nwcdraw.curve**('Direction',#X1,#Y1,...[#Xn],[#Yn])

This draws a horizontal curve, starting at the current position and ending at the last point. The curve will be shaped over or under the intermediate (Xi,Yi) points. The PenStyle is the same as for the "line" action. The 'Direction' should be either 'Upward' or 'Downward'.

The last point's Y coordinate is optional, and will default to the current position if not specified.


------------------
**nwcdraw.bezier**(#X1,#Y1,#X2,[#Y2],[#X3],[#Y3])

This draws a bezier curve, starting at the current position. If X3 is omitted, then a [quadratic bezier curve](https://www.google.com/search?q=quadratic+bezier) is drawn using (X1,Y1) and (X2,Y2), with Y2 defaulting to 0. If X3 is included, then a [cubic bezier curve](https://www.google.com/search?q=cubic+bezier) is drawn, with Y3 defaulting to 0 if not specified.


------------------
**nwcdraw.ellipse**(#Width,#Height)

This draws an ellipse at the current position using the current pen. The #Width is specified as a relative X coordinate, and #Height as a relative Y coordinate. For a circle, one of the coordinate sizes must be normalized using **nwcdraw.getAspectRatio**.


------------------
**nwcdraw.pathBegin**()

This starts a new figure which should be captured as a new path. While rendering into a path, only the line, curve, bezier, and ellipse functions should be used. When the figure has been constucted, you should use **endPath** to close and render the path.

The following will create and fill a rectangle:

```lua
function fillRect(x1,y1,x2,y2)
	nwcdraw.moveTo(x1,y1)
	nwcdraw.pathBegin()
	nwcdraw.line(x2,y1)
	nwcdraw.line(x2,y2)
	nwcdraw.line(x1,y2)
	nwcdraw.closeFigure()
	nwcdraw.endPath("fill")
end
```

------------------
**nwcdraw.closeFigure**()

This will close the current path figure by extending a line to the path origin. This function can only be used while generating a new path.


------------------
**nwcdraw.endPath**("RenderMode")

This closes and renders the current path. The RenderMode should be "stroke" to render the figure using the current pen, or "fill" to alternately paint the figure's interior.

