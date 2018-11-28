-- Vars {{{
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type
--}}}

--Requires {{{
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local scratch       = require("scratch")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local keyboard_layout = require("keyboard_layout")
--}}}

-- Error handling {{{
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
--}}}

-- Naughty presets {{{
naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = 8
naughty.config.defaults.gap = 1
naughty.config.defaults.ontop = true
naughty.config.defaults.font = "Bitstream Vera Sans Mono Nerd Font 10"
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = 32
naughty.config.defaults.fg = beautiful.fg_tooltip
naughty.config.defaults.bg = beautiful.bg_tooltip
naughty.config.defaults.border_color = beautiful.border_tooltip
naughty.config.defaults.border_width = 2
naughty.config.defaults.hover_timeout = nil
--}}}

-- Autostart windowless processes {{{
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end
--}}}

-- RUN_ONCE: entries must be comma-separated {{{
run_once({ "nm-applet -sm-disable" }) -- Network manager tray icon
run_once({ os.getenv("HOME") .. "/bin/touchpad_toggle.sh 0" })
run_once({"compton --config " .. os.getenv("HOME") .. "/.config/compton.conf -b" })
run_once({"mpd"})
--run_once({ "xwinwrap -a -fs -sp -fs -nf -ov -- mplayer -speed 0.50 -quiet -loop 0 -nosound -wid WID " .. os.getenv("HOME") .. "/wallpaper.mp4" })
--}}}

-- Variable definitions {{{
local themes = {
    "GrumpyArch", -- 1
    "AcolyteLeeSin",
}
local chosen_theme = themes[1]
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/" .. chosen_theme .. "/theme.lua")
--}}}

--Defines {{{
local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "termite" or "urxvt" or "tilix" or "xfce4-terminal"
local editor       = os.getenv("EDITOR") or "nvim" or "vim" or "nano"
local browser      = "chromium"
local file_explorer= "thunar"
local irc_client   = "irssi"
local guieditor    = string.format("%s -e %s", terminal, editor)
local scrlocker    = "dm-tool switch-to-greeter"
local home         = os.getenv("HOME")
--}}}

-- Add gaps cause I like it.
beautiful.useless_gap = 18

-- Layouts {{{
awful.util.terminal = terminal
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    --awful.layout.suit.max,
    lain.layout.centerwork,
    --awful.layout.suit.spiral,
    --awful.layout.suit.magnifier,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair.center,
}
--}}}


