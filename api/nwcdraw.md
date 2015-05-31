# The `nwcdraw` Package
The `nwcdraw` package provides utility functions for use by a user object's `width` and `draw` event methods.

The following functions are available in both the `width` and `draw` events:

<table>
<tr>
<td><a href="#user">user</a></td>
</tr><tr>
<td><a href="#calcTextSize">calcTextSize</a></td>
<td><a href="#getAspectRatio">getAspectRatio</a></td>
<td><a href="#getFontSize">getFontSize</a></td>
<td><a href="#getFontStyle">getFontStyle</a></td>
</tr><tr>
<td><a href="#getMicrons">getMicrons</a></td>
<td><a href="#getPageCounter">getPageCounter</a></td>
<td><a href="#getSystemCounter">getSystemCounter</a></td>
</tr><tr>
<td><a href="#getTarget">getTarget</a></td>
<td><a href="#getTypeface">getTypeface</a></td>
<td><a href="#isAutoInsert">isAutoInsert</a></td>
<td><a href="#isDrawing">isDrawing</a></td>
</tr><tr>
<td><a href="#setFont">setFont</a></td>
<td><a href="#setFontClass">setFontClass</a></td>
<td><a href="#setFontSize">setFontSize</a></td>
<td><a href="#setFontStyle">setFontStyle</a></td>
</tr><tr>
<td><a href="#setTypeface">setTypeface</a></td>
</tr>
</table>

These remaining functions can only be used from the `draw` event method (when `nwcdraw.isDrawing()` returns true):

<table>
<tr>
<td><a href="#alignText">alignText</a></td>
<td><a href="#bezier">bezier</a></td>
<td><a href="#curve">curve</a></td>
<td><a href="#ellipse">ellipse</a></td>
<td><a href="#getPageMargin">getPageMargin</a></td>
</tr><tr>
<td><a href="#hintline">hintline</a></td>
<td><a href="#line">line</a></td>
<td><a href="#moveTo">moveTo</a></td>
<td><a href="#rectangle">rectangle</a></td>
<td><a href="#roundRect">roundRect</a></td>
</tr><tr>
<td><a href="#setPen">setPen</a></td>
<td><a href="#setWhiteout">setWhiteout</a></td>
<td><a href="#strokeText">strokeText</a></td>
<td><a href="#text">text</a></td>
</tr><tr>
<td><a href="#beginPath">beginPath</a></td>
<td><a href="#closeFigure">closeFigure</a></td>
<td><a href="#endPath">endPath</a></td>
<td><a href="#width">width</a></td>
</tr>
</table>

------------------
## About Drawing Coordinates

The `draw` event has a two dimensional, floating point, coordinate system relative to its current position in the staff. The point (0,0) is the base point for the object. The **x dimension** uses a notehead width resolution, much like the
Spacer object. The **y dimension** uses a staff position system, which is the same as is used by Expression objects. A coordinate of (1.5, 2.0) would be one and a half noteheads to the right and two steps up the staff from the user object's anchor position.


------------------
## Package Details

<a name="user"></a>
**nwcdraw.user**

This is a [nwc.drawpos](nwc.drawpos.md) reference, initially bound to the current user object.


------------------
<a name="getAspectRatio"></a>
**nwcdraw.getAspectRatio**(), returns #X-DividedBy-Y

This provides an aspect ratio that can be used to normalize the X and Y coordinates within the `nwcdraw` system.

```lua
local cx = 0.3
local cy = cx*nwcdraw.getAspectRatio()
```

