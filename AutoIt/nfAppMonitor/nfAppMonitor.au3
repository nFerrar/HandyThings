#include <MsgBoxConstants.au3>

Global $Logging = ""
Global $AppName = ""
Global $AppPath = ""
Global $CheckInterval = ""

Main()

Func Bool(Const $var)
   If $Var <= 0 Or $Var = "False" Or $Var = "false" Then Return False
   Return True
EndFunc

Func ParseSetting(Const $Region, Const $Name)
   Return IniRead("settings.ini", $Region, $Name, "NULL")
EndFunc

Func Initialise()
   $AppName = ParseSetting("AppDetails", "Name")
   $AppPath = ParseSetting("AppDetails", "Path") & "\" & $AppName
   $CheckInterval = Number(ParseSetting("Monitoring", "CheckIntervalSeconds")) * 1000
   $Logging = ParseSetting("Debug", "Logging")
EndFunc

Func AppIsRunning()
   If ProcessExists($AppName) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func StartApp()
   Run($AppPath)
EndFunc

Func Main()
   Initialise()

   If $Logging == True Then
	  MsgBox($MB_SYSTEMMODAL, "", "App Name: " & $AppName & @CRLF & "App Path: " & $AppPath & @CRLF & "Check Interval: " & String($CheckInterval))
   EndIf

   While True
	  If AppIsRunning() Then
		 Sleep($CheckInterval)
	  Else
		 StartApp()
		 While Not AppIsRunning()
			Sleep($CheckInterval)
		 WEnd
	  EndIf
   WEnd

EndFunc
