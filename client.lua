local framework = nil
local engineToggleResourceName = 'msk_enginetoggle'
local Config = []

-- ESX implemention 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(100)
        if not Config.Framework then 
            Config = LoadConfig()
        end
    end
end)

function LoadConfig()
    local configFile = LoadResourceFile(getCurrentResourceName(), 'config.lua')
    if configFile then 
        local config = assert(load(configFile))()
        return config
    else
        print('Error: Could not load config file, please check for any errors in the config.lua file')
        return {}
    end
end

if Config.Framework == 'esx' then 
    local vehicleEngineStatus = ESX.Game.GetVehicleProperties(vehicle).engine 
    if not vehicleEngineStatus then 
        RepairVehicle(vehicle)
    else
        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Please turn off the engine before repairing the vehicle.')
    end
elseif Config.Framework == 'qb-core' then 
    QBCore.Functions.TriggerCallback('msk_enginetoggle:IsVehicleEngineOff', function(isEngineOff)
        if isEngineOff then 
            RepairVehicle(vehicle)
        else
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Please turn off the engine before repairing the vehicle.')
        end
    end, vehicle)
elseif Config.Framework == 'standalone' then 
    RepairVehicle(vehicle)
else
    print('Error: Invalid framework specified in the config.lua')
end
else 
    TriggerCallback('chatMessage', 'SYSTEM', {255, 0, 0}, 'You are not in a vehicle')
end
end, false)

RegisterCommand('repair', function(source, args, rawCommand)
    local player = PlayerId()
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local vehicle = GetVehiclePedIsIn(player, false)

        -- Check if the vehicle engine is off using your selected framework.

        if frameworkUsed == 'esx' then 

            -- ESX implementation

            local vehicleEngineStatus = ESX.GetVehicleProperties(vehicle).engine
            if not vehicleEngineStatus then 
                RepairVehicle(vehicle)
            else 
                TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0} 'Please turn vehicle engine off before repairing')
            end
        elseif frameworkUsed == 'qb-core' then 

            -- QB-Core implementation

            QBCore.Functions.TriggerCallback('msk_enginetoggle:IsVehicleEngineOff', function(isEngineOff)
            if isEngineOff then 
            RepairVehicle(vehicle)
            else
            TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Please turn vehicle engine off before repairing')
            end
        end, vehicle
    end
else
    TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'You are not in a vehicle')
end
end, false) 

        -- New code to repair the vehicle

        if exports[engineToggleResourceName]:IsVehicleEngineOff(vehicle) then

        SetVehicleFixeed(vehicle)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehicleFuelLevel(vehicle, 100.0)
        SetVehicleBodyHealth(vehicle, 100.0)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndrivable(vehicle, false)

        -- Code to fix all tyres 

        for i = 0, 7 do 
            SetVehicleTyreFixed(vehicle, i)
        end

        -- Refuel the vehicle 

        SetVehicleFuelLevel(vehicle, 100.0)

        -- Wash dirt (get rid basically)

        SetVehicleDirtLevel(vehicle, 0.0)

        -- Vehicle engine code

        SetVehicleEngineOn(vehicle, true, true, true)

        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Please turn your engine off before repairing your vehicle')

        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Your vehicle has been repaired.')
    else

        TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'You are not in a vehicle.')
    end
end, false)