awful.util.taglist_buttons = awful.util.table.join( --{{{
    awful.button({ }, 1,
        function(t)
            t:view_only()
        end),
    awful.button({ modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
    awful.button ( { }, 4,
        function(t)
            awful.tag.viewnext(t.screen)
        end),
    awful.button({ }, 5,
        function(t)
            awful.tag.viewprev(t.screen)
        end))

    awful.util.tasklist_buttons = awful.util.table.join(
    awful.button({ }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() and c.first_tag then
                    c.first_tag:view_only()
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end),
     awful.button({ }, 3,
        function()
            local instance = nil

            return function ()
                if instance and instance.wibox.visible then
                  instance:hide()
                  instance = nil
                 else
                     instance = awful.menu.clients({ theme = { width = 250 } })
                 end
            end
         end),
     awful.button({ }, 4,
        function ()
            awful.client.focus.byidx(1)
          end),
     awful.button({ }, 5,
        function ()
            awful.client.focus.byidx(-1)
        end))
--}}}

--Settings for layouts {{{
lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2
--}}}

local separators = lain.util.separators
local spr     = wibox.widget.textbox('  ')
local arrl_dl = separators.arrow_left(beautiful.fg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha",beautiful.fg_focus)

-- Widgets {{{1
local markup = lain.util.markup
space3 = markup.font("Terminus 3", " ")
clockgf = beautiful.clockgf

--Keyboard layout switcher/indicator {{{
local kbdcfg = keyboard_layout.kbdcfg({type = "tui"})

kbdcfg.add_primary_layout("English", "En" , "us")
kbdcfg.add_primary_layout("Ελληνικά", "Ελ", "gr,us")
kbdcfg.bind()
-- Mouse bindings
kbdcfg.widget:buttons(
    awful.util.table.join(
        awful.button({ }, 1,
           function ()
               kbdcfg.switch_next()
           end),
        awful.button({ }, 3,
           function ()
               kbdcfg.menu:toggle()
           end)))
--}}}

-- Clock / Calendar {{{
local clock_icon = wibox.widget.imagebox(beautiful.widget_clock)
local clock_types = {
    "%H:%M:%S ",          -- 13:19
    "%a %d %b %H:%M:%S ", -- Thu 08 Feb 13:19
}

local chosen_clock_type = clock_types[2] -- You can choose a clock type
local textclock = wibox.widget.textclock(markup(beautiful.fg_focus, space3 .. chosen_clock_type .. markup.font("Tamsyn 3", " ")), 1)
local clock_widget = wibox.container.background(textclock)

lain.widget.cal({
    cal = "cal --color=always",
    attach_to = { textclock },
    notification_preset = {
        font = beautiful.calendar_font,
        fg   = beautiful.fg_normal,
        bg   = beautiful.bg_focus
    }
})
--}}}

-- CPU {{{
local cpu_icon = wibox.widget.imagebox(beautiful.widget_cpu)
local cpu_icon_widget = wibox.container.background(cpu_icon, beautiful.fg_focus)
local cpu = lain.widget.cpu({
    settings =
        function()
            widget:set_markup(space3 .. markup.color(beautiful.bg_normal, beautiful.fg_focus, cpu_now.usage .. "% ") .. markup.font("Tamsyn 4", " "))
        end })

local cpu_widget = wibox.container.background(cpu.widget, beautiful.fg_focus)
--}}}

-- MEM {{{
local mem_icon = wibox.widget.imagebox(beautiful.widget_mem)
local mem = lain.widget.mem({
    settings =
        function()
            widget:set_markup(markup.color(beautiful.fg_focus, beautiful.bg_normal,
                                space3 .. mem_now.used .. "MB " .. markup.font("Tamsyn 4", " ")))
        end })

local mem_widget = wibox.container.background(mem.widget)
mem_widget.bgimage=beautiful.bg_normal
--}}}

-- Net {{{
local netdl_icon = wibox.widget.imagebox(beautiful.widget_netdl)
local netup_icon = wibox.widget.imagebox(beautiful.widget_netul)

local net_widgetdl = lain.widget.net({
    iface = "wlp8s0",
    settings =
        function()
            widget:set_markup(
                markup.font("Tamsyn 1", " ") 
                .. markup.color(beautiful.fg_focus, beautiful.bg_normal,net_now.received) .. " ")
        end })

local net_widgetul = lain.widget.net({
    iface = "wlp8s0",
    settings =
        function()
            widget:set_markup(markup.font("Tamsyn 1", "   ")
                .. markup.color(beautiful.fg_focus, beautiful.bg_normal , net_now.sent))
        end })

local netdl_widget = wibox.container.background(net_widgetdl.widget)
local netup_widget = wibox.container.background(net_widgetul.widget)
--}}}

-- FS {{{
local fs_icon = wibox.widget.imagebox(beautiful.widget_fs)
local fs_icon_widget = wibox.container.background(fs_icon, beautiful.fg_focus)
local fs = lain.widget.fs({
    notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = beautiful.fs_font },
    settings =
        function()
            local fsp = string.format(" %3.2f %s ", fs_now["/home"].free, "GB"--[[fs_now["/home"].units]])
            widget:set_markup(markup.color(beautiful.bg_normal, beautiful.fg_focus, markup.font(beautiful.font, fsp)))
        end })

local fs_widget = wibox.container.background(fs.widget, beautiful.fg_focus)
fs_widget.bgimage=beautiful.bg_normal
--}}}

-- MPD {{{
prev_icon = wibox.widget.imagebox(beautiful.mpd_prev)
next_icon = wibox.widget.imagebox(beautiful.mpd_nex)
stop_icon = wibox.widget.imagebox(beautiful.mpd_stop)
pause_icon = wibox.widget.imagebox(beautiful.mpd_pause)
play_pause_icon = wibox.widget.imagebox(beautiful.mpd_play)

mpdwidget = lain.widget.mpd({
    settings =
        function ()
            if mpd_now.state == "play" then
                mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
                mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
                widget:set_markup(markup.color(beautiful.fg_focus, beautiful.bg_normal,
                                    markup.font("Tamsyn 3", " ")
                                  ..markup.font("Tamsyn 7",
                                  mpd_now.artist
                                  .. " - " ..
                                  mpd_now.title
                                  .. markup.font("Tamsyn 2", " "))))

                play_pause_icon:set_image(beautiful.mpd_pause)
            elseif mpd_now.state == "pause" then
                widget:set_markup(markup.color(beautiful.fg_focus, beautiful.bg_normal,
                                    markup.font("Tamsyn 4", "") ..
                                  markup.font("Tamsyn 7", "MPD PAUSED") ..
                                  markup.font("Tamsyn 10", "")))
                play_pause_icon:set_image(beautiful.mpd_play)
            else
                widget:set_markup("")
                play_pause_icon:set_image(beautiful.mpd_play)
            end
        end })

music_widget = wibox.container.background(mpdwidget.widget)

music_widget:buttons(awful.util.table.join(awful.button({ }, 1,
    function () awful.util.spawn_with_shell(ncmpcpp) end)))
        prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        awful.util.spawn_with_shell("mpc prev || ncmpcpp prev")
        mpdwidget.update()
    end)))

next_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        awful.util.spawn_with_shell("mpc next || ncmpcpp next")
        mpdwidget.update()
    end)))

stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        play_pause_icon:set_image(beautiful.mpd_play)
        awful.util.spawn_with_shell("mpc stop || ncmpcpp stop")
        mpdwidget.update()
    end)))

