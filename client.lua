-- Definir eventos del servidor
RegisterServerEvent('reparacionvehiculo:repararVehiculo')

-- Manejar el evento de reparación de vehículo
AddEventHandler('reparacionvehiculo:repararVehiculo', function()
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    
    -- Verificar si el jugador está cerca de un vehículo
    local vehiculo = nil
    if IsPedInAnyVehicle(source, false) then
        vehiculo = GetVehiclePedIsIn(source, false)
    end
    
    -- Verificar si el vehículo es válido
    if vehiculo ~= nil and DoesEntityExist(vehiculo) then
        -- Llamar a la función de reparación de vehículo
        RepararVehiculo(source, xPlayer, vehiculo)
    else
        -- Mostrar un mensaje si el jugador no está en un vehículo
        TriggerClientEvent('chat:addMessage', source, { args = { "^*^1Debes estar dentro de un vehículo para repararlo." } })
    end
end)

-- Función de reparación de vehículo
function RepararVehiculo(source, xPlayer, vehiculo)
    -- Verificar si el jugador tiene el kit de reparación en su inventario
    if xPlayer ~= nil and xPlayer.Functions.GetItemByName("repairkit") then
        -- Restar una unidad del kit de reparación
        xPlayer.Functions.RemoveItem("repairkit", 1)

        -- Reparar el vehículo
        SetVehicleFixed(vehiculo)
        SetVehicleDeformationFixed(vehiculo)
        SetVehicleUndriveable(vehiculo, false)
        SetVehicleEngineOn(vehiculo, true, true)

        -- Mostrar un mensaje al jugador
        TriggerClientEvent('chat:addMessage', source, { args = { "^*^1Reparación completada." } })
    else
        -- Mostrar un mensaje al jugador si no tiene el kit de reparación
        TriggerClientEvent('chat:addMessage', source, { args = { "^*^1Necesitas un kit de reparación para reparar vehículos." } })
    end
end
