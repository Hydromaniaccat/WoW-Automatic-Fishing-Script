xMin = 400
xMax = 2000
yMin = 300
yMax = 1000

fishColor = 0x450C0B
colorVariation = 30
gameTitle = World of Warcraft

^Esc::ExitApp
$Esc::Reload

$F1::
	MsgBox, Shift-Esc to reload `nCtr-Esc to exit `nF1 to open this help menu`nF2 to set upper-left bound `nF3 to set lower-right bound `nF4 to set color `nF5 to print information `nF7 to start fishing
	return
	
$F7::
	loop
		{
		Random, time_key, 60, 100
		SetKeyDelay, %time_key%
		
		WinActivate, %gameTitle%
		
		send, 7 
		Random, time_beforeFish, 2000, 2250 
		sleep, %time_beforeFish%
		gosub fish
		Random, time_betweenFish, 1300, 1250 
		sleep, %time_betweenFish%
        
        WinGetPos, x1, y1, Width, Height, Program Manager        
        ImageSearch, x2, y2, x1, y1, Width, Height, *80 miniClam.bmp
        
        If (ErrorLevel=0)	{
            send, {Shift Down}

            Random, small_wait, 10, 30
            sleep, %small_wait%
            
            Mousemove, %x2%,%y2%,30
            
            Random, small_wait, 10, 30
            sleep, %small_wait%
            
            mouseclick, right, x2, y2
            
            Random, small_wait, 10, 30
            sleep, %small_wait%
            
            send, {Shift Up}
            
            Random, small_wait, 10, 30
            sleep, %small_wait%
        }
    }
	exitapp
	
	fish: 
        Random, time_key, 2000, 2200
		sleep, %time_key%
        
        PixelSearch, Px, Py, %xMin%, %yMin%, %xMax%, %yMax%, %fishColor%, %colorVariation%, fast
        Py := Py + 5
        Px := Px + 5
        Mousemove, %Px%,%Py%,50
        PixelGetColor target_color, %Px%, %Py%, RGB
        
        time1:=A_Tickcount
        
        loop {
            PixelGetColor color, %Px%, %Py%, RGB
            
            tr := format("{:d}","0x" . substr(target_color,3,2))
            tg := format("{:d}","0x" . substr(target_color,5,2))
            tb := format("{:d}","0x" . substr(target_color,7,2))
            
            pr := format("{:d}","0x" . substr(color,3,2))
            pg := format("{:d}","0x" . substr(color,5,2))
            pb := format("{:d}","0x" . substr(color,7,2))
            
            distance := sqrt((tr-pr)**2+(tg-pg)**2+(pb-tb)**2)
            if(distance>70)
            {
                ;msgbox %distance%
                Random, small_wait, 50, 80
                send, {Shift Down}
		
                Random, small_wait, 10, 30
                sleep, %small_wait%
                
                mouseclick, right
                
                Random, small_wait, 10, 30
                sleep, %small_wait%
                
                send, {Shift Up}
                
                break
            }
            
            time2:=A_Tickcount
            delta:=floor((time2-time1)/1000)
            if(delta >= 20){
                Random, small_wait, 50, 80
                send, {Shift Down}
		
                Random, small_wait, 10, 30
                sleep, %small_wait%
                
                mouseclick, right
                
                Random, small_wait, 10, 30
                sleep, %small_wait%
                
                send, {Shift Up}
                
                break
            }

            sleep, 10
        }
		
		return

$F8::
    MouseGetPos, X, Y
    PixelGetColor color, %X%, %Y%, RGB
            
    tr := format("{:d}","0x" . substr(fishColor,3,2))
    tg := format("{:d}","0x" . substr(fishColor,5,2))
    tb := format("{:d}","0x" . substr(fishColor,7,2))
    
    pr := format("{:d}","0x" . substr(color,3,2))
    pg := format("{:d}","0x" . substr(color,5,2))
    pb := format("{:d}","0x" . substr(color,7,2))
    
    distance := sqrt((tr-pr)**2+(tg-pg)**2+(pb-tb)**2)
     
    msgbox, %color%
    msgbox, %distance%
    return


$F4::
	MouseGetPos X, Y 
	PixelGetColor Color, %X%, %Y%, RGB
	fishColor = %Color%
	return
    
$F6::
	PixelSearch, Px, Py, %xMin%, %yMin%, %xMax%, %yMax%, %fishColor%, %colorVariation%, fast
    Mousemove, %Px%,%Py%,50   
    return
	
$F5::
    MouseGetPos X, Y
	MsgBox, Selected color: %fishColor%`nx={%xMin%,%xMax%} y={%yMin%,%yMax%} `nMousePos={%X%,%Y%}
	return
	
$F2::
	MouseGetPos, xpos, ypos 
	xMin = %xpos%
	yMin = %ypos%
	return
	
$F3::
	MouseGetPos, xpos, ypos 
	xMax = %xpos%
	yMax = %ypos%
	return
    
$F9::
    WinGetPos, x1, y1, Width, Height, Program Manager
    CoordMode, mouse, Screen
    ImageSearch, x2, y2, x1, y1, Width, Height, *100 miniClam.bmp
    If (ErrorLevel=0)	{
        Random, small_wait, 50, 80
        send, {Shift Down}

        Random, small_wait, 10, 30
        sleep, %small_wait%
        
        Mousemove, %x2%,%y2%,60
        
        Random, small_wait, 10, 30
        sleep, %small_wait%
        
        mouseclick, right, x2, y2
        
        Random, small_wait, 10, 30
        sleep, %small_wait%
        
        send, {Shift Up}
        
        Random, small_wait, 10, 30
        sleep, %small_wait%
	}
    return