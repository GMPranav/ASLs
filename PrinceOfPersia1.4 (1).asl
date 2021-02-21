state("dosbox-x")
{
    byte MinutesLeft    : "dosbox-x.exe", 0xD640D8, 0x24B30;          // Minutes
    short FrameSeconds  : "dosbox-x.exe", 0xD640D8, 0x24B36;          // Frames in second part of time (720-0)
}

gameTime
{
    int minutesLeft = current.MinutesLeft - 1;
    int totalFramesLeft = (minutesLeft * 720) + current.FrameSeconds;
    int adjustedFramesLeft = (minutesLeft < 0) ? 0 : totalFramesLeft; //time has expired
    int elapsedFrames = 60*720 - adjustedFramesLeft;	
    double secondsElapsed = elapsedFrames / 12.0;
    //print("POPASL[gameTime]: secondsElapsed = " + secondsElapsed);
    return TimeSpan.FromSeconds(secondsElapsed);
}

isLoading
{
    return true;
}

start {}

split {}