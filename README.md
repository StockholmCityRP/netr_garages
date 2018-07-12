# netr_garages
Fork of the orginial script with endless improvements

## Requirements
- esx_vehicleshop script or some way to add players' cars to `owned_vehicles`

## Information
1. Customizable configurations for garage locations (Config.Garages in config.lua)
2. Drive into the marker to store it (auto saves any upgrades when you store it)
3. Walk into the marker to pull out your stored cars

## Adding vehicle to garage
- Use the server side trigger `TriggerServerEvent('netr_garages:addCarToParking', vehicleProps, target)`
