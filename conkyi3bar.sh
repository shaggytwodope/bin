## Conky config i3; dkeg; 2013 ## 

out_to_x no
own_window no
out_to_console yes
background no
max_text_width 0
update_interval 3.0
total_run_times 0
short_units yes
if_up_strictness address
#use_spacer left
override_utf8_locale no
# set to 1 to disable averaging
cpu_avg_samples 4
border_inner_margin 0
border_outer_margin 0

#old color
#28c3c5

TEXT
[
{"full_text":"mail","color":"\#888888","separator":false,"separator_block_width":3},\
{"full_text":"»","color":"\#FFFFFF","separator":false,"separator_block_width":10},\
{"full_text":"${execpi 60 python ~/bin/gmail.py}","color":${if_match ${execpi 60 python ~/bin/gmail.py}>1}"\#cc5555"${else}"\#eeeeee"${endif},"separator":false,"separator_block_width":10 },\
\
{"full_text":"hd","color":"\#888888","separator":false,"separator_block_width":3},\
{"full_text":"»","color":"\#FFFFFF","separator":false,"separator_block_width":10},\
{"full_text":"${fs_free /home}","color":"\#eeeeee","separator":false,"separator_block_width":10},\
\
{"full_text":"ram","color":"\#888888","separator":false,"separator_block_width":3},\
{"full_text":"»","color":"\#FFFFFF","separator":false,"separator_block_width":10},\
{"full_text":"${memperc}%","color":${if_match ${memperc}>20}"\#cc5555"${else}"\#eeeeee"${endif},"separator":false,"separator_block_width":10 },\
\
{"full_text":"cpu","color":"\#888888","separator":false,"separator_block_width":3},\
{"full_text":"»","color":"\#FFFFFF","separator":false,"separator_block_width":10},\
{"full_text":"${cpu}%","color":${if_match ${cpu}>10}"\#cc5555"${else}"\#eeeeee"${endif},"separator":false,"separator_block_width":10},\
\
{"full_text":"bat","color":"\#888888","separator":false,"separator_block_width":3},\
{"full_text":"»","color":"\#FFFFFF","separator":false,"separator_block_width":10},\
{"full_text":"${memperc}","color":"\#eeeeee","separator":false,"separator_block_width":10},\
\
{"full_text":"net","color":"\#888888","separator":false,"separator_block_width":3},\
{"full_text":"»","color":"\#FFFFFF","separator":false,"separator_block_width":10},\
{"full_text":"${if_up wlan0}w ${wireless_bitrate wlan0}${else}${if_up eth0}e ${upspeedf eth0} up ${downspeedf eth0} dwn${else}{null}${endif}${endif}","color":"\#eeeeee","separator":false,"separator_block_width":10},\
{"full_text":"»","color":"\#FFFFFF","separator":false,"separator_block_width":10},\
\
{"full_text":"${time %a %d.%m}","color":"\#eeeeee","separator":false,"separator_block_width":10},\
{"full_text":"${time %H:%M}                          ","color":"\#eeeeee"}\
],
