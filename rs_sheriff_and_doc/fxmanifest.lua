fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author 'Hobbs'


server_scripts {
    'configs/*.lua',
    '**/server/*.lua'
}

client_scripts {
    'configs/*.lua',
    '**/client/*.lua'
}

dependency 'vorpcore'
