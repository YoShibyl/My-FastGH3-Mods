script mod_startup
    //   soon™
    // min_speedup = ($current_speedfactor)
    // base_speed = ($current_speedfactor)
    // max_speedup = (2.0)
    last_notes_missed = (0)
    last_notes_hit = (0)
    begin
        if ($player1_status.notes_hit > <last_notes_hit>)
            last_notes_hit = (<last_notes_hit> + 1)
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
        
        GetSongTimeMs
        if (<time> < 1)  // Reset the speed on song (re)start
            change current_speedfactor = (1.0)
            setslomo \{$current_speedfactor}
            setslomo_song \{slomo = $current_speedfactor}
            last_notes_hit = 0
            last_notes_missed = 0
        endif
        wait \{0.008333 seconds}  // Runs the script 120 times per second.
    repeat
endscript

mod_info = {
    name = 'Acceleration Mode'
    desc = 'Song speeds up with every note hit'
    author = 'Yoshibyl'
    version = '1.0.0-beta'
    //   soon™
    // params = [
    //     { name = 'max_speedup_percent' default = 200 min = 125 max = 300 type = number }
    // ]
}
