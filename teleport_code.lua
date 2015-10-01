local fox_last_pressed = Time.GetRawElapsedTimeSinceStartUp() --store the current time when initializing this variable
--init pos variables as null
local fox_store_x = nil 
local fox_store_y = nil
local fox_store_z = nil
function e.Update()
--hook into this update function because it should loop often. Thanks for ThreeSocks for this.

--enables the equip menu each loop in case it was disabled prior
if e.disable_menu then
	vars.playerDisableActionFlag=PlayerDisableAction.NONE
	e.disable_menu = false
end

--check if circle was pressed (the reload button)
if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.RELOAD)==PlayerPad.RELOAD)then
	vars.playerDisableActionFlag=PlayerDisableAction.OPEN_EQUIP_MENU --so the weapon menu doesn't show up
	e.disable_menu = true --toggling this bool so it runs the if statement above 
	
	--if dpad left is pressed while the reload button is pressed (just done by nesting the if statements)
	if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.LEFT)==PlayerPad.LEFT)then
		if (Time.GetRawElapsedTimeSinceStartUp() - fox_last_pressed > 1)then --if one second has passed since we last successfully pressed a bind
			fox_last_pressed = Time.GetRawElapsedTimeSinceStartUp() --store the latest time count
			--storing our current pos in variables (defined as null above this function)
			fox_store_x = vars.playerPosX 
			fox_store_y = vars.playerPosY
			fox_store_z = vars.playerPosZ
			--output a message (thanks to Three-Socks)
			TppUiCommand.AnnounceLogDelayTime(0)
			TppUiCommand.AnnounceLogView("Saved position")
		end --end if time elapsed
	end --end if dpad left is pressed
	
	--if dpad right is pressed while the reload button is pressed (just done by nesting the if statements)
		if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.RIGHT)==PlayerPad.RIGHT)then
			if (Time.GetRawElapsedTimeSinceStartUp() - fox_last_pressed > 1)then --if one second has passed since we last successfully pressed a bind
				fox_last_pressed = Time.GetRawElapsedTimeSinceStartUp() --store the latest time count
				if (fox_store_x ~= nil)then --if there is no stored pos, throw an error
					local t_index={type="TppPlayer2",index=0} --define our player type and index
					local t_loc={id="WarpAndWaitBlock",pos={fox_store_x,fox_store_y,fox_store_z},rotY=0} --the type of command, along with the desired pos and rotation
					GameObject.SendCommand(t_index,t_loc) --execute game command with variables above
					--output a message (thanks to Three-Socks)
					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView("Warped to saved position")
				else
					--output the error message (thanks to Three-Socks)
					TppUiCommand.AnnounceLogDelayTime(0)
					TppUiCommand.AnnounceLogView("You need to save a position before warping!")
				end --end if pos is null
			end --end if time elapsed
		end --end if dpad right is pressed
		
			--if dpad down is pressed while the reload button is pressed (just done by nesting the if statements)
		if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.DOWN)==PlayerPad.DOWN)then 
			if (Time.GetRawElapsedTimeSinceStartUp() - fox_last_pressed > 1)then --if one second has passed since we last successfully pressed a bind
				fox_last_pressed = Time.GetRawElapsedTimeSinceStartUp() --store the latest time count
				local t_index={type="TppPlayer2",index=0} --define our player type and index
				local t_loc={id="WarpAndWaitBlock",pos={vars.initialBuddyPos[0],vars.initialBuddyPos[1],vars.initialBuddyPos[2]},rotY=0} --the type of command, along with our buddy's current pos
				GameObject.SendCommand(t_index,t_loc) --execute game command with variables above
				--output a message (thanks to Three-Socks)
				TppUiCommand.AnnounceLogDelayTime(0)
				TppUiCommand.AnnounceLogView("Warped to buddy position")
			end --end if time elapsed
		end --end if dpad down is pressed
	
end -- end if circle is pressed

e.UpdateDeliveryWarp()
end