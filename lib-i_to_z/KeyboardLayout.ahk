; This is just for convenience because the function library is included when it is called.
#include <Threads>

;
; Function: KeyboardLayout_Set
; Description:
;		Sets the supplied keyboard layout for a window with the specified handle or for a foreground window.
; Syntax: KeyboardLayout_Set(hkl [, hWnd])
; Parameters:
;		hkl - keyboard layout id (as returned by GetKeyboardLayout Windows API function).
;		hWnd - (Optional) a window handle (if omitted, the keyboard layout is set for a foreground window).
;
KeyboardLayout_Set(hkl, hWnd = 0)
{
	if (hWnd = 0)
	{
		; OutputDebug ...in the active win
		ControlGetFocus,ctl,A
		SendMessage,0x50,0x0002,%hkl%,%ctl%,A ;WM_INPUTLANGCHANGEREQUEST
	}
	else
	{
		ControlGetFocus,ctl,ahk_id %hWnd%
		; OutputDebug ...not in the active win
		SendMessage,0x50,0x0002,%hkl%,%ctl%,ahk_id %hWnd% ;WM_INPUTLANGCHANGEREQUEST
	}
}

;
; Function: KeyboardLayout_Get
; Description:
;		Gets the keyboard layout of a window with the specified handle or of a foreground window.
; Syntax: KeyboardLayout_Get([hWnd])
; Parameters:
;		hWnd - (Optional) a window handle (if omitted, the keyboard layout is determined for a foreground window).
; Return Value:
; 		Returns a keyboard layout id (as returned by GetKeyboardLayout Windows API function).
; Remarks:
;		Uses Threads_GetThreadOfWindow function.
;
KeyboardLayout_Get(hWnd = 0)
{
	kl := DllCall("GetKeyboardLayout", "uint", Threads_GetThreadOfWindow(hWnd), "uint")
  return kl
}