play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle")
        mpdwidget.update()
    end)))
--}}}

-- ALSA volume bar {{{
local vol_icon = wibox.widget.imagebox(beautiful.vol)
local volume_icon_widget = wibox.container.background(vol_icon, beautiful.fg_focus)
volume = lain.widget.alsabar {
    width = 60, border_width = 0, ticks = true, ticks_size = 6,
    notification_preset = { font = beautiful.font },
    --togglechannel = "IEC958,3",
    settings = function()
        if volume_now.status == "off" then
            vol_icon:set_image(beautiful.vol_mute)
        elseif volume_now.level == 0 then
            vol_icon:set_image(beautiful.vol_no)
        elseif volume_now.level <= 50 then
            vol_icon:set_image(beautiful.vol_low)
        else
            vol_icon:set_image(beautiful.vol)
        end
    end,
    colors = {
        background   = beautiful.fg_focus,
        mute         = red,
        unmute       = beautiful.bg_normal
    }
}


volume.tooltip.wibox.fg = beautiful.fg_focus
volume.bar:buttons(gears.table.join (
          awful.button({}, 1, function()
            awful.spawn(string.format("%s -e alsamixer", awful.util.terminal))
          end),
          awful.button({}, 2, function()
            os.execute(string.format("%s set %s 100%%", volume.cmd, volume.channel))
            volume.update()
          end),
          awful.button({}, 3, function()
            os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
            volume.update()
          end),
          awful.button({}, 4, function()
            os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
            volume.update()
          end),
          awful.button({}, 5, function()
            os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
            volume.update()
          end)
))
local volumebg = wibox.container.background(volume.bar, beautiful.bg_normal, gears.shape.rounded_rect)
local volume_widget = wibox.container.margin(volumebg, 2, 7, 4, 4, beautiful.fg_focus)
volume_widget.background = beautiful.fg_focus
--}}}

-- Battery {{{
local bat_icon = wibox.widget.imagebox(beautiful.widget_battery)
local bat_icon_widget = wibox.container.background(bat_icon, beautiful.fg_focus)
local bat = lain.widget.bat({
    battery = "BAT1",
    timeout = 1,
    notify = "on",
    n_perc = {5,15},
    settings =
        function()
            bat_notification_low_preset = {
                title = "Battery low",
                text = "Plug the cable!",
                timeout = 5,
                fg = beautiful.fg_normal,
                bg = beautiful.bg_normal
            }

            bat_notification_critical_preset = {
                title = "Battery exhausted",
                text = "Shutdown imminent",
                timeout = 15,
                fg = beautiful.bat_fg_critical,
                bg = beautiful.bat_bg_critical
            }

            if bat_now.status ~= "N/A" then
                if bat_now.status == "Charging" then
                    widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.bg_normal, "+" .. bat_now.perc .. "% ")))
                    bat_icon:set_image(beautiful.widget_ac)
                elseif bat_now.status == "Full" then
                    widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.bg_normal, "~" .. bat_now.perc .. "% ")))
                    bat_icon:set_image(beautiful.widget_battery)
                elseif tonumber(bat_now.perc) <= 35 then
                    bat_icon:set_image(beautiful.widget_battery_empty)
                    widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.bg_normal, "-" .. bat_now.perc .. "% ")))
                elseif tonumber(bat_now.perc) <= 80 then
                    bat_icon:set_image(beautiful.widget_battery_low)
                    widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.bg_normal, "-" .. bat_now.perc .. "% ")))
                elseif tonumber(bat_now.perc) <= 99 then
                    bat_icon:set_image(beautiful.widget_battery)
                    widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.bg_normal, "-" .. bat_now.perc .. "% ")))
                else
                    bat_icon:set_image(beautiful.widget_battery)
                    widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.bg_normal, "-" .. bat_now.perc .. "% ")))
                end
            else
                widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.bg_normal, "AC ")))
                bat_icon:set_image(beautiful.widget_ac)
            end
        end })

