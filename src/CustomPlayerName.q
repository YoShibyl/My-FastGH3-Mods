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
                    // TO DO: Make colors customizable
                    rgba = [255 255 255 255]
                    text = $username_p1
                    just = [center center]
                    z_priority = 21  // what's 9+10? lol
                    Pos = (640,675)
                }
            endif
        endif
        if ScreenElementExists id = gem_containerp2
            if NOT ScreenElementExists id = playernametxt_p2
                // Use boss.ini Boss Name, if applicable, and only when Player 2 name is enabled
                if NOT ($username_p2 = '')
                    if ($boss_battle = 1)
                        change username_p2 = $boss_name
                    else
                        change username_p2 = <value2>
                    endif
                endif
                CreateScreenElement {
                    Type = TextElement
                    parent = gem_containerp2
                    id = playernametxt_p2
                    font = text_a4
                    Scale = 0.8
                    rgba = [255 255 255 255]
                    text = $username_p2
                    just = [center center]
                    z_priority = 21
                    Pos = (640,675)
                }
            endif
        endif
        wait \{1 gameframes}
    repeat
endscript

mod_info = {
    name = 'Show Player Name'
    desc = 'IMPORTANT: Open the settings.ini (found in FastGH3\'s install folder) to set a custom player name to show in-game'
    author = 'Yoshibyl'
    version = '1.0'
}
