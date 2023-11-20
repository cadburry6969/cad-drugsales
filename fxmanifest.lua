fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Cadburry (ByteCode Studios)'
description 'Drug sales utilizing zones and target'
version '2.7'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'framework/client.lua',
    'scripts/client.lua',
}

server_scripts {
    'framework/server.lua',
    'scripts/server.lua',
}

dependencies {
    'ox_lib'
}