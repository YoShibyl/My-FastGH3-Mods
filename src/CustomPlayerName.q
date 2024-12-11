username_p1 = 'Player1' // These are the default names to be initially set in settings.ini
username_p2 = 'Player2'

script CustomPlayerName_startup
    // Get names from settings.ini or initialize them
    FGH3Config sect='Mods' 'CustomPlayerName_P1' #"0x1ca1ff20"=($username_p1) out=value1
    FGH3Config sect='Mods' 'CustomPlayerName_P1' set=<value1>
    
    FGH3Config sect='Mods' 'CustomPlayerName_P2' #"0x1ca1ff20"=($username_p2) out=value2
    FGH3Config sect='Mods' 'CustomPlayerName_P2' set=<value2>
    
    change username_p1 = <value1>
    change username_p2 = <value2>
    
    // Make name(s) blank if set to 0 in the settings.ini
    if ($username_p1 = '0')
        change username_p1 = ''
    endif
    if ($username_p2 = '0')
        change username_p2 = ''
    endif
    
    begin
        if ScreenElementExists id = gem_containerp1
            if NOT ScreenElementExists id = playernametxt_p1
                CreateScreenElement {
                    Type = TextElement
                    parent = gem_containerp1
                    id = playernametxt_p1
                    font = text_a4
                    Scale = 0.8
                    rgba = [255 255 255 255]
                    text = ''
                    just = [center center]
                    z_priority = 21  // what's 9+10? lol
                    Pos = (640,675)
                }
            endif
            parse_username_tag
        endif
        if ScreenElementExists id = gem_containerp2
            if NOT ScreenElementExists id = playernametxt_p2
                // Use boss.ini Boss Name, if applicable, and only when Player 2 name is enabled
                if NOT ($username_p2 = '')
                   if ($boss_battle = 1)
                       change username_p2 = $boss_name
                   endif
                endif
                CreateScreenElement {
                    Type = TextElement
                    parent = gem_containerp2
                    id = playernametxt_p2
                    font = text_a4
                    Scale = 0.8
                    rgba = [255 255 255 255]
                    text = ''
                    just = [center center]
                    z_priority = 21
                    Pos = (640,675)
                }
            endif
            parse_username_tag 1
        endif
        GetSongTimeMs
        wait \{10 gameframes}
    repeat
endscript

script parse_username_tag
    which_player_ = 1
    if GotParam \{#"0x00000000"}
        which_player_ = 2
    endif
    user_name = ($username_p1)
    parsed_name = ''
    if (<which_player_> = 2)
        user_name = ($username_p2)
    endif
    if (<user_name> = '0')
        user_name = ''
    endif
    unparsed_name = <user_name>
    
    if (<unparsed_name> = '.instrument' || <unparsed_name> = ".instrument")
        instrumentp = ''
        instrument_of_player_ = ($player1_status.part)
        if (<which_player_> = 2)
            instrument_of_player_ = ($player2_status.part)
        endif
        if (<instrument_of_player_> = $guitar)
            instrumentp = 'Lead Guitar'
        else
            instrumentp = 'Bass Guitar'
            get_song_rhythm_track song = ($current_song)
            if (<rhythm_track> = 1)
                instrumentp = 'Rhythm Guitar'
            endif
        endif
        parsed_name = <instrumentp>
    endif
    if (<parsed_name> = '')
        parsed_name = <unparsed_name>
    endif
    if (<which_player_> = 1)
        fit_factor = 1.0
        if ($current_num_players > 1)
            fit_factor = 0.75
        endif
        StringLength string = <parsed_name>
        fit_scale = (25.0 * <fit_factor> / <str_len> + 0.03)
        if (<fit_scale> > 0.8)
            fit_scale = 0.8
        endif
        SetScreenElementProps id = playernametxt_p1 text = <parsed_name> Scale = <fit_scale>
    else
        fit_factor = 1.0
        if ($current_num_players > 1)
            fit_factor = 0.75
        endif
        StringLength string = <parsed_name>
        fit_scale = (25.0 * <fit_factor> / <str_len> + 0.03)
        if (<fit_scale> > 0.8)
            fit_scale = 0.8
        endif
        SetScreenElementProps {id = playernametxt_p2 text = <parsed_name> Scale = <fit_scale>}
    endif
endscript

mod_info = {
    name = 'Show Player Name'
    desc = 'IMPORTANT: Open the settings.ini (found in FastGH3\'s install folder) to set a custom player name to show in-game'
    author = 'Yoshibyl'
    version = '1.1'
}

