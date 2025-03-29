state("iw7_ship", "IW Steam")
{
    int levelTime : 0x3C986D4;
    int round_counter : 0x1FAB484;
    string13 currentMap : 0x60071E8;
    int resetTime : 0x6B39814;
    int Entities : 0x9AB7500; 
}

state("iw7-mod", "IW7-Mod")
{
    int levelTime : "iw7_ship.exe", 0x3C986D4;
    int round_counter : "iw7_ship.exe", 0x1FAB484;
    string13 currentMap : "iw7_ship.exe", 0x60071E8;
    int resetTime : "iw7_ship.exe", 0x6B39814;
    int Entities : "iw7_ship.exe", 0x9AB7500; 
}

startup
{
    //Solo Timer
    settings.Add("Solo Timer", true);

    //Reset Options (Parent Setting)
    settings.Add("Reset Options", true);

        //Subcategories for Reset Options
        settings.Add("Reset Value", false, "Reset Value", "Reset Options");
        settings.SetToolTip("Reset Value", "Show Raw Reset Values");

        settings.Add("Reset Timer", false, "Reset Timer", "Reset Options");
        settings.Add("Entities", false, "Entities", "Reset Options");

    //Error Tracker
    settings.Add("Errors Trackers", true);
        settings.Add("Cyro Counter", false, "Cyro Counter", "Errors Trackers");
        settings.Add("Croc Counter", false, "Croc Counter", "Errors Trackers");
    
    settings.Add("Clear Counters", false);

    // Trap Timers
    settings.Add("Trap Timers", true);

        settings.Add("sl", false, "Spaceland", "Trap Timers");
            settings.Add("ev", false, "Escape Velocity", "sl");
            settings.Add("croc", false, "Crocodile", "sl");

        settings.Add("rave", false, "Rave in the Redwoods", "Trap Timers");
            settings.Add("feedthefish", true, "Feed the fish", "rave");

        settings.Add("shuffle", false, "Shaolin Shuffle", "Trap Timers");
            //settings.Add("bunker", true, "Bunker", "gk");

        settings.Add("attack", false, "Attack of the Radioactive Thing", "Trap Timers");
            //.Add("camptrap", true, "Verruckt Trap", "rev");

        settings.Add("beast", false, "The Beast From Beyond", "Trap Timers");
            //settings.Add("doubletap", true, "Double Tap", "verruckt");


    //Function to set text component
    Action<string, string> SetTextComponent = (id, text) => {
        var textSettings = timer.Layout.Components.Where(x => x.GetType().Name == "TextComponent").Select(x => x.GetType().GetProperty("Settings").GetValue(x, null));
        var textSetting = textSettings.FirstOrDefault(x => (x.GetType().GetProperty("Text1").GetValue(x, null) as string) == id);
        if (textSetting == null)
        {
            var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
            var textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
            timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));

            textSetting = textComponent.GetType().GetProperty("Settings", BindingFlags.Instance | BindingFlags.Public).GetValue(textComponent, null);
            textSetting.GetType().GetProperty("Text1").SetValue(textSetting, id);
        }

        if (textSetting != null)
            textSetting.GetType().GetProperty("Text2").SetValue(textSetting, text);
    };
    vars.SetTextComponent = SetTextComponent;

    //Box Hits text components
    var lcCache = new Dictionary<string, LiveSplit.UI.Components.ILayoutComponent>();
    vars.SetText = (Action<string, object>)((text1, text2) =>
    {
        LiveSplit.UI.Components.ILayoutComponent lc;
        if (!lcCache.TryGetValue(text1, out lc))
            lcCache[text1] = lc = LiveSplit.UI.Components.ComponentManager.LoadLayoutComponent("LiveSplit.Text.dll", timer);

        if (!timer.Layout.LayoutComponents.Contains(lc))
            timer.Layout.LayoutComponents.Add(lc);

        dynamic tc = lc.Component;
        tc.Settings.Text1 = text1;
        tc.Settings.Text2 = text2.ToString();
    });

    vars.RemoveText = (Action<string>)((text1) =>
    {
        if (lcCache.ContainsKey(text1))
        {
            timer.Layout.LayoutComponents.Remove(lcCache[text1]);
            lcCache.Remove(text1);
        }
    });

    vars.RemoveAllTexts = (Action)(() =>
    {
        foreach (var lc in lcCache.Values)
            timer.Layout.LayoutComponents.Remove(lc);

        lcCache.Clear();
    });

    vars.boxHitsFilePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments), "IW-Counters.txt");

    // Load saved values if the file exists
    if (File.Exists(vars.boxHitsFilePath))
    {
        string[] lines = File.ReadAllLines(vars.boxHitsFilePath);

        // Parse each line to extract the values
        foreach (string line in lines)
        {
            if (line.StartsWith("Rags Slams:"))
            {
                vars.ragsSlamsCounter = int.Parse(line.Split(':')[1].Trim());
            }
            else if (line.StartsWith("Nade Count:"))
            {
                vars.nadeCounter = int.Parse(line.Split(':')[1].Trim());
            }
        }
    }
    else
    {
        vars.ragsSlamsCounter = 0;
        vars.nadeCounter = 0;
    }

    // Existing box hits initialization...
    //vars.nadeCounter = 0;
    //vars.ragsSlamsCounter = 0;
}

