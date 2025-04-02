# IW7-Zombies-AutoTimers
*A multi-functional LiveSplit script for Call of Duty: Infinite Warfare Zombies.*  

# [Download](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1.3/Infinite-Warfare-Master.v1-3.asl)

[![Download](https://img.shields.io/badge/Download-v1.3-blue?style=flat-square)](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1.3/Infinite-Warfare-Master.v1-3.asl)  

# *READ ME:*

# SETUP:
- Open LiveSplit > Right Click > Edit Layout > + > Control > Scriptable Auto Splitter > Browse to `Infinite-Warfare-Master.asl`  
- Make sure your LiveSplit is comparing against Game Time:
- -  Open LiveSplit > Right Click > Compare Against > Select **Game Time** : Look down to where it says: *Best Segments*, *Average Segments*...
## - Splits setup
- You need to download one of these 2 files: 
[Blank splits to 255](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1/Blank.to.255.lss) or [Blank splits to 1000](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1/Blank.to.1000.lss)
- Open LiveSplit > Right Click > Open Splits > From File... > Browse to `Blank.to.255.lss` or `Blank.to.1000.lss` depends what you just downloaded
> [!WARNING]
> 
> If you have Splits Enabled, you need to have splits loaded, otherwise timer will stop at round 1


# Recommendations for AutoSplitter:
- I recommend downloading this [Useful](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1/Useful.zip) stuff
- [My Layout](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1/recommended_layout.lsl) For best results

If you are going to make your own layout:
 Make sure your LiveSplit is comparing against Game Time and 
- Make sure it's comparing to **Game Time** for SubSplits, Splits, Timer, Detailed Timer, Etc... in "Timing Method" I recommend using "Current Timing Method"
- Use SubSplits
- Use Detailed Timer

## Features  
 **Frame-Perfect Timing** – Synced to game engine  
 **Auto-Splitting** – Triggers on every round change  
 **Reset Tracker** – Tracks time and value until engine overflow  
 **Entity Monitor** – Live zombie/object counter  
 **Counters Monitor** – Counter for Crocodile traps and Kindles Pops usage (when shot)  
 **Trap Timers** – Trap Timers for Spaceland and Rave in the Redwoods  
### Available Trap Timers:  
#### Spaceland  
- Crocodile Trap  

#### Rave in the Redwoods  
- Feed the Fish Trap  
- Wood Chipper  
- Waterfall  


### Coming Soon  
**Error Analytics** *(Coming Soon!)* – Cryo Counter (added v1.3), Croc Counter (added v1.2), Traps Counters (to do) and more.  
**Trap Timers**  *(Coming Soon!)* – Trap Timers for Spaceland (croc added v1.2), Rave (Added all v1.1), etc.  


> [!CAUTION]
> # *Known Issues*
>- **Kindles Pops Boxes and Cryos Counters**:  
> Kindle Pops Boxes and Cryos counters, it will count whenever you pull out the actual box / cryos nade, so if you are to put it away and pull it out again, it will count as a box / cryo used.
>
> - **Kindles Pops**:  
>   Kindles Pops will only work 1 active at a time and timer only starts from 40 seconds. For now
> 
> - **Fish Trap Timer**:  
>   The fish trap behavior might occasionally act unexpectedly. If you notice any of the following:
>   - Timer not starting when it should  
>   - Timer restarting prematurely  
>   - Timer not resetting properly after completion  
> 
> If you encounter any of these issues, please DM me on Discord - oJumpy.
