RegisterCommand('repair', function(source, args, rawCommand)
    local player = PlayerId()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleBodyHealth(vehicle, 1000.0)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleTyreFixed(vehicle, 0)
        SetVehicleTyreFixed(vehicle, 1)
        SetVehicleTyreFixed(vehicle, 2)
        SetVehicleTyreFixed(vehicle, 3)
        SetVehicleTyreFixed(vehicle, 4)
        SetVehicleTyreFixed(vehicle, 5)
        SetVehicleTyreFixed(vehicle, 45)
        SetVehicleTyreFixed(vehicle, 47)
        SetVehicleTyreFixed(vehicle, 48)
        SetVehicleTyreFixed(vehicle, 49)

        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Your vehicle has been repaired.')
    else

        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'You are not in a vehicle.')
    end
end, false)
