Global $AppExe = ""

Main()

Func Main()
   Initialise()

   If AppIsRunning() Then
	  KillProcess()
   EndIf

EndFunc

Func ParseSetting(Const $Region, Const $Name)
   Return IniRead("settings.ini", $Region, $Name, "NULL")
EndFunc

Func Initialise()
   $AppExe = ParseSetting("AppDetails", "Exe")
EndFunc

Func AppIsRunning()
   If ProcessExists($AppExe) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func KillProcess()
   ; taskkill /F /IM $AppExe -t
   ; Local $Cmd = " taskkill /F /IM " & $AppExe & " -t"
   ; RunWait(@ComSpec & $Cmd, "", @SW_HIDE)
   ProcessClose($AppExe)
EndFunc