local bat_widget = wibox.container.background(bat.widget, beautiful.fg_focus)
bat_widget.bgimage=beautiful.bg_normal
--}}}

function connect(s) --{{{
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = beautiful.wallpaper

    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end

    gears.wallpaper.maximized(wallpaper, 1, true)

    -- Tags
    --awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
    layout = { awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1]}
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, layout)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 28,  bg = beautiful.panel, fg = beautiful.fg_normal, opacity=1.0 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.mypromptbox,
            wibox.widget.systray(),
            kbdcfg.widget,
            -- Volume
            arrl_ld,
            volume_icon_widget,
            volume_widget,
            arrl_dl,
            -- MPD widget
            prev_icon,
            stop_icon,
            play_pause_icon,
            next_icon,
            music_widget,
            -- CPU widget
            arrl_ld,
            cpu_icon_widget,
            cpu_widget,
            -- Mem widget
            arrl_dl,
            mem_icon,
            mem_widget,
            -- Fs widget
            arrl_ld,
            fs_icon_widget,
            fs_widget,
            -- Net widget
            arrl_dl,
            netdl_icon,
            netdl_widget,
            netup_widget,
            netup_icon,
            -- Battery widget
            arrl_ld,
            bat_icon_widget,
            bat_widget,
            -- Clock
            arrl_dl,
            clock_icon,
            clock_widget,
            -- Layout box
            arrl_ld,
            s.mylayoutbox
        },
    }
end
--}}}

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) connect(s) end)

-- Menu {{{
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s %s", guieditor, awesome.conffile) },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
--}}}


awful.util.mymainmenu = freedesktop.menu.build({ --{{{
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
})
--}}}

screen.connect_signal("property::geometry", function(s) --{{{
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        --gears.wallpaper.maximized(wallpaper, s, true)
    end
end)
--}}}

-- Mouse bindings {{{
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
--}}}

-- Key bindings {{{
globalkeys = awful.util.table.join(
    -- X screen locker
    awful.key({ modkey  }, "F12", function () os.execute(scrlocker) end, {description = "lock screen", group = "hotkeys"}),
    awful.key({ modkey }, "s",      hotkeys_popup.show_help, {description = "show help", group="awesome"}),
    -- Tag browsing awful.key({ modkey,           }, "Left",   awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    -- Non-empty tag browsing
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),

    --Keyboard layout stuff
    awful.key({"Shift"}, "Alt_L", function () kbdcfg.switch_next() end),
    -- Alt-Shift to change keyboard layout
    awful.key({"Mod1"}, "Shift_L", function () kbdcfg.switch_next() end),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function() awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Client Resizing
    awful.key({ modkey, "Control"    }, "l",     function () awful.tag.incmwfact( 0.01)    end),
    awful.key({ modkey, "Control"    }, "h",     function () awful.tag.incmwfact(-0.01)    end),
    awful.key({ modkey, "Control"    }, "j",     function () awful.client.incwfact( 0.01)    end),
    awful.key({ modkey, "Control"    }, "k",     function () awful.client.incwfact(-0.01)    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Programms
    -- Touchpad toggle
    awful.key({ modkey, "Shift" }, "t",
              function ()
                  awful.util.spawn("sh " .. os.getenv("HOME") .. "/bin/touchpad_toggle.sh")
              end,
              {description="Toggle touchpad on/off", group="My Shortcuts"}),
    awful.key({ modkey, "Shift" }, "\\",
              function ()
                  awful.util.spawn("sh " .. os.getenv("HOME") .. "/bin/live_wallpaper_toggle.sh")
              end,
              {description="Toggle Live wallpaper on/off", group="My Shortcuts"}),

    awful.key({ modkey            }, "v", function() awful.util.spawn_with_shell("vivaldi-snapshot") end ),
    awful.key({ modkey            }, "r", function() awful.util.spawn(string.format("%s -e ranger", terminal)) end ),
    awful.key({ modkey            }, "g", function() awful.util.spawn('gyazo') end),
    awful.key({ modkey            }, "l", function() awful.util.spawn_with_shell("~/.config/scripts/lock.sh") end),
    awful.key({                   }, "Print", function() awful.util.spawn(
        "scrot -e 'mv $f ~/Pictures/screenshots/ && notify-send -i ~/Pictures/screenshots/$f \"Snapshot\" \"\"'" ) end),

    -- Standard program!!1
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "e", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Dropdown application
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,
              {description = "dropdown application", group = "launcher"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end,
              {description = "-10%", group = "hotkeys"}),

    -- ALSA volume control
    awful.key({  }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%+", volume.channel))
            volume.update()
        end,
        {description = "volume up", group = "hotkeys"}),
    awful.key({  }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", volume.channel))
            volume.update()
        end,
        {description = "volume down", group = "hotkeys"}),
    awful.key({  }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", volume.togglechannel or volume.channel))
            volume.update()
        end,
        {description = "toggle mute", group = "hotkeys"}),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.spawn.with_shell("mpc toggle")
            mpdwidget.update()
        end,
        {description = "mpc toggle", group = "widgets"}),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.spawn.with_shell("mpc stop")
            mpdwidget.update()
        end,
        {description = "mpc stop", group = "widgets"}),
    awful.key({ altkey, "Control" }, "Left",
              function ()
                  awful.spawn.with_shell("mpc prev")
                  mpdwidget.update()
              end,
        {description = "mpc prev", group = "widgets"}),
    awful.key({ altkey, "Control" }, "Right",
               function ()
                   awful.spawn.with_shell("mpc next")
                   mpdwidget.update()
               end,
        {description = "mpc next", group = "widgets"}),
    awful.key({ altkey }, "0",
        function ()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if mpdwidget.timer.started then
                mpdwidget.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                mpdwidget.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end,
        {description = "mpc on/off", group = "widgets"}),

    -- User programs
    awful.key({ modkey }, "t", function () awful.spawn(file_explorer) end,
              { description = "Thunar File explorer", group = "launcher"}),
    awful.key({ modkey }, "i", function () awful.spawn(browser) end,
               {description = "run browser", group = "launcher"}),
    awful.key({ modkey }, "e", function () awful.spawn(guieditor) end,
               {description = "run gui editor", group = "launcher"}),
    awful.key({ modkey, "Shift"}, "c",
        function ()
            awful.spawn(string.format("%s -e '%s %s'", terminal, editor, awesome.conffile))
        end),
    -- Prompt
    awful.key({ modkey }, "d",
               function ()
                   awful.util.spawn("rofi -show-icons -show drun")
               end),
    awful.key({ modkey }, "c",
               function ()
                   awful.screen.focused().mypromptbox:run()
               end,
              {description = "run prompt", group = "launcher"})
)
--}}}

