#include <StringConstants.au3>

Global $Services = []

Main()

Func Main()
   Initialise()

   For $i = 1 To $Services[0]
	  If AppIsRunning($Services[$i]) Then
		 KillProcess($Services[$i])
	  EndIf
   Next

EndFunc

Func ParseSetting(Const $Region, Const $Name)
   Return IniRead("settings.ini", $Region, $Name, "NULL")
EndFunc

Func SplitArray(Const $Source)
   Return StringSplit($Source, ",")
EndFunc

Func Initialise()
   Local $ServicesString
   $ServicesString = ParseSetting("Services", "Names")
   $Services = SplitArray($ServicesString)
EndFunc

Func AppIsRunning(Const $Service)
   If ProcessExists($Service) Then
	  Return True
   Else
	  Return False
   EndIf
EndFunc

Func KillProcess(Const $Service)
   ProcessClose($Service)
EndFunc
