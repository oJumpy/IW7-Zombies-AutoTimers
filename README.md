# IW7-Zombies-AutoTimers
A multi-functional LiveSplit script for Call of Duty: Infinite Warfare Zombies.

If you encounter any issues, please DM me on Discord: `ojumpy`

# [Download v1.4](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1.4/Infinite-Warfare-Master.v1-4.asl)

## Features
- Frame Perfect Timing: Times are synced up with the game engine itself.
- Automatic Splitting: Triggers on every round change.
- Reset Tracker: Tracks time and `numSnapshotEntities` value.
- Entity Monitor: Zombie and general entity counter.
- Counters Monitor: Counter for Kindles Pops Boxes, Cryo grenades, All current avaiable traps
- Trap Timers for Spaceland, Rave in the Redwoods and Shaolin Shuffle.
  - (Spaceland) Crocodile Trap, Escape Velocity Trap (Dynamic)
  - (Rave in the Redwoods) Feed the Fish Trap, Wood Chipper, Waterfall, Log Swing
  - (Shaolin Shuffle) Ventilation System

## Setup
1. Right Click LiveSplit → Edit Layout → `+` button → Control → Scriptable Auto Splitter → Browse to `Infinite-Warfare-Master.asl` and select it.
1. If you want splits, refer to [Setting up Splits](#setting-up-splits) at this step.
1. Right Click LiveSplit → Compare Against → Select `Game Time`, Look down to where it says: *Best Segments*, *Average Segments*...

## Setting up Splits
- Download the splits you prefer:
  - [Blank splits to 255](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1/Blank.to.255.lss)
  - [Blank splits to 1000](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1/Blank.to.1000.lss)

- Right Click LiveSplit → `Open Splits` → `From File...` → Browse to the splits file you downloaded and select it.

> [!WARNING]
> If you have Splits enabled, you need to have splits loaded, otherwise the timer will stop at Round 1.

## Recommended Layout
This is a pre-setup layout, however you will still have to do the initial setup for `Infinite-Warfare-Master.asl`.

[Download](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1/recommended_layout.lsl)

![image](https://github.com/user-attachments/assets/cdcbb567-bedb-4934-91ca-aea3e351e947)

## Custom Layouts
If you are going to make your own layout, make sure your LiveSplit is comparing against `Game Time` for everything. This includes `Subsplits`, `Splits`, `Timer`, `Detailed Timer`, etc.

For `Timing Method`, I recommend using `Current Timing Method`.

# Counters behaviour:
Counters will save on a text file, that will be created in your documents folder called: `IW-Counters.txt`
All counters will stay saved even if you were to close livesplit, the only way to reset it is to check the box called `Clear Counters` in the `scriptable auto splitter` Layout setting. Once cleared you can uncheck the box other wise it will always stay to 0.

# **How to Reset**  Counters:
1. Open LiveSplit → **Layout Settings** → **Scriptable Auto Splitter**.  
2. Check **`Clear Counters`** → Counters reset to `0`.  
3. **Uncheck after reset** (or counters stay at `0`).  

## Coming Soon
- More Trap Timers for other maps.

## Known Issues
> [!CAUTION]
> These are some known issues with the timer, and will be fixed in the future.

### Kindles Pops Boxes and Cryos Counters 
Kindle Pops Boxes and Cryos counters, it will count whenever you pull out the actual box/cryos nade, so if you are to put it away and pull it out again, it will count as a box/cryo used.
- Kindles Pops will only work one at a time and timer only starts from 40 seconds.

### Fish Trap Timer
The fish trap behavior might occasionally act unexpectedly:
- Timer not starting when it should.
- Timer restarting prematurely.
- Timer not resetting properly after completion.
