Gui, Add, Text, x20 y15 w100 h20, AutoHotKey ; macro program title
Gui, Add, Text, x20 y40 w50 h20, state ; state label
Gui, Add, Text, x60 y40 w120 h20 v_state, ready ; current state
Gui, Add, Text, x20 y60 w50 h20, count ; count label
Gui, Add, Text, x60 y60 w50 h20 v_count, 0 ; count
Gui, Add, Button, x20 y90 w100 h20, start ; start
Gui, Add, Button, x20 y120 w100 h20, exit ; exit
Gui, Show

global mWinTitle := "jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)"

global edit_line_1 := "Edit16"
global btn_none := "Button44"
global btn_act := "Button45"
global btn_in := "Button47"
global btn_dial := "Button49"

global macro_start := false
global count := 1 ; number of attempt

FormatTime, mTime, , %A_YYYY%%A_MM%%A_DD%_%A_Hour%%A_Min%_%A_Sec%
log_dir = log_ahk\log_rpi_%mTime%.txt

return

Buttonstart:
{
	
	LogThis("AutoHotKey started")
	
	FileCreateDir, log_ahk
	; create log folder if not exists
	
	CoordMode, Mouse, Window ; necesary?
	
	Gui, Submit, nohide
	GuiControl, , _state, started
	
	macro_start := true
	; count := 0
	
	Sleep, 2000
	
	While (macro_start = true) {	
		LogThis("Attempt: " . count)
		
		; FooClick(189, 469)
		
		RandomCall(RAND(1,3))
		
		count++
		Gui, Submit, nohide
		GuiControl, , _count, %count%		
	}
	
	return
}


Buttonexit:
{
	macro_start := false
	
	LogThis("ExitApp")
	
	ExitApp
	
	return
}


F4::
{
	macro_start := false
	
	LogThis("AutoHotKey aborted")
	
	Gui, Submit, nohide
	GuiControl, , _state, aborted
	
	return
}


; FOO CLICK
FooClick(pos_x, pos_y)
{
	; WinGetPos, w_x, w_y, w_w, w_h, jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)
	
	; foo_x := pos_x - w_x
	; foo_y := pos_y - w_y	
	
	lparam := pos_x|pos_y<<16
	
	foo := (pos_y*65536)+pos_x
	
	PostMessage, 0x201, 1, %lparam%, Button45, %mWinTitle%
	PostMessage, 0x202, 0, %lparam%, Button45, %mWinTitle%
	Sleep, 1000
}

; RANDOM CALL
RandomCall(num)
{
	if (num = 1) {
		IncomingEndingCall()
	}
	if (num = 2) {
		IncomingActiveEndingCall()
	}
	if (num = 3) {
		OutgoingEndingCall()
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR RanndomCall()")
	}
}

; INCOMING-ENDING CALL
IncomingEndingCall()
{
	LogThis("Running Incoming-Ending Call")
	
	; Line Number
	fooNum := Rand(1000, 1999)
	try {
		ControlSetText, %edit_line_1%, %fooNum%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Editing Line 1: " . fooNum)
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Editing Line 1: " . fooNum)
	}
	Sleep, 500
	LogThis("Editing Line 1: " . fooNum)
	
	; Incoming Call
	try {
		ControlClick, %btn_in%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Incoming Call")
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Incoming Call")
	}
	Gui, Submit, nohide
	GuiControl, , _state, InEnd %fooNum% in
	Sleep, Rand(1000, 10000)
	; LogThis("Incoming Call")
	
	; Ending Call
	try {
		ControlClick, %btn_none%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Ending Call")
	}	
	if (ErrorLevel = 1)	{
		LogThis("ERROR Ending Call")
	}
	Gui, Submit, nohide
	GuiControl, , _state, InEnd %fooNum% end
	Sleep, Rand(1000, 10000)
	; LogThis("Ending Call")		
}

; INCOMING-ACTIVE-ENDING CALL
IncomingActiveEndingCall()
{
	LogThis("Running Incoming-Active-Ending Call")
	
	; Line Number
	fooNum := Rand(2000, 2999)
	try {
		ControlSetText, %edit_line_1%, %fooNum%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Editing Line 1: " . fooNum)
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Editing Line 1: " . fooNum)
	}
	Sleep, 500
	LogThis("Editing Line 1: " . fooNum)
	
	; Incoming Call
	try {
		ControlClick, %btn_in%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Incoming Call")
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Incoming Call")
	}
	Gui, Submit, nohide
	GuiControl, , _state, InActEnd %fooNum% in
	Sleep, Rand(1000, 10000)
	; LogThis("Incoming Call")
	
	; Active Call
	try {
		ControlClick, %btn_act%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Active Call")
	}	
	if (ErrorLevel = 1)	{
		LogThis("ERROR Active Call")
	}
	Gui, Submit, nohide
	GuiControl, , _state, InActEnd %fooNum% active
	Sleep, Rand(1000, 10000)
	; LogThis("Active Call")
	
	; Ending Call
	try {
		ControlClick, %btn_none%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Ending Call")
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Ending Call")
	}
	Gui, Submit, nohide
	GuiControl, , _state, InActEnd %fooNum% end
	Sleep, Rand(1000, 10000)
	; LogThis("Ending Call")		
}

; OUTGOING-ENDING CALL
OutgoingEndingCall()
{
	LogThis("Running Outgoing-Ending Call")
	
	; Line Number
	fooNum  := Rand(3000, 3999)
	try {
		ControlSetText, %edit_line_1%, %fooNum%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Editing Line 1: " . fooNum)
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Editing Line 1: " . fooNum)
	}
	Sleep, 500
	LogThis("Editing Line 1: " . fooNum)
	
	; Outgoing Call
	try {
		ControlClick, %btn_dial%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Outgoing Call")
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Outgoing Call")
	}
	Gui, Submit, nohide
	GuiControl, , _state, OutEnd %fooNum% out
	Sleep, Rand(1000, 10000)
	; LogThis("Outgoing Call")
	
	; Ending Call
	try {
		ControlClick, %btn_none%, %mWinTitle%
	} catch e {
		LogThis("EXCEPTION Ending Call")
	}
	if (ErrorLevel = 1)	{
		LogThis("ERROR Ending Call")
	}
	Gui, Submit, nohide
	GuiControl, , _state, OutEnd %fooNum% end
	Sleep, Rand(1000, 10000)
	; LogThis("Ending Call")		
}

; RECORD TIME
LogThis(msg)
{
	global log_dir
	FileAppend, [%A_Mon%/%A_Mday% %A_Hour%:%A_Min%:%A_Sec%][%msg%]`n, %log_dir%
}


; RANDOM FUNCTION
Rand( a=0.0, b=1 ) {
   IfEqual,a,,Random,,% r := b = 1 ? Rand(0,0xFFFFFFFF) : b
   Else Random,r,a,b
   Return r
}