init
{
    //To Find Hashes of the game 
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);
    print("currentMap: " + current.currentMap);
    //[14904] Hash is: 52153CFF289C58419B910D0595DDE70A 


    switch (MD5Hash)
        {
            case "E936A09E669199D06B1CBCC39EDDD0F2":
                version = "IW Steam";
                break;

            case "52153CFF289C58419B910D0595DDE70A":
                version = "IW7-Mod";
                break; 
                
            default:
                version = "Unknown";
                break;
        }

    refreshRate = 75;
    
    if (settings["Solo Timer"])
    {
        vars.addrGameTime = game.MainModule.BaseAddress + 0xA;
        vars.fixedOffsetGameTime = game.ReadValue<UInt16>((IntPtr)vars.addrGameTime);
        vars.round_splits = new int[] {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255};
        vars.split_index = 0;
    }

    if (settings["Reset Options"])
    {
        vars.startTime = current.levelTime;
        vars.startReset = current.resetTime;
        vars.elapsedReset = 9999999;
        vars.elapsedTime = 1;
    }
}

update
{
    
    if (settings["Solo Timer"])
    {
        if (old.round_counter == 0 && current.round_counter == 1)
        {
            game.WriteValue<UInt16>((IntPtr)vars.addrGameTime, (UInt16)current.levelTime);
            vars.fixedOffsetGameTime = current.levelTime;
        }
        vars.trueTime = current.levelTime - vars.fixedOffsetGameTime;
    }

    if (settings["Reset Options"])
        {
            if(old.Entities != current.Entities)
	        {
	        	vars.elapsedTime = vars.startTime - current.levelTime;
	        	vars.elapsedReset = vars.startReset - current.resetTime;

	        	vars.startTime = current.levelTime;
	        	vars.startReset = current.resetTime;
	        }
    
        //Update Reset Value Component (only if setting is enabled)
        if (settings["Reset Value"])
        {
            vars.resetPerTick = vars.elapsedReset / vars.elapsedTime;
            vars.ticksLeft = (2147483647.0 - current.resetTime) / vars.resetPerTick;
            string resetText = current.resetTime.ToString() + " / 2147483647"; //Raw reset time
            vars.SetText("Reset Value:", resetText);
        }
        else
        {
            vars.RemoveText("Reset Value:");
        }

        if (settings["Reset Timer"])
        {
            vars.resetPerTick = vars.elapsedReset / vars.elapsedTime;
            vars.ticksLeft = (2147483647.0 - current.resetTime) / vars.resetPerTick;

            //Validate ticksLeft to prevent extreme values
            if (vars.ticksLeft > 0 && vars.ticksLeft < 1e9) // Adjust bounds as needed
            {
                //Calculate the time from ticksLeft
                double totalMilliseconds = vars.ticksLeft * 50;

                //Calculate hours, minutes, seconds, and hundredths manually
                int hours = (int)(totalMilliseconds / (1000 * 60 * 60));
                int minutes = (int)((totalMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
                int seconds = (int)((totalMilliseconds % (1000 * 60)) / 1000);
                int hundredths = (int)(totalMilliseconds % 1000) / 10; // Convert to 2 digits

                string formattedResetText;
                if (hours > 0)
                {
                    //Format as h:mm:ss.ff
                    formattedResetText = string.Format("{0}:{1:D2}:{2:D2}.{3:D2}", hours, minutes, seconds, hundredths);
                }
                else if (minutes > 0)
                {
                    //Format as m:ss.ff
                    formattedResetText = string.Format("{0}:{1:D2}.{2:D2}", minutes, seconds, hundredths);
                }
                else
                {
                    //Format as s.ff
                    formattedResetText = string.Format("{0}.{1:D2}", seconds, hundredths);
                }

                vars.SetText("Reset Timer:", formattedResetText);
            }
            else
            {
                //If ticksLeft is invalid, don't update the timer
                vars.RemoveText("Reset Timer:");
            }
        }
        else
        {
            vars.RemoveText("Reset Timer:");
        }

        if (settings["Entities"])
        {
            string resetText = current.Entities.ToString(); //Raw reset time
            vars.SetText("Entities:", resetText);
        }
        else
        {
            vars.RemoveText("Entities:");
        }
    }
}

split
{
    if(current.round_counter == vars.round_splits[vars.split_index])
    {
        vars.split_index++;
        return true;
    }

    // If the above condition doesn't trigger, check if the current round counter is one more than the old round counter
    if(old.round_counter != 0 && current.round_counter == old.round_counter + 1)
    {
        return true;
    }

    return false;
}

gameTime
{
    string[] arrayMaps = {"cp_zmb", "cp_rave", "cp_disco", "cp_town", "cp_final"};

    // Extract base map name (remove .d3dbs extension)
    string baseMap = current.currentMap;
    if (baseMap.Contains("."))
    {
        baseMap = baseMap.Substring(0, baseMap.IndexOf("."));
    }

    // Corrected Array.IndexOf usage
    if(Array.IndexOf(arrayMaps, baseMap) == -1)
    {
        return TimeSpan.Zero;
    }

    if (settings["Solo Timer"])
    {
        return new TimeSpan(0, 0, 0, 0, vars.trueTime * 50 - 7650);
    }
    
    return TimeSpan.Zero;
}

start
{
    if (settings["Solo Timer"])
    {
        return true;
    }
    return false;
}

isLoading
{
    if (settings["Solo Timer"])
    {
        return true;
    }
}

reset
{
   if (settings["Solo Timer"])
    {
        if (current.levelTime == 0 && old.levelTime != 0)
        {
            //vars.split_index = 0;
            return true;
        }
    }
    return false;
}

exit
{
    // Reuse the same dictionary mapping for text removals
    var textRemovals = new Dictionary<string, string>
    {
        {"Reset Value", "Reset Value:"},
        {"Entities", "Entities:"},
        {"Reset Timer", "Reset Timer:"}
    };

    // Process all text removals
    foreach (var item in textRemovals)
    {
        if (settings[item.Key])
        {
            vars.RemoveText(item.Value);
        }
    }
}

shutdown
{
    // Reuse the same dictionary mapping for text removals
    var textRemovals = new Dictionary<string, string>
    {
        {"Reset Value", "Reset Value:"},
        {"Entities", "Entities:"},
        {"Reset Timer", "Reset Timer:"}
    };

    // Process all text removals
    foreach (var item in textRemovals)
    {
        if (settings[item.Key])
        {
            vars.RemoveText(item.Value);
        }
    }
}