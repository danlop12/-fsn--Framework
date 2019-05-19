
-------------------
-- Instance stuff
-- _seriously idk why this is here_
-------------------
local instanced = false
local myinstance = {}
function instanceMe(state)
	instanced = state
	TriggerEvent('tokovoip_extras:muteall', state)
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for id = 0, 31 do
			if instanced then
				local ped = GetPlayerPed(id)
				if ped ~= GetPlayerPed(-1) then
					SetEntityVisible(ped, false, 0)
					SetEntityCollision(ped, false, false)
				end
			else
				local ped = GetPlayerPed(id)
				if ped ~= GetPlayerPed(-1) then
					SetEntityVisible(ped, true, 0)
					SetEntityCollision(ped, true, true)
				end
			end
		end
	end
end)

------------------------------------------------------------------------------------ actual system
local init = true
function fsn_drawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(0.3, 0.3)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 140)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
local myRoomNumber = 32
local building = false
local inappt = false
local apptdetails = {}

RegisterNetEvent('fsn_apartments:sendApartment')
AddEventHandler('fsn_apartments:sendApartment', function(tbl)
	EnterRoom(tbl.number)
	myRoomNumber = tbl.number
	init = true
	TriggerEvent('fsn_notify:displayNotification', 'Your apartments is number: '..tbl.number, 'centerRight', 6000, 'info')
end)

apartments = {
	[1] = { ["x"] = 312.96966552734,["y"] = -218.2705078125, ["z"] = 54.221797943115},
	[2] = { ["x"] = 311.27377319336,["y"] = -217.74626159668, ["z"] = 54.221797943115},
	[3] = { ["x"] = 307.63830566406,["y"] = -216.43359375, ["z"] = 54.221797943115}, 
	[4] = { ["x"] = 307.71112060547,["y"] = -213.40884399414, ["z"] = 54.221797943115}, 
	[5] = { ["x"] = 309.95989990234,["y"] = -208.48258972168, ["z"] = 54.221797943115},
	[6] = { ["x"] = 311.78106689453,["y"] = -203.50025939941, ["z"] = 54.221797943115}, 
	[7] = { ["x"] = 313.72155761719,["y"] = -198.6107635498, ["z"] = 54.221797943115},
	[8] = { ["x"] = 315.5329284668,["y"] = -195.24925231934, ["z"] = 54.226440429688},
	[9] = { ["x"] = 319.23147583008,["y"] = -196.4300994873, ["z"] = 54.226451873779},
	[10] = { ["x"] = 321.08117675781,["y"] = -197.23593139648, ["z"] = 54.226451873779},
	[11] = { ["x"] = 312.98037719727,["y"] = -218.36080932617, ["z"] = 58.019248962402},
	[12] = { ["x"] = 311.10736083984,["y"] = -217.64399719238, ["z"] = 58.019248962402},
	[13] = { ["x"] = 307.37707519531,["y"] = -216.34501647949, ["z"] = 58.019248962402},
	[14] = { ["x"] = 307.76007080078,["y"] = -213.59916687012, ["z"] = 58.019248962402},
	[15] = { ["x"] = 309.76248168945,["y"] = -208.25439453125, ["z"] = 58.019248962402},
	[16] = { ["x"] = 311.48220825195,["y"] = -203.75033569336, ["z"] = 58.019248962402},
	[17] = { ["x"] = 313.65570068359,["y"] = -198.22790527344, ["z"] = 58.019248962402},
	[18] = { ["x"] = 315.47378540039,["y"] = -195.19331359863, ["z"] = 58.019248962402},
	[19] = { ["x"] = 319.39694213867,["y"] = -196.58866882324, ["z"] = 58.019248962402},
	[20] = { ["x"] = 321.19458007813,["y"] = -197.31185913086, ["z"] = 58.019248962402},
	[21] = { ["x"] = 329.49240112305,["y"] = -224.92803955078, ["z"] = 54.221771240234},
	[22] = { ["x"] = 331.33309936523,["y"] = -225.56880187988, ["z"] = 54.221771240234},
	[23] = { ["x"] = 335.18447875977,["y"] = -227.14477539063, ["z"] = 54.221771240234},
	[24] = { ["x"] = 336.71957397461,["y"] = -224.66767883301, ["z"] = 54.221771240234},
	[25] = { ["x"] = 338.79501342773,["y"] = -219.11264038086, ["z"] = 54.221771240234},
	[26] = { ["x"] = 340.43829345703,["y"] = -214.78857421875, ["z"] = 54.221771240234},
	[27] = { ["x"] = 342.28509521484,["y"] = -209.32579040527, ["z"] = 54.221771240234},
	[28] = { ["x"] = 344.39224243164,["y"] = -204.4561920166, ["z"] = 54.221881866455},
	[29] =  { ['x'] = 346.75,['y'] = -197.52,['z'] = 54.23 },
	[30] = { ["x"] = 329.7096862793,["y"] = -224.65902709961, ["z"] = 58.019248962402}, 
	[31] = { ["x"] = 331.52966308594,["y"] = -225.52110290527, ["z"] = 58.019248962402}, 
	[32] = { ["x"] = 335.16506958008,["y"] = -227.07464599609, ["z"] = 58.019248962402},
	[33] = { ["x"] = 336.35406494141,["y"] = -224.58212280273, ["z"] = 58.019245147705}, 
	[34] = { ["x"] = 338.56127929688,["y"] = -219.3408203125, ["z"] = 58.019245147705},
	[35] = { ["x"] = 340.5012512207,["y"] = -214.33885192871, ["z"] = 58.019245147705},
	[36] = { ["x"] = 342.41970825195,["y"] = -209.25254821777, ["z"] = 58.019245147705},
	[37] = { ["x"] = 344.03280639648,["y"] = -204.98118591309, ["z"] = 58.019245147705},
	[38] = { ["x"] = 346.08560180664,["y"] = -199.59660339355, ["z"] = 58.019245147705}, 
}

