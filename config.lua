Config = {}

-- do you want to enable debugging?
Config.Debug = false

-- what framework do you use?
Config.Framework = 'qb' -- 'qb', 'esx'

-- what inventory do you use?
Config.Inventory = 'qb' -- 'qb', 'ps', 'ox'

-- what target do you use?
Config.Target = 'qb' -- 'qb', 'ox' (false: DrawText3D)

-- what radial menu do you use?
Config.Radial = 'qb' -- 'qb', 'ox'

-- what dispatch to use for police alerts?
Config.Dispatch = 'qb' -- 'qb', 'ps', 'moz', 'cd', 'custom'

-- what menu you want to use?
Config.OxMenu = true -- true: Ox Menu, false: Ox Context Menu

-- Minimum cops required to sell drugs
Config.MinimumCops = 0

-- Give bonus on selling drugs when no of cops are online
Config.GiveBonusOnPolice = false

-- Allow selling to peds sitting in vehicle
Config.SellPedOnVehicle = false

-- Chance to sell drug
Config.ChanceSell = 70 -- (in %) 

-- Random sell amount
Config.RandomSell = { min = 1, max = 6 } -- range: min, max

-- Selling timeout so that the menu doesnt stay forever
Config.SellTimeout = 10 -- (secs) Max time you get to choose your option

-- The below option decides whether the person has to toggle selling in a zone (radialmenu/command) (Recommended: false)
Config.ShouldToggleSelling = false

-- Ped models that you dont want to be sold to
Config.BlacklistPeds = {
    "mp_m_shopkeep_01",
    "s_m_y_ammucity_01",
    "s_m_m_lathandy_01",
    "s_f_y_clubbar_01",
    "ig_talcc",
    "g_f_y_vagos_01",
    "hc_hacker",
    "s_m_m_migrant_01",
}

-- The below option is for you to enable selling anywhere
Config.SellAnywhere = false

-- SellItems to be configured only if [Config.SellAnywhere = true]
Config.SellItems = {
    { item = 'cokebaggy',    price = math.random(100, 200) },
    { item = 'weed_amnesia', price = math.random(100, 200) },
    { item = 'meth',         price = math.random(100, 200) },
}

