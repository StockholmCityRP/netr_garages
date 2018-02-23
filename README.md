# FiveM Garages Script
Modified version by the SCRP team

## Requirements
- MySQL (run `garages.sql`)
- https://essentialmode.com/ (5.0.0 is what I built it over)
- https://github.com/ESX-Org/es_extended
- Car dealership scripts or some way to add player's cars to `owned_vehicles`

## Information
1. Customizable configurations for garage locations (Config.Garages in config.lua)
2. Drive into the marker to store it (auto saves any upgrades when you store it.. this lets you use ls_customs scripts)
3. Walk into the marker to pull out your stored cars

## Adding vehicle to garage
- Use the server side trigger `netr_garages:addCarToParking': vehicleProps, target`

---

thanks to @indilo53 for creating the base of this script + esx (https://github.com/indilo53)
