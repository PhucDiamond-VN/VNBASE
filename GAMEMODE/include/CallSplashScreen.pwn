stock SplashScreen(playerid, const content[], statee){
	return CallRemoteFunction("StartASplashScreen", "dsd", playerid, content, statee);
}