state("Raji-Win64-Shipping", "v1")
{
    float xPos          : "fmodstudio.dll", 0x1495C0, 0xE0;
    float yPos          : "fmodstudio.dll", 0x1495C0, 0xD8;
    float zPos          : "fmodstudio.dll", 0x1495C0, 0xDC;
}

state("Raji-Win64-Shipping", "EE")
{
    float xPos          : "fmod.dll", 0x001ACCC0, 0x1A0, 0x1C8, 0x60, 0xF0, 0x30, 0x900;
    float yPos          : "fmod.dll", 0x001ACCC0, 0x1A0, 0x1C8, 0x60, 0xF0, 0x30, 0x904;
    float zPos          : "fmod.dll", 0x001ACCC0, 0x1A0, 0x1C8, 0x60, 0xF0, 0x30, 0x908;
}

init
{
    //this function will take 3 float values for x, y and z of target split location and 1 integer for half-size of range as input and check if X,Y and Z co-ordinates within the range of the target:
    vars.inpos = (Func <dynamic, float, float, float, bool>)((currentState, xTarg, yTarg, zTarg) => {
        return (
            currentState.xPos >= xTarg - 2 && currentState.xPos <= xTarg + 2 &&
            currentState.yPos >= yTarg - 2 && currentState.yPos <= yTarg + 2 &&
            currentState.zPos >= zTarg - 2 && currentState.zPos <= zTarg + 2
        );
    });

    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);

    switch (MD5Hash) {
        case "24027F44F75F9F49A79CF4578385384B": version = "v1"; break;   // DRM Removal Update
        case "6B139B92F4A6B02199AEBE625776CF54":                          // Enhanced Edition
        default: version = "EE"; break;
    }
}

split
{
    bool caves = vars.inpos(current, -32.58f, 50.99f, -15.07f);
    bool ruins = vars.inpos(current, -249f, -125.02f, 48.34f);
    bool bow = vars.inpos(current, 89.54f, -3.33f, 4.79f);
    bool chieftain = vars.inpos(current, 102.99f, 360.51f, 85.35f);
    bool sword = vars.inpos(current, 418.25f, 324.05f, 63.28f);
    bool rangda = vars.inpos(current, -1.46f, -20.45f, 8.28f);
    bool ice = vars.inpos(current, -213.38f, 234.38f, -92.87f);
    bool naga = vars.inpos(current, 169.39f, -8.22f, -120.19f);
    bool dream = vars.inpos(current, 158.16f, -427.23f, 7.64f);
    bool desert = vars.inpos(current, 58.18f, 788.49f, -10.07f);
    
    switch(timer.Run.GetExtendedCategoryName())
    {
        case "Any% (Standard)":
            switch (timer.CurrentSplitIndex) {
                case 0: return ruins;
                case 1: return chieftain;
                case 2: return rangda;
                case 3: return naga;
                case 4: return dream;
                case 5: return desert;
            }
            break;
        
        case "Any% (No Major Glitches)":
            switch (timer.CurrentSplitIndex) {
                case 0: return caves;
                case 1: return ruins;
                case 2: return bow;
                case 3: return chieftain;
                case 4: return sword;
                case 5: return rangda;
                case 6: return ice;
                case 7: return naga;
                case 8: return dream;
                case 9: return desert;
            }
            break;
    }
}
