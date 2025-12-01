state("Raji-Win64-Shipping")
{
    float xPos          : 0x4361CA0, 0x180, 0x38, 0x0, 0x30, 0x260, 0x130, 0x11C;
    float yPos          : 0x4361CA0, 0x180, 0x38, 0x0, 0x30, 0x260, 0x130, 0x120;
    float zPos          : 0x4361CA0, 0x180, 0x38, 0x0, 0x30, 0x260, 0x130, 0x124;
}

startup
{
    vars.splitsData = new Dictionary<string, Tuple<bool, string, string, Func<bool>>> {
        { "caves",      Tuple.Create(false, "Caves",            "Split on finishing the ruins",                     new Func<bool>(() => vars.caves()       )) },
        { "ruins",      Tuple.Create(false, "Ruins",            "Split on entering the fortress",                   new Func<bool>(() => vars.ruins()       )) },
        { "chieftain",  Tuple.Create(false, "Fortress",         "Split on entering Hyranya nagri",                  new Func<bool>(() => vars.chieftain()   )) },
        { "sword",      Tuple.Create(false, "Sword",            "Split on reaching the temple in Hyranya nagri",    new Func<bool>(() => vars.sword()       )) },
        { "rangda",     Tuple.Create(false, "Hyranya Nagri",    "Split on entering mystic lands",                   new Func<bool>(() => vars.rangda()      )) },
        { "ice",        Tuple.Create(false, "Ice",              "Split on reaching Shiva and getting ice",          new Func<bool>(() => vars.ice()         )) },
        { "naga",       Tuple.Create(false, "Mystic Lands",     "Split on entering dream realm",                    new Func<bool>(() => vars.naga()        )) },
        { "dream",      Tuple.Create(false, "Dream",            "Split on entering the deser",                      new Func<bool>(() => vars.dream()       )) },
        { "desert",     Tuple.Create(true,  "Desert",           "Split on finishing the game",                      new Func<bool>(() => vars.desert()      )) },
    };

    foreach (var data in vars.splitsData) {
        settings.Add(data.Key, data.Value.Item1, data.Value.Item2);
        settings.SetToolTip(data.Key, data.Value.Item3);
    }

    vars.CompletedSplits = new HashSet<string>();

    if (timer.CurrentTimingMethod != TimingMethod.RealTime) {
        DialogResult mbox = MessageBox.Show(timer.Form,
        "This game uses only real time as the timing method.\nWould you like to switch to Real Time?",
        "LiveSplit | Raji: An Ancient Epic",
        MessageBoxButtons.YesNo);

        if (mbox == DialogResult.Yes) {
            timer.CurrentTimingMethod = TimingMethod.RealTime;
        }
    }
}

onStart
{
    vars.CompletedSplits.Clear();
}

init
{
    vars.inpos = (Func <float, float, float, bool>)((xTarg, yTarg, zTarg) => {
        return (
            current.xPos >= xTarg - 200 && current.xPos <= xTarg + 200 &&
            current.yPos >= yTarg - 200 && current.yPos <= yTarg + 200 &&
            current.zPos >= zTarg - 200 && current.zPos <= zTarg + 200
        );
    });

    vars.caves = (Func <bool>)(() => { return vars.inpos(-3258f, 5099f, -1507f); });
    vars.ruins = (Func <bool>)(() => { return vars.inpos(-24900f, -12502f, 4834f); });
    vars.bow = (Func <bool>)(() => { return vars.inpos(8954f, -333f, 479f); });
    vars.chieftain = (Func <bool>)(() => { return vars.inpos(10299f, 36051f, 8535f); });
    vars.sword = (Func <bool>)(() => { return vars.inpos(41825f, 32405f, 6328f); });
    vars.rangda = (Func <bool>)(() => { return vars.inpos(-146f, -2045f, 828f); });
    vars.ice = (Func <bool>)(() => { return vars.inpos(-21338f, 23438f, -9287f); });
    vars.naga = (Func <bool>)(() => { return vars.inpos(16939f, -822f, -12019f); });
    vars.dream = (Func <bool>)(() => { return vars.inpos(15816f, -42723f, 764f); });
    vars.desert = (Func <bool>)(() => { return vars.inpos(5818f, 78849f, -1007f); });

    vars.CheckSplit = (Func<string, bool>)(key => {
        return (vars.CompletedSplits.Add(key) && settings[key]);
    });
}

split
{
    foreach (var data in vars.splitsData) {
        if (data.Value.Item4() && vars.CheckSplit(data.Key)) {
            print(data.Key);
            return true;
        }
    }
}
