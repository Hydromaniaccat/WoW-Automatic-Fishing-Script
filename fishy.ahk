;window size
xMin = 400
xMax = 2000
yMin = 300
yMax = 1000

fishColor = 0xBF93BC;0xF0A09F
colorVariation = 30
gameTitle = World of Warcraft

^Esc::ExitApp
$Esc::Reload

$F1::
	MsgBox, Shift-Esc to reload `nCtr-Esc to exit `nF1 to open this help menu`nF2 to set upper-left bound `nF3 to set lower-right bound `nF4 to set color `nF5 to print information `nF7 to start fishing
	return
	
$F7::
	gosub lure
	
	loop
		{
		Random, time_key, 60, 100
		SetKeyDelay, time_key
		
		WinActivate, %gameTitle%
		
		nextTime := A_Min
		nextTime -= currentTime
		if(nextTime < 0){
			nextTime += 60
		}
		if(nextTime >= 11){
			gosub lure
		}
		
		send, 7 ;PUT FISHING ABILITY INTO SLOT 7
		Random, time_beforeFish, 1000, 1250 ;FISHING CAST TIME
		sleep, time_beforeFish
		gosub fish
		Random, time_betweenFish, 1000, 1250 ;FISH LOOT TIME
		sleep, time_betweenFish
		}
	exitapp
	
	lure: ;SUBROUTINE
		Random, time_key, 60, 100
		sleep time_key

		send, 3 ;APPLY LURE ABILITY INTO SLOT 3
		Random, time_cast, 3000, 4000
		sleep time_cast
		
		currentTime := A_Min
		return
	
	fish: ;SUBROUTINE
		PixelSearch, Px, Py, %xMin%, %yMin%, %xMax%, %yMax%, %fishColor%, %colorVariation%, fast
		Mousemove, %Px%,%Py%,50
		
		Random, time_waitDelay, 8000, 9000 ;FISHING REEL TIME
		sleep, time_waitDelay
		
		send, {Shift Down}
		
		Random, time_key, 60, 100
		sleep, time_key
		
		mouseclick, right
		
		Random, time_key, 60, 100
		sleep, time_key
		
		send, {Shift Up}
		
		Random, time_key, 60, 100
		sleep, time_key
		
		return

$F4::
	MouseGetPos X, Y 
	PixelGetColor Color, %X%, %Y%, RGB
	fishColor = %Color%
	return
	
$F5::
	MsgBox, Selected color: %fishColor%`nx={%xMin%,%xMax%} y={%yMin%,%yMax%}
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