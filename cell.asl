state("Cell Machine") { }

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Cell Machine";
    vars.Helper.LoadSceneManager = true;
    vars.CompletedLevels = new HashSet<int>();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var GD = mono["GameData"];
        vars.Helper["level"] = GD.Make<int>(
            "level"
        );

        var GM = mono["GridManager"];
        vars.Helper["levelWon"] = GM.Make<bool>(
            "instance",
            "levelWon"
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
