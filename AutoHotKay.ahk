
; *********************** Header - some configuration  ***********************
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors. (disabled by default)
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
setTitleMatchMode, 2 ; set title match mode to "contains"

; this code was auto generated at:
; https://www.ahkgen.com/?indexes=0&comment0=Brave&func0=KEY&skey0%5B%5D=WIN&skeyValue0=B&Window0=-Brave&Program0=C%3A%5CProgram+Files%5CBraveSoftware%5CBrave-Browser%5CApplication%5Cbrave.exe&option0=ActivateOrOpen

; *********************** Configured region - selected functions ************

;Brave
#B::ActivateOrOpen("-Brave", "C:\Users\Sahil-PC\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe")

;WindowsTerminal
#T::ActivateOrOpen("-WindowsTerminal", "C:\Users\Sahil-PC\AppData\Local\Microsoft\WindowsApps\wt.exe")

^H::GoSub,CheckActiveWindow

; *********************** Provided Functions ********************************

CheckActiveWindow:
  ID := WinExist("A")
  WinGetClass,Class, ahk_id %ID%
  WClasses := "CabinetWClass ExploreWClass"
  IfInString, WClasses, %Class%
    GoSub, Toggle_HiddenFiles_Display
Return

Toggle_HiddenFiles_Display:
  RootKey = HKEY_CURRENT_USER
  SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

  RegRead, HiddenFiles_Status, % RootKey, % SubKey, Hidden

  if HiddenFiles_Status = 2
      RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 1 
  else 
      RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 2
  PostMessage, 0x111, 41504,,, ahk_id %ID%
Return

ActivateOrOpen(window, program)
{
	; check if window exists
	if WinExist(window)
	{
		WinActivate  ; Uses the last found window.
	}
	else
	{   ; else start requested program
		 Run cmd /c "start ^"^" ^"%program%^"",, Hide ;use cmd in hidden mode to launch requested program
		 WinWait, %window%,,5		; wait up to 5 seconds for window to exist
		 IfWinNotActive, %window%, , WinActivate, %window%
		 {
			  WinActivate  ; Uses the last found window.
		 }
	}
	return
}

^SPACE::  Winset, Alwaysontop, , A

#q:: ; (This is a comment:) Windows+c triggers the following
Send !{f4} ; Simulates the keypress alt+f4
return ; 