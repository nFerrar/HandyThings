#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

; Global run loop for all and service
Global $Run = True
Global $ServiceActive = True

; Window settings, cosmetic
Global $Title = "Window Title"
Global $Content = "Window Content Text"
Global $ContentLeft = 25
Global $ContentTop = 20
Global $SizeX = 300
Global $SizeY = 100

Main()

Func Main()

   ConstructWindow()
   InitialiseService()

   While $Run == True
	  Sleep(5)

	  While $ServiceActive == True
		 Sleep(5)
		 TickService()
	  WEnd

   WEnd

EndFunc

; Begin GUI Functions

Func ConstructWindow()
   Opt("GUICoordMode", 2)
   Opt("GUIResizeMode", 1)
   Opt("GUIOnEventMode", 1)

   GUICreate($Title, $SizeX, $SizeY)
   GUICtrlCreateLabel($Content, $ContentLeft, $ContentTop)

   GUICtrlCreateButton("Start", -50, 25, 45)
   GUICtrlSetOnEvent(-1, "StartPressed")

   GUICtrlCreateButton("Stop", 0, -1)
   GUICtrlSetOnEvent(-1, "StopPressed")

   GUICtrlCreateButton("Close", 0, -1)
   GUICtrlSetOnEvent(-1, "ClosePressed")

   GUISetState(@SW_SHOW)

EndFunc

Func StartPressed()
   $ServiceActive = True
EndFunc

Func StopPressed()
   $ServiceActive = False
EndFunc

Func ClosePressed()
   $ServiceActive = False
   $Run = False
EndFunc

; End GUI functions
; Start Service Function

Func ParseSetting(Const $Region, Const $Name)
   Return IniRead("settings.ini", $Region, $Name, "NULL")
EndFunc

Func InitialiseService()

EndFunc

Func TickService()

EndFunc