-- SellZones will only if [Config.SellAnywhere = false]
Config.SellZones = { -- Sell zones and their drugs
    ['groove'] = {
        points = {
            vec3(251.0, -1860.0, 27.0),
            vec3(139.0, -1997.0, 27.0),
            vec3(132.0, -2025.0, 27.0),
            vec3(91.0, -2023.0, 27.0),
            vec3(-151.0, -1788.0, 27.0),
            vec3(-110.0, -1751.0, 27.0),
            vec3(42.0, -1688.0, 27.0),
            vec3(60.0, -1699.0, 27.0),
        },
        thickness = 60.0,
        items = {
            { item = 'cokebaggy',    price = math.random(100, 200) },
            { item = 'weed_amnesia', price = math.random(100, 200) },
            { item = 'meth',         price = math.random(100, 200) },
        }
    },
    ['vinewood'] = {
        points = {
            vec3(-663.80639648438, 114.2766418457, 97.0),
            vec3(-660.09497070312, 299.65426635742, 97.0),
            vec3(-546.58837890625, 275.86111450196, 97.0),
            vec3(-542.21002197266, 357.8136291504, 97.0),
            vec3(-519.6430053711, 349.90490722656, 97.0),
            vec3(-512.67572021484, 276.3483581543, 97.0),
            vec3(21.216751098632, 278.6813659668, 97.0),
            vec3(49.785594940186, 339.29946899414, 97.0),
            vec3(108.84923553466, 399.87518310546, 97.0),
            vec3(124.068069458, 384.4684753418, 97.0),
            vec3(92.195236206054, 354.55239868164, 97.0),
            vec3(170.3550567627, 377.32186889648, 97.0),
            vec3(841.11456298828, 199.74020385742, 97.0),
            vec3(530.7640991211, -193.10136413574, 97.0)
        },
        thickness = 80.0,
        items = {
            { item = 'cokebaggy',    price = math.random(100, 200) },
            { item = 'weed_amnesia', price = math.random(100, 200) },
            { item = 'meth',         price = math.random(100, 200) },
        }
    },
    ['forumdr'] = {
        points = {
            vec3(-181.78276062012, -1767.562133789, 32.0),
            vec3(-232.15049743652, -1728.5841064454, 32.0),
            vec3(-257.00219726562, -1706.3781738282, 32.0),
            vec3(-316.23831176758, -1670.7681884766, 32.0),
            vec3(-317.6089477539, -1671.6815185546, 32.0),
            vec3(-339.08483886718, -1659.1655273438, 32.0),
            vec3(-345.54052734375, -1655.4389648438, 32.0),
            vec3(-370.05755615234, -1640.6751708984, 32.0),
            vec3(-357.4814453125, -1617.630859375, 32.0),
            vec3(-344.98095703125, -1605.980834961, 32.0),
            vec3(-308.92208862304, -1544.8927001954, 32.0),
            vec3(-304.6683959961, -1535.6296386718, 32.0),
            vec3(-307.36282348632, -1531.2420654296, 32.0),
            vec3(-303.91906738282, -1514.8071289062, 32.0),
            vec3(-302.4489440918, -1508.5216064454, 32.0),
            vec3(-299.51068115234, -1489.9995117188, 32.0),
            vec3(-297.42388916016, -1452.6616210938, 32.0),
            vec3(-297.9144897461, -1445.0788574218, 32.0),
            vec3(-300.47821044922, -1410.740600586, 32.0),
            vec3(-243.52647399902, -1409.9093017578, 32.0),
            vec3(-228.14682006836, -1408.454711914, 32.0),
            vec3(-214.2696685791, -1404.2430419922, 32.0),
            vec3(-202.69938659668, -1398.415649414, 32.0),
            vec3(-176.32830810546, -1382.9993896484, 32.0),
            vec3(-140.07070922852, -1360.1298828125, 32.0),
            vec3(-131.92518615722, -1353.8952636718, 32.0),
            vec3(-126.67826080322, -1347.0697021484, 32.0),
            vec3(-122.79215240478, -1338.1767578125, 32.0),
            vec3(-122.24575042724, -1335.2940673828, 32.0),
            vec3(-88.574974060058, -1337.8919677734, 32.0),
            vec3(-83.885818481446, -1337.3891601562, 32.0),
            vec3(-72.32137298584, -1347.8657226562, 32.0),
            vec3(-55.457233428956, -1349.6873779296, 32.0),
            vec3(-46.141300201416, -1350.8635253906, 32.0),
            vec3(0.30536636710166, -1350.3518066406, 32.0),
            vec3(19.377029418946, -1349.9018554688, 32.0),
            vec3(46.155563354492, -1350.2407226562, 32.0),
            vec3(56.231525421142, -1346.1237792968, 32.0),
            vec3(61.976043701172, -1336.847290039, 32.0),
            vec3(61.876712799072, -1331.4219970704, 32.0),
            vec3(94.016792297364, -1317.3137207032, 32.0),
            vec3(98.473731994628, -1315.1446533204, 32.0),
            vec3(100.91152191162, -1318.8972167968, 32.0),
            vec3(116.59771728516, -1309.0223388672, 32.0),
            vec3(115.354637146, -1306.6965332032, 32.0),
            vec3(142.13439941406, -1291.261352539, 32.0),
            vec3(143.9640197754, -1293.9191894532, 32.0),
            vec3(159.81324768066, -1280.7825927734, 32.0),
            vec3(166.5573272705, -1270.3135986328, 32.0),
            vec3(203.52110290528, -1282.7435302734, 32.0),
            vec3(231.76536560058, -1329.863647461, 32.0),
            vec3(215.84732055664, -1346.2076416016, 32.0),
            vec3(190.12483215332, -1387.3775634766, 32.0),
            vec3(162.40365600586, -1423.5834960938, 32.0),
            vec3(154.98637390136, -1424.7723388672, 32.0),
            vec3(126.23979187012, -1458.2556152344, 32.0),
            vec3(108.94204711914, -1478.851196289, 32.0),
            vec3(113.4779586792, -1482.6186523438, 32.0),
            vec3(111.75213623046, -1484.7049560546, 32.0),
            vec3(109.91118621826, -1483.4962158204, 32.0),
            vec3(92.817611694336, -1503.7390136718, 32.0),
            vec3(69.58283996582, -1526.8861083984, 32.0),
            vec3(39.489440917968, -1562.9592285156, 32.0),
            vec3(16.217784881592, -1590.7109375, 32.0),
            vec3(0.90857058763504, -1609.6218261718, 32.0),
            vec3(-22.47274017334, -1636.7037353516, 32.0),
            vec3(-65.98893737793, -1687.4913330078, 32.0)

        },
        thickness = 60.0,
        items = {
            { item = 'cokebaggy',    price = math.random(100, 200) },
            { item = 'weed_amnesia', price = math.random(100, 200) },
            { item = 'meth',         price = math.random(100, 200) },
        }
    }
}