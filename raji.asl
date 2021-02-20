state("Raji-Win64-Shipping")
{
    float xPos          : "fmodstudio.dll", 0x1495C0, 0xE0;
    float yPos          : "fmodstudio.dll", 0x1495C0, 0xD8;
    float zPos          : "fmodstudio.dll", 0x1495C0, 0xDC;
}

init
{
	//this function will take 3 float values for x,y and z of target split location and 1 integer for half-size of range as input and check if X,Y and Z co-ordinates within the range of the target:
	vars.inpos = (Func <float, float, float, bool>)((xTarg, yTarg, zTarg) => {
		return
			current.xPos >= xTarg - 2 && current.xPos <= xTarg + 2 &&
			current.yPos >= yTarg - 2 && current.yPos <= yTarg + 2 &&
			current.zPos >= zTarg - 2 && current.zPos <= zTarg + 2 ? true : false;
	});
}

split{
	// Initializing Splits:
	bool caves	= vars.inpos(-32.58f, 50.99f, -15.07f) ? true : false;
	bool ruins	= vars.inpos(-249f, -125.02f, 48.34f) ? true : false;
	bool bow	= vars.inpos(89.54f, -3.33f, 4.79f) ? true : false;
	bool fortress	= vars.inpos(102.99f, 360.51f, 85.35f) ? true : false;

	// Checking qualifications to complete each split:
	switch (timer.CurrentSplitIndex) {
		case 0: return caves;		// The Caves
		case 1: return ruins;       	// The Ruins
		case 2: return bow;		// The Works
		case 3: return fortress;	// The Fortress
	}
}