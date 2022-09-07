fx_version 'cerulean'
game 'gta5'

author 'BadCodes'
description 'An in-game fake browser with tabbed content.'
version '1.0.0'

client_scripts {
	"client.lua",
}
ui_page_preload "yes"
ui_page {
	'html/index.html'
}

files {
	'html/index.html',
	'html/css/*.css',
	'html/js/*.js',
}
