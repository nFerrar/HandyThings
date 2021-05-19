#include <MsgBoxConstants.au3>

Global $Logging = ""
Global $AppName = ""
Global $CheckInterval = ""

Global $WinHandle

Main()

Func ParseSetting(Const $Region, Const $Name)
   Return IniRead("settings.ini", $Region, $Name, "NULL")
EndFunc

Func Initialise()
   $AppName = ParseSetting("AppDetails", "Name")
   $CheckInterval = Number(ParseSetting("Monitoring", "CheckIntervalSeconds")) * 1000
   $Logging = ParseSetting("Debug", "Logging")

   If $Logging == True Then
	  MsgBox($MB_SYSTEMMODAL, "", "App Name: " & $AppName & @CRLF & "Check Interval: " & String($CheckInterval))
   EndIf
EndFunc

Func GetWindowHandle()
   $WinHandle = WinWaitActive($AppName)
EndFunc

Func Main()
   Initialise()

   While True
	  If Not IsHWnd($WinHandle) Then
		 GetWindowHandle()
	  EndIf
	  WinActivate($WinHandle)
	  Sleep($CheckInterval)
   WEnd
EndFunc
