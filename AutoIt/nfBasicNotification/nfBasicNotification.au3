#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>

; Window settings, cosmetic
Global $Title = ""
Global $Content = ""
Global $ContentLeft = 25
Global $ContentTop = 20
Global $SizeX = 300
Global $SizeY = 125

Global $ShowProg = "false"

Global $ProgSizeX = $SizeX - ($ContentLeft * 2)
Global $ProgSizeY = $ContentTop
Global $ProgTop = $SizeY - ($ContentTop * 2)
Global $ProgLeft = $ContentLeft

Global $Progress

Main()

Func Main()

   Initialise()

   ConstructWindow()

   Local $i = 0

   While True
	  Sleep(10)
	  If $ShowProg = "true" Then
		 $i += 1
		 GUICtrlSetData($Progress, $i)
		 If $i > 150 Then
			$i = 0
		 EndIf
	  EndIf
   WEnd

EndFunc

Func Initialise()

   If $CmdLine[0] = 1 Then
	  $Title = "nfNotification"
	  $Content = $CmdLine[1]
	  $ShowProg = "false"
   ElseIf $CmdLine[0] = 2 Then
	  $Title = $CmdLine[2]
	  $Content = $CmdLine[1]
	  $ShowProg = "false"
   ElseIf $CmdLine[0] = 3 Then
	  $Title = $CmdLine[2]
	  $Content = $CmdLine[1]
	  $ShowProg = StringLower($CmdLine[3])
   Else
	  $Title = "nfNotification"
	  $Content = "No content or title passes, or too many arguments." & @CRLF & "use thusly:" & @CRLF & "nfBasicNotification.exe [content] ([title] [showProg {t/f})"
	  $ShowProg = "true"
   EndIf

EndFunc



;begin GUI

Func ConstructWindow()
   ;Opt("GUICoordMode", 2)
   Opt("GUIResizeMode", 1)
   Opt("GUIOnEventMode", 1)

   GUICreate($Title, $SizeX, $SizeY)
   GUICtrlCreateLabel($Content, $ContentLeft, $ContentTop)

   If $ShowProg = "true" Then
	  $Progress = GUICtrlCreateProgress($ProgLeft, $ProgTop, $ProgSizeX, $ProgSizeY)
   EndIf

   GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")

   GUISetState(@SW_SHOW)

EndFunc

Func CLOSEButton()
   Exit
EndFunc

; End GUI functions

; functional functions, Fun

Func KillProcess(Const $Service)
   ProcessClose($Service)
EndFunc