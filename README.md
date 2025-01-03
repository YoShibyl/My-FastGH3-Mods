# Yoshibyl's mods for FastGH3
[FastGH3](https://github.com/donnaken15/FastGH3) is a modified version of *Guitar Hero III* for PC that allows the user to quickly load and play custom song charts.  In newer versions, it allows for loading QB mods, in the form of `*.qb.xen` files.

## List of mods
- [Acceleration Mode](#acceleration-mode)
- [Star Power Percentage](#star-power-percentage-display)
- [Custom Player Name display](#custom-player-name-display)
- [Debug Info Overlay](#debug-info-overlay)

## How to install `.qb.xen` mods
1. Open FastGH3's settings (Run `FastGH3.exe -settings` *or* the `settings.bat` file in the FastGH3 installation folder)
2. Click the QB Mods button, then click the plus **[+]** button in the bottom-left corner of the dialog.  From here, navigate to where you downloaded the mod `.qb.xen` file, and select it.
3. Load your favorite chart, and enjoy!

<details open>
  <summary>Infographic</summary>
  
![image](https://github.com/user-attachments/assets/77f63f13-18d5-4b93-b2c5-92d51d95a105)
</details>

To disable a mod, click on the mod in the QB Mods dialog, and check the Disable box.  Alternatively, you can uninstall it completely by clicking the minus **[-]** button.

## Acceleration Mode
This is the first of my mods for FastGH3.  It makes the game speed up with every note hit, and steadily slow down while the current note streak is zero.  Currently, the speed increments and limits are hardcoded, and the song speed set in FastGH3 settings won't affect the base/starting speed, but that may change to become configurable soon.

https://github.com/user-attachments/assets/5b3a9030-cad8-4b99-adec-d7e37bcad044

[Here's a different video showcasing the mod in action!](https://youtu.be/LJt_AqU60Hk)

## Star Power percentage display
A simple mod that shows exactly how much Star Power you currently have.  As of [version 1.1.1](https://github.com/YoShibyl/My-FastGH3-Mods/releases/tag/1.2.2), if you switch to 2-player Faceoff or Pro Faceoff mode, then the percentages will appear above the highway instead of below the Rock Meter.

<details open>
  <summary>Screenshot (StarPowerPercent)</summary>
  
![image](https://github.com/user-attachments/assets/617b1bfe-bab9-4440-8a2a-2dd31e3c23c5)
</details>

## Custom Player Name display
This mod adds custom text below the strikeline, which you can change in FastGH3's `settings.ini` under the `[Mods]` section.

<details open>
<summary>Here's an example of what part of your settings.ini's Mods section should look like:</summary>
  
```ini
  ; Custom Player Name settings example

  CustomPlayerName_P1=Player 1
  CustomPlayerName_P2=Player 2
```
</details>

To disable a player name for either or both players, change the respective player's name value to equal `0`, as leaving it blank will currently cause the text to show up as a garbage string.

If playing a boss battle chart (such as [this chart](https://drive.google.com/file/d/1GVKMmUK926fHVu_UE0KKTNU7-6cLIbve/view?usp=sharing) of OGAP by DragonForce), then the name of Player 2 will display as the name specified in the song's `boss.ini`, unless `CustomPlayerName_P2` is set to `0`.

### Special name tags
If you set a player name to one of the following, it will display something different:

- `.instrument` : Shows which instrument the player is playing (Lead/Rhythm/Bass Guitar)
- *More soon™*

### Color codes
![image](https://github.com/user-attachments/assets/32157b97-b4f9-4895-becc-f8d070aa7048)

If you'd like to change the colors of the name(s), you can type `\c` followed by a number `0-9`, or letter `a`, `b`, or `c`; and then the name.

**Note:** You cannot prefix special name tags (shown above) with color codes, unfortunately.

<details open>
<summary>Example of Color Codes</summary>

```ini
CustomPlayerName_P1=\c2R\c6A\c5I\c4N\c8B\c3O\c7W
```

![image](https://github.com/user-attachments/assets/cbc91e49-0c88-486d-9435-32c51b0883be)

</details>

<details open>
  <summary>Screenshot (CustomPlayerName)</summary>

![image](https://github.com/user-attachments/assets/692223e0-1015-4610-b35d-a607b109e1b9)

</details>

## Debug Info Overlay
Shows various gameplay info, as well as configurable global variables to display (which can be set in `settings.ini`, or left as `0` to disable).  Can be toggled with the Tab key.

```ini
  ; Debug Info Overlay settings example

  DebugInfoOverlay_Enabled=1
  DebugInfoOverlay_GlobalVar1=ExampleVar
  DebugInfoOverlay_GlobalVar2=0
  DebugInfoOverlay_GlobalVar3=0
  DebugInfoOverlay_GlobalVar4=0
```

<details open>
  <summary>Screenshot (DebugInfoOverlay)</summary>
  
![image](https://github.com/user-attachments/assets/f5540355-a5c8-40c9-89ab-55c136e79865)

</details>
