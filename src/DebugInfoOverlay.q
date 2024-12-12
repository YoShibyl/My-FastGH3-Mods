dbginfo_enabled = 1

dbginfo_globalvar_1 = '0'
dbginfo_globalvar_2 = '0'
dbginfo_globalvar_3 = '0'
dbginfo_globalvar_4 = '0'

ExampleVar = 69

script DebugInfoOverlay_startup
    is_toggling_dbginfo = 0
    change ExampleVar = 69
    
    // Load settings.ini stuff
    FGH3Config sect='Mods' 'DebugInfoOverlay_Enabled' #"0x1ca1ff20"=($dbginfo_enabled) out=dbginfo_cfgshow
    change dbginfo_enabled = <dbginfo_cfgshow>
    FGH3Config sect='Mods' 'DebugInfoOverlay_Enabled' set=<dbginfo_cfgshow>
    
    // These 4 must be done manually like so
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar1' #"0x1ca1ff20"=($dbginfo_globalvar_1) out=dbg_inivar1
    change dbginfo_globalvar_1 = <dbg_inivar1>
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar1' set=($dbginfo_globalvar_1)
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar2' #"0x1ca1ff20"=($dbginfo_globalvar_2) out=dbg_inivar2
    change dbginfo_globalvar_2 = <dbg_inivar2>
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar2' set=($dbginfo_globalvar_2)
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar3' #"0x1ca1ff20"=($dbginfo_globalvar_3) out=dbg_inivar3
    change dbginfo_globalvar_3 = <dbg_inivar3>
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar3' set=($dbginfo_globalvar_3)
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar4' #"0x1ca1ff20"=($dbginfo_globalvar_4) out=dbg_inivar4
    change dbginfo_globalvar_4 = <dbg_inivar4>
    FGH3Config sect='Mods' 'DebugInfoOverlay_GlobalVar4' set=($dbginfo_globalvar_4)
    
    begin
        dbginfo_init
        WinPortSioGetControlPress \{deviceNum = 3 actionNum = 0}
        if (<controlNum> = 323 & <is_toggling_dbginfo> = 0) // 323 is Tab key
            if ($dbginfo_enabled = 1)
                change dbginfo_enabled = 0
                FGH3Config sect='Mods' 'DebugInfoOverlay_Enabled' set=0
            else
                change dbginfo_enabled = 1
                FGH3Config sect='Mods' 'DebugInfoOverlay_Enabled' set=1
            endif
            is_toggling_dbginfo = 1
        elseif (<controlNum> = -1 & <is_toggling_dbginfo> = 1)
            is_toggling_dbginfo = 0
        endif
        parse_dbginfo
        if ($player1_status.current_run = 69)
            change ExampleVar = 'Nice'
        endif
        wait \{1 gameframe}
    repeat
endscript

script dbginfo_init
        if ScreenElementExists id = root_window
            if NOT ScreenElementExists id = dbginfo_txt7
                i = 0
                begin
                    FormatText checksumname=dbginfo_txti 'dbginfo_txt%d' d = <i>
                    CreateScreenElement {
                        Type = TextElement
                        parent = root_window
                        id = <dbginfo_txti>
                        font = text_a1
                        Scale = 0.35
                        rgba = [255 255 255]
                        text = ''
                        just = [top left]
                        z_priority = 999999
                        Pos = ((0.0,16.0) * <i> + (3,3))
                    }
                    i = (<i>+1)
                repeat 12
            endif
        endif
endscript

script parse_dbginfo
    dbginfo_scale = 0.4
    if ($dbginfo_enabled = 0)
        dbginfo_scale = 0
    endif
    i = 0
    begin
        dbg_line = '\c1'
        GetSongTimeMs
        switch <i>
            case 0  // haha caseoh
                dbg_line = ('\ccDebug Info Overlay v' + ($DebugInfoOverlay_mod_info.version) + ' \cb(Tab to toggle)')
            case 1
                FormatText textname=dbg_line '\c1SongTime: %a' a = (<time>/1000)
            case 2
                get_song_end_time song = ($current_song)
                pogress = 0  // Poggers
                if (<total_end_time> > 0 & <time> > 0)
                    pogress = (<time> / <total_end_time> * 100)
                endif
                MathFloor \{pogress}
                CastToInteger \{pogress}
                if (<pogress> > 100)
                    pogress = 100
                endif
                FormatText textname=dbg_line '\c1SongProgress: %a\%' a = (<pogress>)
            case 3
                minus_notes = ($player1_status.total_notes - $player1_status.notes_hit)
                FormatText textname=jparaKing '%m' m=<minus_notes>  // subscribe to jasonparadise
                if ($player1_status.bot_play = 1)
                    jparaKing = (<jparaKing> + ' [BOT]')
                elseif (<minus_notes> = 0 & $player1_status.total_notes = $player1_status.current_run)
                    jparaKing = (<jparaKing> + '\c4 (FC)')
                endif
                FormatText textname=dbg_line '\c1P1 Notes Hit/Miss: %d-%m' d = ($player1_status.notes_hit) m=<jparaKing>
            // case 4
                // TO DO: Put health amounts from Rock Meter(s) in case 4 and 6
            case 5
                if ($current_num_players > 1)
                    minus_notes = ($player2_status.total_notes - $player2_status.notes_hit)
                    FormatText textname=jparaKing '%m' m=<minus_notes>
                    if ($player2_status.bot_play = 1)
                        jparaKing = (<jparaKing> + ' [BOT]')
                    elseif (<minus_notes> = 0 & $player2_status.total_notes = $player2_status.current_run)
                        jparaKing = (<jparaKing> + '\c4 (FC)')
                    endif
                    FormatText textname=dbg_line '\c1P2 Notes Hit/Miss: %d-%m' d = ($player2_status.notes_hit) m=<jparaKing>
                endif
            // case 6
                // soon™
            case 8
            case 9
            case 10
            case 11
                FormatText checksumname=dbg_checksum_i 'dbginfo_globalvar_%d' d = (<i> - 7)
                if NOT ($<dbg_checksum_i> = '0')
                    if GlobalExists name=$<dbg_checksum_i> Type=string
                        FormatText checksumname=dbg_checksum_val '%c' c = $<dbg_checksum_i>
                        FormatText textname=dbg_line '\c1%a=%n' a=<dbg_checksum_i> n=<dbg_checksum_val>
                    endif
                endif
            case 9
        endswitch
        FormatText checksumname=dbginfo_txti 'dbginfo_txt%d' d = <i>
        if ScreenElementExists id=<dbginfo_txti>
            SetScreenElementProps id=<dbginfo_txti> text=<dbg_line> scale=<dbginfo_scale>
        endif
        i = (<i>+1)
    repeat 12
endscript

DebugInfoOverlay_mod_info = {
    name = 'Debug Info Overlay'
    desc = 'Debug overlay showing various stats.  Press Tab to toggle'
    version = '1.0'
    author = 'Yoshibyl'
}
