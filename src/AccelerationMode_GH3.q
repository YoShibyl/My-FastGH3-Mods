extras_menu = []
accel_mode_enabled = 1

mod_info = {
    name = 'Acceleration Mode'
    desc = 'Song speeds up with every note hit'
    author = 'Yoshibyl'
    version = '1.1.0-beta'
    params = [
        { name = 'AccelerationMode_Enabled' default = 1 type = bool ini = ['Mods' 'AccelerationMode_Enabled'] }
        // { name = 'max_speedup_percent' default = 200 min = 125 max = 300 type = number } // later
    ]
}

script mod_startup
    //   soon™
    // min_speedup = ($current_speedfactor)
    // base_speed = ($current_speedfactor)
    // max_speedup = (2.0)
    FGH3Config sect='Mods' 'AccelerationMode_Enabled' #"0x1ca1ff20"=($accel_mode_enabled)
	change accel_mode_enabled = <value>
    accel_last_value = $accel_mode_enabled
    last_notes_missed = 0
    last_notes_hit = 0
    
    begin
        if ($accel_mode_enabled = 1)
            if ($player1_status.notes_hit > <last_notes_hit>)
                last_notes_hit = ($player1_status.notes_hit)
                if ($current_speedfactor < 2.0)
                    change current_speedfactor = ($current_speedfactor + 0.0005)
                    setslomo \{$current_speedfactor}
                    setslomo_song \{slomo = $current_speedfactor}
                endif
            elseif ($player1_status.current_run = 0)
                last_notes_missed = ($player1_status.notes_missed) // I can't figure this out lol
                change current_speedfactor = ($current_speedfactor - 0.00025)
                setslomo \{$current_speedfactor}
                setslomo_song \{slomo = $current_speedfactor}
                if ($current_speedfactor < 1.0)
                    change current_speedfactor = (1.0)
                    setslomo \{$current_speedfactor}
                    setslomo_song \{slomo = $current_speedfactor}
                endif
            endif
        endif
        
        GetSongTimeMs
        if (<time> < -1500 || $accel_mode_enabled = 0)  // Reset the speed on song (re)start or disabling mod
            change current_speedfactor = (1.0)
            setslomo \{$current_speedfactor}
            setslomo_song \{slomo = $current_speedfactor}
            last_notes_hit = 0
            last_notes_missed = 0
        endif
        
        // TO DO: Figure out how to append the menu instead of rewriting the whole menu.
        change extras_menu = [
            // guide
            // (NO NAME) = variable to set
            // name = display name
            // type = type of item (bool, int, etc)
            // min = minimum value allowed (int)
            // max = maximum value allowed (int)
            // sect = INI section (default: Misc)
            // key = INI key
            // restart = 1 requires restarting the song (2) requires restarting game?
            {
                Cheat_Hyperspeed
                name='Hyperspeed'
                sect='Player'
                type=int min=-13 max=10
                restart=1
            }
            {
                fps_max
                name='Frame Rate'
                sect='GFX' key='MaxFPS'
                type=int min=0 max=1000 step=5
            }
            {
                disable_particles
                name='Particles'
                sect='GFX' key='NoParticles'
                type=int min=0 max=2
            }
            {
                hudless
                name='No HUD'
                type=bool sect='GFX' key='NoHUD'
                restart=1
            }
            {
                disable_intro
                name='No Intro'
                type=bool sect='GFX' key='NoIntro'
                restart=1
            }
            {
                disable_shake
                name='No Highway Shake'
                type=bool sect='GFX' key='NoShake'
            }
            {
                exit_on_song_end
                name='Exit on Song End'
                type=bool sect='Player' key='ExitOnSongEnd'
            }
            {
                kill_gems_on_hit
                name='Hide Gems Upon Hit'
                type=bool sect='GFX' key='KillGemsHit'
            }
            {
                enable_button_cheats
                name='Debug Menu'
                type=bool key='Debug'
            }
            {
                Cheat_NoFail
                name='No Fail'
                type=bool sect='Player' key='NoFail'
            }
            {
                Cheat_EasyExpert
                name='Easy Expert'
                type=bool sect='Player' key='EasyExpert'
                restart=1
            }
            {
                Cheat_PrecisionMode
                name='Precision'
                type=bool sect='Player' key='Precision'
                restart=1
            }
            {
                FC_MODE
                name='FC Mode'
                type=bool sect='Player' key='FCMode'
                restart=1
            }
            {
                gem_scalar
                name='Gem Scale'
                sect='GFX' key='GemScale'
                type=int min=0.0 max=100.0 step=0.05
                restart=1
            }
            {
                current_speedfactor
                name='Speed Factor'
                sect='Player' key='Speed'
                type=int min=0.05 max=100.0 step=0.05
            }
            {
                accel_mode_enabled
                name='Accel. Mode'
                type=bool sect='Mods' key='AccelerationMode_Enabled'
            }
        ]
        
        wait \{0.00833333 seconds}  // Runs the script about 120 times per second.
    repeat
endscript
