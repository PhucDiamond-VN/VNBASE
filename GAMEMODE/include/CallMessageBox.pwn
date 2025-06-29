stock MessageBox(playerid, const title[], const content[], exittimer = 0, bool:exitbutton = false, const func[] = ""){
	// exittimer là giây
	return CallRemoteFunction("MessageBox", "dssdbs", playerid, title, content, exittimer, exitbutton, func);
}
stock ExitMessageBox(playerid){
	return CallRemoteFunction("ExitMessageBox", "d", playerid);
}