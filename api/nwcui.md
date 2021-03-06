# The `nwcui` Package

The `nwcui` package can only be used while running within an object's `create` and `menuClick` event methods.

The following are available:

<table>
<tr>
<td><a href="#askbox">askbox</a></td>
<td><a href="#fontdlg">fontdlg</a></td>
<td><a href="#msgbox">msgbox</a></td>
<td><a href="#prompt">prompt</a></td>
</tr>
</table>


------------------
## Package Details

<a name="askbox"></a>
**nwcui.askbox**(msg, [msgtitle, flags]), Returns # or nil

This is used to ask the user a yes or no question.

- msg : the message text to issue to the user
- msgtitle : the title for the message box
- flags : assigns the default action, 1 for Yes (default), and 2 for No

Returns 1 for Yes and 0 for No.

User cancel returns `nil`. No further action should be taken by the script.


------------------
<a name="msgbox"></a>
**nwcui.msgbox**(msg, msgtitle), Returns 1 or nil

Issues a message to the user with a standard message box.

Returns 1 during normal operation.

The user is given the opportunity to cancel the current operation, which results in `nil` being returned. No further action should be taken by the script when this is returned.


------------------
<a name="prompt"></a>
**nwcui.prompt**(msg, [datatype, [list-values]], [default]), Returns `Data` or nil

Prompts the user for additional information. The user is given the opportunity to respond to the prompt, or cancel.

Parameters:

| Paramater  | Description |
| ---------- | ----------------------- |
| `msg`      | the message text to issue to the user |
| `datatype` | the kind of control/data that is expected (optional, default="*") |
| `listvals` | the '&' multiple select list requires this extra parameter (required for '&' prompts) |
| `default`  | the default data if the user simply accepts the prompt |

Supported `datatype` strings:

- '*' indicates a single line text response
- '_' indicates a multiple line text response
- '#' indicates a numeric/integer response; the range and spin value can be specified in brackets (e.g. "#[-2,5,1]" supports values from -2 through 5, with a standard increment by one)
- '#.#' indicates a real number response; the range and spin value can be specified in brackets (e.g. "#.#[-9.9,9.9,1.0]" supports values from -9.9 through 9.9, with a standard increment by one)
- '@' indicates a coordinate vector; the maximum range for the x and y value pairs can be specified in brackets (e.g. "@([0,5],[-5,5])" indicates a coordinate where X cannot be less than zero, and Y cannot be less than -5); both an X and Y value are accepted as input data, and both are returned from this function
- '|' indicates a list of items, each separated by a vertical bar (e.g. "|Note|Bar|Rest" contains a list of three elements)
- '&' indicates a list of multi-selectable items, which are provided in the `listvals` parameter; the `default` must be a table of strings pre-selected strings from `listvals`; returns a table of selected strings

The user is given the opportunity to cancel the current operation, which results in `nil` being returned. No further action should be taken by the script when this is returned.

------------------
<a name="fontdlg"></a>
**nwcui.fontdlg**('Typeface',#size,'Style'), Returns 'Typeface',#size,'Style' or nil

Shows a font dialog to the user. A font's typeface, size and style are accepted on input, and returned on output (when confirmed by the user).

The return `Size` parameter is 25% of the point size requested by the user. The style string is suitable for use in [nwcdraw.setFont](nwcdraw.md#setFont).
