fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sd_blackmarket'
author 'you'
description 'Standalone black-market dealer, reachable through sd-phones real Messages app - built as an addon, no sd-phone core files touched.'
version '1.0.0'

-- ox_lib gives us lib.callback for the client<->server collect flow. sd-phone and
-- 9labs_scootrental already depend on it, so it's assumed present.
shared_script '@ox_lib/init.lua'

shared_scripts {
    'config.lua',
    'shared/locale.lua',
    'locales/*.lua',
}

server_scripts {
    'server/bridge.lua',
    'server/main.lua',
}

client_scripts {
    'client/main.lua',
}

-- The sticky-note reveal popup: a tiny, non-interactive NUI overlay (no mouse focus taken),
-- not a full "phone app" - it just shows briefly over gameplay like a native notification would.
ui_page 'ui/index.html'
files { 'ui/**/*' }

dependencies {
    'ox_lib',
    'ox_target',
    'sd-phone',
}