------------------
<a name="getMicrons"></a>
**nwcdraw.getMicrons**([#Width],[#Height]), returns #XMicrons,#YMicrons

This can be used to measure a width and or height value and return the result in microns. Width and Height will default to 1.0 if not specified.


------------------
<a name="getTarget"></a>
**nwcdraw.getTarget**(), returns 'Target'

This indicates the drawing target, which will be one of the following: **edit**, **view**, **print**, or **selector**.


------------------
<a name="isDrawing"></a>
**nwcdraw.isDrawing**(), returns Boolean or nil

This indicates if the `draw` event is currently active. If neither `draw` nor `width` is currently active, then this returns nil.


------------------
<a name="isAutoInsert"></a>
**nwcdraw.isAutoInsert**(), returns Boolean

This indicates if the current user object has been automatically inserted at the start of the current system. When the drawing target is `print`, an auto-inserted drawing position will typically be at the start of the system staff. When in `edit` or `view` targets, the auto-inserted drawing position will typically be off screen (not visible to the user).


------------------
<a name="setFontClass"></a>
**nwcdraw.setFontClass**('ClassName')

This method can be used to set the current font for text to one of the predefined font classes, which include:

- StaffSymbols, StaffCueSymbols
- StaffItalic, StaffBold, StaffLyric
- PageTitleText, PageText, PageSmallText
- User1 through User6


------------------
<a name="setFont"></a>
**nwcdraw.setFont**('Typeface',#Size,['Style'])

This method can be used to set a new font for text. The Size is in Y coordinates, and can be negative to request that Windows match character height, rather than cell height. The Style is a string that may contain the following characters: 'b' for bold, 'i' for italic, and 'r' for regular text.


------------------
<a name="getTypeface"></a>
**nwcdraw.getTypeface**(), Returns 'Typeface'


------------------
<a name="getFontSize"></a>
**nwcdraw.getFontSize**(), Returns #Size


------------------
<a name="getFontStyle"></a>
**nwcdraw.getFontStyle**(), Returns 'Style'


------------------
<a name="getPageCounter"></a>
**nwcdraw.getPageCounter**(), Returns #Number

This returns the current page counter. In edit mode, this always returns 1. When printing, this returns the target page number, starting with 1.


------------------
<a name="getPageMargin"></a>
**nwcdraw.getPageMargin**(), Returns #Left,#Top,#Right,#Bottom

During a printer-based `draw` event, this returns the left, top, right, and bottom coordinates of the current page, as controlled by the page margins. In edit mode, this just returns the bounding area of the current user object.


------------------
<a name="getSystemCounter"></a>
**nwcdraw.getSystemCounter**(), Returns #Number

This returns the current system counter. In edit mode, this always returns 1. When printing, this returns the target system number, starting with 1.

------------------
<a name="setTypeface"></a>
**nwcdraw.setTypeface**('Typeface')

This method can be used to replace the current Typeface for text. The remaining font attributes will remain unchanged.


------------------
<a name="setFontSize"></a>
**nwcdraw.setFontSize**(#Size)

This method can be used to change the size of the current font used for text. The remaining font attributes will remain unchanged.


------------------
<a name="setFontStyle"></a>
**nwcdraw.setFontStyle**('Style')

This method can be used to change the style of the current font used for text. The remaining font attributes will remain unchanged.


------------------
<a name="calcTextSize"></a>
**nwcdraw.calcTextSize**('MsgString'), returns #Width,#Height,#Descent

This method can be used to get the rendered size of the text. The #Descent is the distance to the baseline of the text.


------------------
<a name="alignText"></a>
**nwcdraw.alignText**('VertAlign','HorizAlign')

This method sets the current alignment mode for drawing text. VertAlign must be one of 'top', 'middle', 'baseline', or 'bottom'. HorizAlign must be one of 'left', 'center', or 'right'.


------------------
<a name="text"></a>
**nwcdraw.text**('MsgString', [#RotationAngle])

This draws text at the current position, as set by a previous call to the nwcdraw.moveTo method. The text can be rotated around the current position using the #RotationAngle, which is specified from 0 to 360 degrees, with 0 as the default.


------------------
<a name="strokeText"></a>
**nwcdraw.strokeText**('MsgString', [#RotationAngle])

This will render the text using the current pen. The #RotationAngle is the same as for **nwcdraw.text**.


------------------
<a name="setPen"></a>
**nwcdraw.setPen**('PenStyle',#ThicknessMicrons)

The PenStyle can be one of 'solid', 'dot', or 'dash'. The ThicknessMicrons sets the line thickness in microns.


------------------
<a name="setWhiteout"></a>
**nwcdraw.setWhiteout**([false])

This turns on **whiteout** mode, where everything is drawn in the background color. When printing, this sets the drawing color to White. Specifying **false** in the function call will turn off **whiteout** mode.


------------------
<a name="moveTo"></a>
**nwcdraw.moveTo**(#XCoord,[#YCoord])

This sets the current starting position for the next line. Only the X coordinate is required.


------------------
<a name="hintline"></a>
**nwcdraw.hintline**(#XCoord,#YCoord,[#XCoord],[#YCoord])

This draws an editor only hint line. This will only appear when in the editor and Viewer Mode is not enabled. This method works the same way as the **nwcdraw.line** method.


------------------
<a name="line"></a>
**nwcdraw.line**(#XCoord,#YCoord,[#XCoord],[#YCoord])

This draws a line using the current pen. Only the first X coordinate is required, as the rest default to the current drawing position (set by nwcdraw.moveTo).


------------------
<a name="curve"></a>
**nwcdraw.curve**('Direction',#X1,#Y1,...[#Xn],[#Yn])

This draws a horizontal curve, starting at the current position and ending at the last point. The curve will be shaped over or under the intermediate (Xi,Yi) points. The PenStyle is the same as for the "line" action. The 'Direction' should be either 'Upward' or 'Downward'.

The last point's Y coordinate is optional, and will default to the current position if not specified.


------------------
<a name="bezier"></a>
**nwcdraw.bezier**(#X1,#Y1,#X2,[#Y2],[#X3],[#Y3])

This draws a bezier curve, starting at the current position. If X3 is omitted, then a [quadratic bezier curve](https://www.google.com/search?q=quadratic+bezier) is drawn using (X1,Y1) and (X2,Y2), with Y2 defaulting to 0. If X3 is included, then a [cubic bezier curve](https://www.google.com/search?q=cubic+bezier) is drawn, with Y3 defaulting to 0 if not specified.


------------------
<a name="rectangle"></a>
**nwcdraw.rectangle**(#Width,#Height)

This draws a rectangle from the current position using the current pen. The (#Width,#Height) pair defines the relative position of the far corner of the rectangle.

For a square, one of the dimensions must either be normalized using **nwcdraw.getAspectRatio**, or not specified so it will be calculated based on the other dimension.


------------------
<a name="roundRect"></a>
**nwcdraw.roundRect**(#X_Offset,[#Y_Offset],[#RoundingWidth],[#RoundingHeight])

This draws a rectangle around the current position using the current pen. The (#X_Offset,#Y_Offset) pair defines the distance to the right and top edges of the rectangle.

The (#RoundingWidth, #RoundingHeight) pair define an optional major and minor radius used for rounding of the rectangle's corners.

For a square, one of the dimensions must either be normalized using **nwcdraw.getAspectRatio**, or not specified so it will be calculated based on the other dimension.


------------------
<a name="ellipse"></a>
**nwcdraw.ellipse**(#X_Radius,#y_Radius)

This draws an ellipse around the current position using the current pen. The #X_Radius and #Y_Radius are relative coordinates which define the major and minor radius for the ellipse.

For a circle, one of the dimensions must either be normalized using **nwcdraw.getAspectRatio**, or not specified so it will be calculated based on the other dimension.


------------------
<a name="beginPath"></a>
**nwcdraw.beginPath**()

This starts a new figure which should be captured as a new path. While rendering into a path, only the line, curve, bezier, rectangle, roundRect and ellipse functions should be used. When the figure has been constructed, you should use **endPath** to close and render the path.

The following will create and fill a triangle:

```lua
function fillTriangle(x1,y1,x2,y2,x3,y3)
	nwcdraw.moveTo(x1,y1)
	nwcdraw.beginPath()
	nwcdraw.line(x2,y2)
	nwcdraw.line(x3,y3)
	nwcdraw.line(x1,y1)
	nwcdraw.closeFigure()
	nwcdraw.endPath("fill")
end
```

------------------
<a name="closeFigure"></a>
**nwcdraw.closeFigure**()

This will close the current path figure by extending a line to the path origin. This function can only be used while generating a new path.


------------------
<a name="endPath"></a>
**nwcdraw.endPath**("RenderMode")

This closes and renders the current path. The RenderMode should be one of:

- "fill" to alternately paint the figure's interior
- "stroke" to render the figure using the current pen
- "strokeandfill" to do both (this is the default)


------------------
<a name="width"></a>
**nwcdraw.width**(), Returns #Size

This return the staff width reserved for the current user object.