clientkeys = awful.util.table.join( --{{{
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client                         ),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    --[[
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    ]]--
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)
--}}}

-- Bind all key numbers to tags. --{{{
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end
--}}}

clientbuttons = awful.util.table.join( --{{{
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

root.keys(globalkeys)
--}}}

-- Rules {{{
awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      except_any = { { class = {"Gimp", "krita", "blender", "discord",
                              "chromium", "MPlayer", "Steam"}}},
      properties = { titlebars_enabled = true } },

     { rule = { class = "xfce4-panel" },
       properties = { ontop = true, sticky = true }},
    { rule = { class = "Nm-connection-editor", role = "Internet" },
      properties = { floating = true }},

    { rule = { instance = "exe" },
      properties = { floating = true } },

    { rule = { role = "_NET_WM_STATE_FULLSCREEN" },
      properties = { floating = true } },

    { rule = { class = "Gimp", role = "gimp-image-window-1" },
      properties = { tag = awful.screen.focused().tags[5]} },

    { rule = { class = "krita", role = "MainWindow#1" },
      properties = { tag = awful.screen.focused().tags[5]} },

    { rule = { class = "blender", role = "Graphics" },
      properties = { tag = awful.screen.focused().tags[5]} },

    { rule = { class = "discord" },
      properties = { tag = awful.screen.focused().tags[9]} },

    { rule = { class = "chromium" },
        properties = { tag = awful.screen.focused().tags[1] } },

    { rule = { class = "qutebrowser" },
      properties = { tag = awful.screen.focused().tags[1] } },

    { rule = { name = "MPlayer" },
      properties = { floating = true }},

    { rule = { name = "Steam" },
      properties = { floating = true, tag = awful.screen.focused().tags[7]}},
}
--}}}

-- Signals {{{
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    c.shape = gears.shape.rounded_rect

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
--}}}

-- Add a titlebar if titlebars_enabled is set to true in the rules. {{{
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 22}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
--}}}

-- Enable sloppy focus, so that focus follows mouse. {{{
client.connect_signal("mouse::enter",
    function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)
--}}}

-- No border for maximized clients {{{
client.connect_signal("focus",
    function(c)
        if c.maximized then -- no borders if only 1 client visible
            c.border_width = 0
        elseif #awful.screen.focused().clients > 1 then
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
--}}}

