fx_version 'cerulean'
game 'gta5'

author 'Cadburry#7547'
description 'Drug Sales with PolyZone and Target'
version '2.0'

shared_scripts {
    'shared.lua',
}

server_scripts {    
    'sv_drugsell.lua',
}

client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',   
    'cl_drugsell.lua'
}

dependencies {
    'qb-core',
    'PolyZone',
    'qb-target'    
}

lua54 'yes'