
Config = {}
Config.Debug = true -- \ Set to true to enable debugging
Config.Core = "qb-core" -- \ The name of the core (Default: qb-core)
Config.Target = "qb-target" -- \ The target name (Default: qb-target)
Config.ChanceSell = 70 -- \ Chance to sell drug (in %)
Config.Zones = { -- \ Sell zones (these zones are linked with the certain drugs check below)
    ['groove'] = {        
		points = {
            vector2(250.90760803223, -1866.3974609375),
            vector2(146.70475769043, -1990.5447998047),
            vector2(130.3134765625, -2034.3944091797),
            vector2(95.291275024414, -2030.4129638672),
            vector2(88.095336914062, -2009.6634521484),
            vector2(68.878730773926, -1978.8924560547),
            vector2(-153.59761047363, -1779.4030761719),
            vector2(-97.692588806152, -1750.6363525391),
            vector2(-50.927833557129, -1733.6020507812),
            vector2(49.590217590332, -1689.9705810547)
        },
        minZ = 18.035144805908,
        maxZ = 75.059997558594,                      
    },
}

Config.ZoneDrugs = { -- \ Names should be same as zone names
    [1] = {zone="sellzonegroove", item = 'cokebaggy', price = math.random(100, 200)},
    [2] = {zone="sellzonegroove", item = 'meth', price = math.random(100, 200)},    
}

Config.BlacklistPeds = { -- \ Ped models that should be blacklisted
    "mp_m_shopkeep_01",
    "s_m_y_ammucity_01"
}