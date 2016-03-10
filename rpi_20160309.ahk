Gui, Add, Text, x20 y15 w100 h20, AutoHotKey ; macro program title
Gui, Add, Text, x20 y40 w50 h20, state ; state label
Gui, Add, Text, x60 y40 w50 h20 v_state, ready ; current state
Gui, Add, Text, x20 y60 w50 h20, count ; count label
Gui, Add, Text, x60 y60 w50 h20 v_count, 0 ; count
Gui, Add, Button, x20 y90 w100 h20, start ; start
Gui, Add, Button, x20 y120 w100 h20, exit ; exit
Gui, Show

macro_start := false

return

Buttonstart:
{
	CoordMode, Mouse, Window ; necesary?
	
	Gui, Submit, nohide
	GuiControl, , _state, start
	
	macro_start := true
	count := 0
	
	Sleep, 2000
	
	While (macro_start = true)
	{		
		; FooClick(189, 469)
		
		; Incoming Call
		ControlClick, Button47, jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)
		Gui, Submit, nohide
		GuiControl, , _state, in
		Sleep, Rand(10000, 15000)
		
		; Answering Call
		/*
		ControlClick, Button62, jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)
		Gui, Submit, nohide
		GuiControl, , _state, active
		Sleep, Rand(10000, 15000)
		*/
		
		; Ending Call
		ControlClick, Button44, jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)
		Gui, Submit, nohide
		GuiControl, , _state, none
		Sleep, Rand(12000, 17000)		
		
		/*
		; Incoming call
		Click, 245, 597 ; Relative
		Sleep, Rand(3000, 5000)		
		; Answering call
		Click, 190, 597 ; Relative
		Sleep, Rand(3000, 5000)
		; Ending call
		Click, 162, 597
		Sleep, Rand(3000, 5000)
		*/
		
		count := count + 1
		Gui, Submit, nohide
		GuiControl, , _count, %count%
		
		/*
		if (count = 10)
		{
			break
		}
		*/
	}			
}
return

Buttonexit:
{
	macro_start := false
	ExitApp
}
return

F4::
{
	macro_start := false
	
	Gui, Submit, nohide
	GuiControl, , _state, Abort
}
return

; FOO CLICK
FooClick(pos_x, pos_y)
{
	; WinGetPos, w_x, w_y, w_w, w_h, jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)
	
	; foo_x := pos_x - w_x
	; foo_y := pos_y - w_y	
	
	lparam := pos_x|pos_y<<16
	
	foo := (pos_y*65536)+pos_x
	
	PostMessage, 0x201, 1, %lparam%, Button45, jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)
	PostMessage, 0x202, 0, %lparam%, Button45, jHMI - Connected to Reference Platform Server version 15.5.0 build 15.5.0-0-gb7acd88 of Jun 26 2015 AllGoldenDevice (Mobile Phone)
	Sleep, 1000
}

; RANDOM FUNCTION
Rand( a=0.0, b=1 ) {
   IfEqual,a,,Random,,% r := b = 1 ? Rand(0,0xFFFFFFFF) : b
   Else Random,r,a,b
   Return r
}
