starpowerpercent_mod_info = {
    name = 'Star Power percentage display'
    desc = 'Shows the exact amount of Star Power that you have'
    version = '1.0.0'
    author = 'Yoshibyl'
}

script StarPowerPercent_startup
    sp_string = ''
    sp_num = 0.0
    if NOT ($Cheat_PerformanceMode = 1)
        begin
            if NOT ($end_credits = 1)
                if NOT ($game_mode = training || $game_mode = p2_battle)
                    ExtendCrc \{HUD2D_rock_container 'p1' out = rock_meter_cont}
                    if ScreenElementExists id = <rock_meter_cont>
                        if NOT (ScreenElementExists id = sp_percent_text)
                            CreateScreenElement { Type = TextElement parent = <rock_meter_cont> font = #"0xc0becb74" id = sp_percent_text text = <sp_string> Pos = (-40,-120) font_spacing = 5 just = [top left] rgba = [255 255 255] Scale = 0.6 alpha = 1 z_priority = 1000 }
                        else
                            sp_num = ($player1_status.star_power_amount)
                            FormatText textname = sp_string '%d\%' d = <sp_num>
                            SetScreenElementProps id = sp_percent_text text = <sp_string>
                        endif
                    endif
                endif
            endif
            wait \{1 gameframes}
        repeat
    endif
endscript

