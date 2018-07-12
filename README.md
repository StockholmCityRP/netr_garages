# netr_garages
Fork of the orginial script with endless improvements

## Requirements
- ESX
- altered `owned_vehicles` db, add `plate` and set it as the primary key

## Information
1. Customizable configurations for garage locations (Config.Garages in config.lua)
2. Drive into the marker to store it (auto saves any upgrades when you store it)
3. Walk into the marker to pull out your stored cars

## Adding vehicle to garage
- Use the server side trigger `TriggerServerEvent('netr_garages:addCarToParking2', vehicleProps)` (source)
- Use the server side trigger `TriggerServerEvent('netr_garages:addCarToParking', vehicleProps, target)`
