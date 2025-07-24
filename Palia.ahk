#SingleInstance Force

; Remapping actif uniquement pour Palia Steam
#HotIf WinActive("ahk_exe PaliaClientSteam-Win64-Shipping.exe")

&::F1
é::F2
"::F3
'::F4
(::F5
-::F6
è::F7
_::F8

#HotIf

; Quitter le script avec Ctrl+Alt+Q
^!q::ExitApp
