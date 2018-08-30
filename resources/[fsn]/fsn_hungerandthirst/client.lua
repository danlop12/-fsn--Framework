local clienttime = 0
local hunger = 100
local thirst = 100
local UI = {
	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y
}
local init = false

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

AddEventHandler('fsn_inventory:initChar', function()
  init = true
	hunger = 100
	thirst = 100
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if init then
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
	      drawRct(UI.x + 0.0149, UI.y + 0.797, 0.1569,0.0140,0,0,0,130) -- bar at top
	      drawRct(UI.x + 0.0149, UI.y + 0.800, 0.07718,0.0080,255,255,255,60) -- sub-bar (hunger)
	      drawRct(UI.x + 0.0941, UI.y + 0.800, 0.07718,0.0080,255,255,255,60) -- sub-bar (thirst)


	      local hunger_bar = 0.07718 / 100
	      hunger_bar = hunger_bar * hunger

	      local thirst_bar = 0.07718 / 100
	      thirst_bar = thirst_bar * thirst
	      drawRct(UI.x + 0.0149, UI.y + 0.800, hunger_bar,0.0080,17, 160, 41,130) -- main-bar (hunger)
	      drawRct(UI.x + 0.0942, UI.y + 0.800, thirst_bar,0.0080,0, 250, 255,130) -- main-bar (thirst)
			else --0.97695
				drawRct(UI.x + 0.0149, UI.y + 0.96295, 0.1569,0.0140,0,0,0,130) -- bar at top
	      drawRct(UI.x + 0.0149, UI.y + 0.9663, 0.07718,0.0080,255,255,255,60) -- sub-bar (hunger)
	      drawRct(UI.x + 0.0941, UI.y + 0.9663, 0.07718,0.0080,255,255,255,60) -- sub-bar (thirst)


	      local hunger_bar = 0.07718 / 100
	      hunger_bar = hunger_bar * hunger

	      local thirst_bar = 0.07718 / 100
	      thirst_bar = thirst_bar * thirst
	      drawRct(UI.x + 0.0149, UI.y + 0.9663, hunger_bar,0.0080,17, 160, 41,130) -- main-bar (hunger)
	      drawRct(UI.x + 0.0942, UI.y + 0.9663, thirst_bar,0.0080,0, 250, 255,130) -- main-bar (thirst)
			end

      --drawRct(UI.x + 0.0149, UI.y + 0.800, 0.07715,0.0080,17, 160, 41,130) -- main-bar (hunger)
      --drawRct(UI.x + 0.0942, UI.y + 0.800, 0.07715,0.0080,0, 250, 255,130) -- main-bar (hunger)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    clienttime = clienttime + 1
    if clienttime / 120000 == math.floor(clienttime) / 120000 and init then
      if hunger - 0.03 <= 0 then
        TriggerEvent('fsn_ems:killMe')
      else
        hunger = hunger - 0.04
      end
      if thirst - 0.04 <= 0 then
        TriggerEvent('fsn_ems:killMe')
      else
        thirst = thirst - 0.05
      end
    end
  end
end)

RegisterNetEvent('fsn_inventory:use:food')
AddEventHandler('fsn_inventory:use:food', function(relief)
  if hunger + relief >= 100 then
    hunger = 100
  else
    hunger = hunger + hunger
  end
end)

RegisterNetEvent('fsn_inventory:use:drink')
AddEventHandler('fsn_inventory:use:drink', function(relief)
  if thirst + relief >= 100 then
    thirst = 100
  else
    thirst = thirst + relief
  end
end)
