ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)
    
end)


ESX.RegisterServerCallback('netr_garages:getOwnedVehicles', function (source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @owner',
    { ['@owner'] = xPlayer.identifier },
    function (result)
      local vehicles = {}

      for i=1, #result, 1 do
        local vehicleData = json.decode(result[i].vehicle)
        table.insert(vehicles, vehicleData)
      end

      cb(vehicles)
    end
  )
end)

ESX.RegisterServerCallback('netr_garages:checkIfVehicleIsOwned', function (source, cb, plate)

  local xPlayer = ESX.GetPlayerFromId(source)
  local found = nil
  local vehicleData = nil

  MySQL.Async.fetchAll(
    'SELECT * FROM owned_vehicles WHERE owner = @owner',
    { ['@owner'] = xPlayer.identifier },
    function (result)
      local vehicles = {}

      for i=1, #result, 1 do
        vehicleData = json.decode(result[i].vehicle)
        if vehicleData.plate == plate then
          found = true
          cb(vehicleData)
          break
        end
      end

      if not found then
        cb(nil)
      end
    end
  )
end)

RegisterServerEvent('netr_garages:updateOwnedVehicle')
AddEventHandler('netr_garages:updateOwnedVehicle', function(vehicleProps)
 
 	local _source = source
 	local xPlayer = ESX.GetPlayerFromId(source)
 
 	MySQL.Async.fetchAll(
 		'SELECT * FROM owned_vehicles WHERE owner = @owner',
 		{
 			['@owner'] = xPlayer.identifier
 		},
 		function(result)
 
 			local foundVehicleId = nil
 
 			for i=1, #result, 1 do
 				
 				local vehicle = json.decode(result[i].vehicle)
 				
 				if vehicle.plate == vehicleProps.plate then
 					foundVehicleId = result[i].id
 					break
 				end
 
 			end
 
 			if foundVehicleId ~= nil then

 				MySQL.Async.execute(
 					'UPDATE owned_vehicles SET vehicle = @vehicle WHERE id = @id',
 					{
						['@vehicle'] = json.encode(vehicleProps),
						['@id']      = foundVehicleId
 					}
 				)
 
 			end
 
 		end
 	)
 
 end)


RegisterServerEvent('netr_garages:addCarToParking')
AddEventHandler('netr_garages:addCarToParking', function(vehicleProps, source)
	addCarToPark(vehicleProps, source)
end)

RegisterServerEvent('netr_garages:addCarToParking2')
AddEventHandler('netr_garages:addCarToParking2', function(vehicleProps)
	addCarToPark(vehicleProps, source)
end)

RegisterServerEvent('netr_garages:removeCarFromParking')
AddEventHandler('netr_garages:removeCarFromParking', function(plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then

		MySQL.Async.execute(
			'DELETE FROM `user_parkings2` WHERE `identifier` = @identifier AND `plate` = @plate',
			{
				['@identifier'] = xPlayer.identifier,
				['@plate'] = plate
			}, function(rowsChanged)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_released'))
			end
		)

	end

end)

function addCarToPark(vehicleProps, source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if vehicleProps ~= nil then

		MySQL.Async.execute(
			'INSERT INTO `user_parkings2` (`identifier`, `plate`, `vehicle`) VALUES (@identifier, @plate, @vehicle)',
			{
				['@identifier']   = xPlayer.identifier,
				['@plate']        = vehicleProps.plate,
				['@vehicle']      = json.encode(vehicleProps)
			}, function(rowsChanged)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_stored'))
			end
		)

	end
end


RegisterServerEvent('netr_garages:getCustomPlate')
AddEventHandler('netr_garages:getCustomPlate', function(plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then

    MySQL.Async.fetchAll(
      'SELECT `plate_name` FROM custom_plate WHERE original_plate = @plate',
      {
        ['@plate'] = plate
      },
      function(result)
        return result[1].plate_name
    end)

	end

end)


ESX.RegisterServerCallback('netr_garages:getVehiclesInGarage', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM `user_parkings2` WHERE `identifier` = @identifier',
		{
			['@identifier'] = xPlayer.identifier -- steam 64 hex
		},
		function(result)

			local vehicles = {}

			for i=1, #result, 1 do
        local vehicleData = json.decode(result[i].vehicle)
        table.insert(vehicles, vehicleData)
			end

			cb(vehicles)

		end
	)

end)

RegisterServerEvent('netr_garages:updateInventory')
AddEventHandler('netr_garages:updateInventory', function()
	parkAllOwnedVehicles()
end)

--[[ runs everytime the server is restarted]]
--[[ 

  adds all user owned cars into the parking garage table so people can pull their cars out

]]
function parkAllOwnedVehicles()

  MySQL.ready(function ()

    MySQL.Sync.execute(
      'DELETE FROM `user_parkings2`',
      {
      }, function(rowsChanged)
      end
    )

    print('netr_garages: updated garage hive!')

    local result = MySQL.Sync.fetchAll(
      'SELECT * FROM owned_vehicles',
      {})

    local foundVehicleId = nil

    for i=1, #result, 1 do
    
      local vehicle = result[i].vehicle
      local identifier = result[i].owner

      MySQL.Sync.execute(
        'INSERT INTO `user_parkings2` (`identifier`, `plate`, `vehicle`) VALUES (@identifier, @plate, @vehicle)',
        {
          ['@identifier'] = identifier,
          ['@plate'] = json.decode(vehicle).plate,
          ['@vehicle']     = vehicle
        })

    end
    
  end)


end

parkAllOwnedVehicles()

TriggerEvent('es:addGroupCommand', 'garload', 'admin', function (source, args, user)
  parkAllOwnedVehicles()
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Reloaded garage!")
end, function (source, args, user)
  TriggerClientEvent('chatMessage', source, 'SYSTEM', { 255, 0, 0 }, 'Insufficienct permissions!')
end, { help = 'Reload the garage database' })