# IW7-Zombies-AutoTimers
A multi-functional LiveSplit script for Call of Duty: Infinite Warfare Zombies.

If you encounter any issues, please DM me on Discord: `ojumpy`

# [Download v1.7](https://github.com/oJumpy/IW7-Zombies-AutoTimers/releases/download/v1.7/Infinite-Warfare-Master.-.v1.7.asl)

## Features
- Frame Perfect Timing: Times are synced up with the game engine itself.
- Automatic Splitting: Triggers on every round change.
- Reset Tracker: Tracks time and `numSnapshotEntities` value.
- Entity Monitor: Zombie and general entity counter.
- Counters Monitor: Counter for Kindles Pops Boxes, Cryo grenades, All current avaiable traps
- Trap Timers for Spaceland, Rave in the Redwoods and Shaolin Shuffle.
  - (Spaceland) Crocodile Trap, Escape Velocity Trap (Dynamic)
  - (Rave in the Redwoods) Feed the Fish Trap, Wood Chipper, Waterfall, Log Swing
  - (Shaolin Shuffle) Ventilation System, Hydrant, Electric Trap

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
> ### Saving layouts
> If you save your layout, with some settings enable you will encounter unexpected behavior. Example:
> - Duplicates Reset options and or other settings if enabled.
> - Timer size will get smaller
> ### Solution
> Save your layout only when you first loaded the script or click on `Reset to default` in the bottom right in `Scriptable Auto Splitter`, then save.
> I recommend to never save your layout whenever you enable additional settings.

### Kindles Pops Boxes and Cryos Counters 
Kindle Pops Boxes and Cryos counters, it will count whenever you pull out the actual box/cryos nade, so if you are to put it away and pull it out again, it will count as a box/cryo used.
- Kindles Pops will only work one at a time and timer only starts from 40 seconds.

### Fish Trap Timer
The fish trap behavior might occasionally act unexpectedly:
- Timer not starting when it should.
- Timer restarting prematurely.
- Timer not resetting properly after completion.


# What Leaks Variables?

# General leaks:

## Bags
- Bags will permanently leak, if **NOT** picked up
- 99% They don't leak, or not leak anywhere near as bad if picked up

## Camo Leaks:
These specific camos will permanently leak if the weapon is taken away, like when papped:
- camo31 - mw2_camo_31, Nostalgia
- camo84 - blood_camo_84, Jam
- camo222 -  blood_camo_222, maybe this is Jam again? or Death?

Once the weapon is taken or papped, the tracking script stays running on you forever. Even though you don't have the camo anymore, getting kills with any other weapon will still trigger the leak on every kill.

If you pap these weapons multiple times, or go down with them multiple times, the leaked threads will stack up and make the leak even worse.

## Specific weapons that hit zombies will leak:
Any weapons or equipment that apply burning (fire) or freeze (cold) effects will leak. 

Hitting the zombie is what causes the leak and it's actually worse when killing them.

List of weapons that leak:
- iw7_erad, Erad - Cyclopean, passive_fire_damage 
- iw7_erad, Erad - Merciless, passive_cold_damage 
- iw7_rvn, RVN - Blown Fuse, passive_fire_damage 
- iw7_emc, EMC - Avalanche, passive_fire_damage 
- iw7_kbs, KBS Longbow - Affliction, passive_cold_damage 
- iw7_mauler, Mauler - Expanse, passive_cold_damage 
- iw7_forgefreeze, Forgefreeze, passive_cold_damage
- iw7_tacburst, Tac-Burst - Siren / Siren's Song, passive_cold_damage_gl

## PaP seems to be actually safe to use, the only leaks are:
1 - If you enter pap room, leave and **re-enter it, within 60 seconds**, it will leak
2 - i guess more rare case, but for coops, disconnecting while entering pap room or while papping leaving the gun there, will permanently leak


## Transponder
- Throwing it and using it normally is safe.
- If you were to throw it somewhere it can't be placed at and goes back to your inventory, it is safe.
**Leak:**
- If a placed Transponder gets destroyed or replaced by throwing a new one, it permanently leaks. **In Solo, nothing can clean this up.**
- If you pull it out and cancel the throw, it leaks. However, you can **clear this thread completely** by buying any other equipment.


## Rewind
Seems to be safe to use.

## Disconnect leaks:
There's actually a bunch of leaks in coops, with players disconnecting during certain conditions, so would just be careful with that, before leaving a game in coop try to not do anything at all 

# Spaceland

## Croc
Using the Croc trap will permanently leak variables if you turn on all 5 power switches.
- Leaving 1 of the 5 power switches turned off, will leak 1 less thread, compared to 2, if all switches were turned on

## Cryos
Cryos **only** leak permanent variables, if the counter hits 0
- Keep always 1 Cryo nade and let it refill, to not cause any permanent leaks

# Rave in the Redwood

## About Traps:
About traps on Rave, Fish Trap, Wood Chipper and Lawn Mower, seem to leak

- **Fish Trap:** killing a full horde of 24 zombies at once causes a temporary spike

- **Wood Chipper and Lawn Mower:** seem to only leak if you kill the zombies before the trap does 

- **"Balloons Trap", Waterfall, and Log Swing traps are safe to use.**

## Bow leaks:

Acid Rain, bow seems safe to use, there's a temporary spike, only if you kill too many zombies at once with it or if you were to down while the Acid Rain is active

Whirlwind bow, seems to actually be pretty bad to be used in general no matter what, especially on full hordes

Trap-O-Matic, also is pretty bad to use, seems to leak variables each time time it connects to create the trap line thing,  especially having multiples active will create a permanent leak, because it won't clean up the one previously crated

Also the storm one seemed bad to use, but i know it's not used anyways

## ZipLine 
- Is safe to use it self, unless during special conditions, it will just have some temporary spike in variables, when you go near the trigger.<br> 
The special conditions is downing while using it, will create permanent leak, you cold clear this one if you are playing a coop, where you can bleed out and spawn back in, prob not very useful tbh

# How to Track these leaks?
With the LiveSplit script, you can track exactly where the leaks are building up.
Here is what to monitor with the tracker:

- Camo Leaks: Monitor **Notify Threads** and **Stacks** 

- Specific weapon leak: Monitor **Notify Threads**, **Pointers**, and **Stacks**

- PaP Room Quick Re-entry Leak: Monitor **Notify Threads**, **Stacks**, and **Threads**.

- Croc Trap Leak: Monitor **Notify Threads**, **Threads**, and **Stacks**

- Cryo Grenade : Monitor **Threads**, **Notify Threads**, and **Stacks**.

- Acid Rain Horde Clumping Leak: Monitor **Pointers** and **Structs**

- Whirlwind Sound & Zombie State Leak: Monitor **Pointers** 

- Trap-O-Matic Array & Origin Leak: Monitor **Pointers** For just creating the trap, **Structs**, and **Notify Threads** For multiple active traps

