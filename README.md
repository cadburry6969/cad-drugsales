# Overview
This resources allows you to sell drugs to npcs in a zone or anywhere.

# Old Preview

[![Click Here](https://user-images.githubusercontent.com/72443203/169163591-d4956c2d-436d-4a42-8c75-71398fc2c273.png)](https://www.youtube.com/watch?v=0EmvAfaEDzE)

# Features

- Configurable Sell Zones / Drugs / price / Sell Anywhere
- NPC Drug sales with target
- Add as many drugs/zones you want
- Each zone has its own drug and price
- You can add multiple drugs to a zone
- You can sell multiple drugs at once (upon random range)
- You can sell anywhere if you dont want the zones

# Dependencies

- ox_lib

# Exports

```lua
-- toggle target on ped (this will toggle allowing/disallowing target even if inside zone)
exports["cad-drugsales"]:ToggleTarget(bool)

-- manually create's target
exports["cad-drugsales"]:CreateTarget()

-- manually remove's target
exports["cad-drugsales"]:RemoveTarget()
```

# How to Use

- Download latest release and add to resources
- ensure in `server.cfg`
- Change `config.lua` according to your needs
- Finish!

# Support
- If you have any questions or need assistance, feel free to open an issue in this repository.
- Join Discord: https://discord.gg/qxGPARNwNP
