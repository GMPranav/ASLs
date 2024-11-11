state("Game Inside a Game") { }

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Game Inside a Game";
    vars.Helper.LoadSceneManager = true;
    vars.CompletedLevels = new HashSet<int>();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var LB = mono["LevelBuilder"];
        vars.Helper["level"] = LB.Make<int>(
            "curLevelNum"
        );

        var SM = mono["SensorMonitor"];
        vars.Helper["levelWon"] = SM.Make<bool>(
            "Instance",
            "conditionsMet"
        );

        return true;
    });

    current.activeScene = "";
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? current.activeScene;
}

start
{
    return old.activeScene == "Title" && current.activeScene == "Game";
}

onStart
{
    vars.CompletedLevels.Clear();
}

split
{
    return !old.levelWon && current.levelWon && vars.CompletedLevels.Add(current.level);
}
