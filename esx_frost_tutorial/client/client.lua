-------------- DO NOT TRADE/SELL THIS SCRIPT IT IS 100% FREE ON FIVEM FORUMS ------------------------
--[[
	The Tutorial System [BY KRIZFROST]
]]
--[[
	Tips:
	• DO NOT EDIT THE CODE UNLESS YOU KNOW WHAT YOU ARE DOING
	Information:
	• The only reason I had implemented ESX is to display the help notifications as well as the basic notifications that appear besides that this could honestly be a standalone script
	• To change the prices change the price on in server.lua
	• If you'd like to get help on this and see more of my projects join the discord https://discord.gg/yjyugBu
	Credits: 
	• KrizFrost - Base Code

]]
--- Blip Added 

local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     {title="Tutorial", colour=17, id=66, x = -195.14, y = -830.31, z = 29.8}
  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Key = 38 --- E


local ESX = nil
local PlayerData                = {}
--[[
	Loading ESX Data
]]

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--[[
	Location of Tutorial Spot If you change this you need to change the blip location as well
]]
TutorialStation = {
	{-195.14, -830.31, 29.8}
}


function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
			for i = 1, #TutorialStation do
				tutcoords = TutorialStation[i]
				DrawMarker(-27, tutcoords[1], tutcoords[2], tutcoords[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tutcoords[1], tutcoords[2], tutcoords[3], true ) < 5 then
				 ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ for Tutorial Menu')
					if(IsControlJustPressed(1, Key)) then
						TutorialFunction() --- Tutorial Function
						insidemarkercheck = true
					end
				end
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), tutcoords[1], tutcoords[2], tutcoords[3], true ) > 5 then
					    if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'civtutorial_menu') then
       						ESX.UI.Menu.CloseAll()
   					end
				end
			end
	end
end)
local menuEnabled = false 
function ToggleActionMenu()
	-- Make the menuEnabled variable not itself 
	-- e.g. not true = false, not false = true 
	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 
		-- Focuses on the NUI, the second parameter toggles the 
		-- onscreen mouse cursor. 
		SetNuiFocus( true, true )

		-- Sends a message to the JavaScript side, telling it to 
		-- open the menu. 
		SendNUIMessage({
			showmenu = true 
		})
	else 
		-- Bring the focus back to the game
		SetNuiFocus( false )

		-- Sends a message to the JavaScript side, telling it to
		-- close the menu.
		SendNUIMessage({
			hidemenu = true 
		})
	end 
end


--DO-NOT-EDIT-BELLOW-THIS-LINE--
--DO-NOT-EDIT-BELLOW-THIS-LINE--
--DO-NOT-EDIT-BELLOW-THIS-LINE--
--DO-NOT-EDIT-BELLOW-THIS-LINE--

