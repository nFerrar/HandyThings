#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>

; Global run loop for all and service
Global $Run = True
Global $ServiceActive = True

; Window settings, cosmetic
Global $Title = "App Monitor"
Global $Content = "Ensures an app is always running."
Global $ContentLeft = 25
Global $ContentTop = 20
Global $SizeX = 300
Global $SizeY = 100

Global $Logging = ""
Global $AppName = ""
Global $AppExe = ""
Global $AppPath = ""
Global $CheckInterval = ""

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

; end service management

;begin GUI

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

; begin service

Func Bool(Const $var)
   If $Var <= 0 Or $Var = "False" Or $Var = "false" Then Return False
   Return True
EndFunc

Func ParseSetting(Const $Region, Const $Name)
   Return IniRead("settings.ini", $Region, $Name, "NULL")
EndFunc

Func AppIsRunning()
   If ProcessExists($AppExe) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func StartApp()
   Run($AppPath)
EndFunc

Func InitialiseService()
   $AppExe = ParseSetting("AppDetails", "Exe")
   $AppPath = ParseSetting("AppDetails", "Path") & "\" & $AppExe
   $CheckInterval = Number(ParseSetting("Monitoring", "CheckIntervalSeconds")) * 1000
   $Logging = ParseSetting("Debug", "Logging")

   If $Logging == True Then
	  MsgBox($MB_SYSTEMMODAL, "", "App Exe: " & $AppExe & @CRLF & "App Path: " & $AppPath & @CRLF & "Check Interval: " & String($CheckInterval))
   EndIf
EndFunc

Func TickService()
   If AppIsRunning() Then
		 Sleep($CheckInterval)
	  Else
		 StartApp()
		 While Not AppIsRunning()
			Sleep($CheckInterval)
		 WEnd
	  EndIf
EndFunc