local storage = {x = 151.31591796875, y = -1003.1566772461, z = -99.000007629395}
local cash = {x = 154.14666748047, y = -1006.1190185547, z = -99.0}
local outfits = {x = 151.8991394043, y = -1001.5586547852, z = -99.0}
local leave = {x = 151.31465148926, y = -1007.9354858398, z = -98.999969482422}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if init then
			if inappt then
				-- storage
				DrawMarker(25, storage.x, storage.y, storage.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(storage.x, storage.y, storage.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(storage.x, storage.y, storage.z, "[E] access storage\n~r~Not available yet")
					if IsControlJustPressed(0,38) then
						print 'accessing storage'
					end
				end
				
				-- money
				DrawMarker(25, cash.x, cash.y, cash.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(cash.x, cash.y, cash.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(cash.x, cash.y, cash.z, "$0 / $150,000\n\n/stash add {amt}\n/stash take {amt}")
				end
				
				-- outfits
				DrawMarker(25, outfits.x, outfits.y, outfits.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(outfits.x, outfits.y, outfits.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(outfits.x, outfits.y, outfits.z, "/outfit add {name}\n/outfit use {name}\n/outfit remove {name}")
				end
				
				-- leaving
				DrawMarker(25, leave.x, leave.y, leave.z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(leave.x, leave.y, leave.z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
					fsn_drawText3D(leave.x, leave.y, leave.z, "[E] leave apartment")
					if IsControlJustPressed(0,38) then
						SetEntityCoords(GetPlayerPed(-1), apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z)
						FreezeEntityPosition(GetPlayerPed(-1), true)
						DoScreenFadeOut(0)
						Citizen.Wait(3000)
						inappt = false
						DoScreenFadeIn(3000)
						FreezeEntityPosition(GetPlayerPed(-1), false)
						instanceMe(false)
					end
				end
			else
				if GetDistanceBetweenCoords(apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z, GetEntityCoords(GetPlayerPed(-1))) < 20 then
					DrawMarker(25, apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z - 0.95, 0, 0, 0, 0, 0, 0, 0.50, 0.50, 10.3, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
					DrawMarker(0, apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 140, 0, 0, 1, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z, GetEntityCoords(GetPlayerPed(-1)), true) < 0.5 then
						fsn_drawText3D(apartments[myRoomNumber].x, apartments[myRoomNumber].y, apartments[myRoomNumber].z+1, "[E] enter apartment")
						if IsControlJustPressed(0,38) then
							EnterRoom(myRoomNumber)
						end
					end
				end
			end
		end
	end
end)
function EnterRoom(id)
	DoScreenFadeOut(0)
	SetEntityCoords(GetPlayerPed(-1), 152.09986877441 , -1004.7946166992, -98.999984741211)
	DoScreenFadeIn(3000)
	instanceMe(true)
	inappt = true
	FreezeEntityPosition(GetPlayerPed(-1), false)
end

----------------------------------------------- character creation
-- if user does not have a 4
local creating = false
RegisterNetEvent('fsn_apartments:characterCreation')
AddEventHandler('fsn_apartments:characterCreation', function()
	local xyz = {x = 223.19703674316, y = -967.322265625, z = -99.002616882324, h = 230.43223571777}
	local campos = {x = 225.67114257813, y = -969.71331787109, z = -98.999954223633, h = 39.208980560303}
	SetEntityCoords(GetPlayerPed(-1), xyz.x, xyz.y, xyz.z)
	SetEntityHeading(GetPlayerPed(-1), xyz.h)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	TriggerEvent('fsn_clothing:menu')
	creating = true
	instanceMe(true)
	
	
	Citizen.CreateThread(function()
		while creating do
			Citizen.Wait(20)
			if not exports["fsn_clothing"]:isClothingOpen() then
				creating = false
				DoScreenFadeOut(1000)
				TriggerServerEvent('fsn_apartments:createApartment', exports["fsn_main"]:fsn_CharID())
			end
			if GetDistanceBetweenCoords(xyz.x, xyz.y, xyz.z, GetEntityCoords(GetPlayerPed(-1)), true) < 5 then
				SetEntityCoords(GetPlayerPed(-1), xyz.x, xyz.y, xyz.z)
				FreezeEntityPosition(GetPlayerPed(-1), true)
				SetEntityHeading(GetPlayerPed(-1), xyz.h)
			end
		end
	end)
end)