function TutorialFunction() -- Tutorial Menu and Majic ( DO NOT EDIT UNLESS YOU KNOW WHAT YOU ARE DOING )

    local elements = {
        { label = 'Basic Walkthrough', value = "basic_tutorial" }
    }

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'civtutorial_menu',
        {
            title    = "<font color='lightblue' font-size='15px'>Tutorial Menu</font>",
            align    = 'center',
            elements = elements
        },
    function(data, menu)

        local action = data.current.value

        if action == "basic_tutorial" then
       local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    TriggerEvent('chat:clear')  --- Clear current chat
    TriggerEvent('chat:toggleChat') --- Toggle chat chat
    createdCamera = cam --- Create Cam
    SetEntityVisible(playerPed, false, 0) --- Make Player Invisible
    SetEntityCoordsNoOffset(playerPed, -103.8, -921.06, 287.29, false, false, false, true) --- Teleport Infront of Maze Bank IN Air
    FreezeEntityPosition(playerPed, true) --- Freeze The Player There
    SetFocusEntity(playerPed) ---- Focus on the player (To Render the building)
    SetCamCoord(cam, -103.8, -921.06, 287.29) --- Set the camera there
    RenderScriptCams(1, 0, 0, 1, 1) --- Render Cams
    ESX.ShowHelpNotification('Welcome To ~b~CivLife RP~w~ Serious RP\nWe strive to provide the best experiences for our community.')
    Citizen.Wait(250)
    Citizen.Wait(5000)
    ESX.ShowHelpNotification('This process will teach you the basic things in our city to avoid any confusion when you first join.')
    Citizen.Wait(6050)
    ESX.ShowHelpNotification('Lets Begin')
    Citizen.Wait(2000)
    Citizen.Trace('(*<*)Stay Frosty(*<*) - By KrizFrost')
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, -249.46, -991.05, 35.23, false, false, false, true) --- Teleport Player Infront Job Center
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -249.46, -991.05, 35.23) -- Set the Camera Infront of the Job Center
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    Citizen.Trace('(*<*)Stay Frosty(*<*) - By KrizFrost')
    ESX.ShowHelpNotification('~b~Job Center\n~w~Here you can come and get a job that you would like to do so you can make money.')
    Citizen.Wait(5000)
    ESX.ShowNotification('We have Custom Jobs that are whitelist so some jobs may not be listed here and you may need to-')
    Citizen.Wait(2000)
    ESX.ShowNotification('Get hired by speaking to people in character in RP')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, 205.83, -823.55, 35.42, false, false, false, true) --- Teleport Player Infront Legion Garage
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 205.83, -823.55, 35.42) -- Set the Camera Infront of the Legion Garage
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Trace('(*<*)Stay Frosty(*<*) - By KrizFrost')
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~b~Legion Garage\n~w~We have multiple garages that allow you to store cars you purchase around the-')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('map once you purchase a vehicle you can come here to store the vehicle or take it out.')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('~o~Remember:\nYou can pay money at these locations to retrieve your vehicle if its impounded.')
    Citizen.Wait(9000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, 314.85, -263.49, 59.86, false, false, false, true) --- Teleport Player Infront Pink Hotel
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 314.85, -263.49, 59.86) -- Set the Camera Infront of the Pink Hotel
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~b~Hotels\n~w~The City provides a few spawn points when you join back into the city this is one.')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('Here you can purchase your hotel room for a price and you can invite your friends in-')
    Citizen.Wait(8000)
    ESX.ShowHelpNotification('and store your items & Money inside your hotel room')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('~o~Remember:\nDo not store any weapons in here cause they will not save inside your apartment.')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, 65.42, -1904.3, 27.93, false, false, false, true) --- Teleport Player Infront Grove Street
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 65.42, -1904.3, 27.93) -- Set the Camera Infront of the Grove Street
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    SetCamRot(cam, 0.0, 0.0, -125.0)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~r~Weapons\n~w~You can get illegal weapons at the black market with your dirty money-')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('You obtain dirty  money by selling drugs to NPCs or from others players.')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, 6.44, -1140.07, 31.93, false, false, false, true) --- Teleport Player Infront Ammunation
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 6.44, -1140.07, 31.93) -- Set the Camera Infront of the Ammunation
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    SetCamRot(cam, 0.0, 0.0, 0.0)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~b~Gun Licenses\n~w~You can purchase a gun license from the Police Department-')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('and go to the gun store and get legal weapons.')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, -59.42, -13.32, 74.31, false, false, false, true) --- Teleport Player Drug Dealer
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -59.42, -13.32, 74.31) -- Set the Camera Infront of the Drug Dealer
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    SetCamRot(cam, 0.0, 0.0, 70.0)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~r~Drug Dealer\n~w~You can go to the drug dealer and purchase drug ingredients to make drugs')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('You can find the drug locations by asking people around the city in roleplay.')
    Citizen.Wait(8000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, -461.33, -335.68, 35.5, false, false, false, true) --- Teleport Player Hospital
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -461.33, -335.68, 35.5) -- Set the Camera Infront of the Hospital
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    SetCamRot(cam, 0.0, 0.0, -90.0)
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~r~Hospital\n~w~When you are hurt and you bleed out you will be brought here')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('You will forget everything that caused your demise')
    Citizen.Wait(8000)
    ESX.ShowHelpNotification('Hopefully this tutorial helped you!')
    SetEntityCoordsNoOffset(playerPed, -195.14, -830.31, 31.08, false, false, false, true) --- Teleport Player Back to start
    FreezeEntityPosition(playerPed, true) --- Freeze The Player There
    SetEntityVisible(playerPed, true, 0) --- set visable
    FreezeEntityPosition(playerPed, false) -- unfreeze
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    ---- End Delete Camera
        end

        menu.close()

    end, function(data, menu)
        menu.close()
    end)

end
-------------- DO NOT TRADE/SELL THIS SCRIPT IT IS 100% FREE ON FIVEM FORUMS ------------------------
-------------- DO NOT TRADE/SELL THIS SCRIPT IT IS 100% FREE ON FIVEM FORUMS ------------------------
-------------- DO NOT TRADE/SELL THIS SCRIPT IT IS 100% FREE ON FIVEM FORUMS ------------------------
-------------- DO NOT TRADE/SELL THIS SCRIPT IT IS 100% FREE ON FIVEM FORUMS ------------------------
-------------- DO NOT TRADE/SELL THIS SCRIPT IT IS 100% FREE ON FIVEM FORUMS ------------------------
