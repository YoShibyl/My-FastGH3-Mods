starpowerpercent_mod_info = {
    name = 'Star Power percentage display'
    desc = 'Shows the exact amount of Star Power that you have'
    version = '1.1.0'
    author = 'Yoshibyl'
}

script StarPowerPercent_startup
    sp_string_p1 = ''
    sp_string_p2 = ''
    sp_num_p1 = 0.0
    sp_num_p2 = 0.0
    sptxt_pos = (65,220)
    if NOT ($Cheat_PerformanceMode = 1)
        begin
            if NOT ($boss_battle = 1)
                if NOT ($game_mode = training)
                    ExtendCrc \{HUD2D_rock_container 'p2' out = rock_meter_cont_p2}
                    if ScreenElementExists id = <rock_meter_cont_p2>
                        if NOT (ScreenElementExists id = sp_percent_text_p2)
                            CreateScreenElement { Type = TextElement parent = <rock_meter_cont_p2> font = #"0xc0becb74" id = sp_percent_text_p2 text = <sp_string_p2> Pos = <sptxt_pos> font_spacing = 5 just = [top left] rgba = [255 255 255] Scale = 0.6 alpha = 1 z_priority = 5 }
                        else
                            sp_num_p2 = ($player2_status.star_power_amount)
                            FormatText textname = sp_string_p2 '%d\%' d = <sp_num_p2>
                            SetScreenElementProps id = sp_percent_text_p2 text = <sp_string_p2>
                        endif
                    endif
                    ExtendCrc \{HUD2D_rock_container 'p1' out = rock_meter_cont_p1}
                    if ScreenElementExists id = <rock_meter_cont_p1>
                        if NOT (ScreenElementExists id = sp_percent_text_p1)
                            CreateScreenElement { Type = TextElement parent = <rock_meter_cont_p1> font = #"0xc0becb74" id = sp_percent_text_p1 text = <sp_string_p1> Pos = <sptxt_pos> font_spacing = 5 just = [top left] rgba = [255 255 255] Scale = 0.6 alpha = 1 z_priority = 5 }
                        else
                            sp_num_p1 = ($player1_status.star_power_amount)
                            FormatText textname = sp_string_p1 '%d\%' d = <sp_num_p1>
                            SetScreenElementProps id = sp_percent_text_p1 text = <sp_string_p1>
                        endif
                    endif
                endif
            endif
            wait \{1 gameframes}
        repeat
    endif
endscript

