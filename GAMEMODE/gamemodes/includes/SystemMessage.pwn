enum SM_Type{
	sm_info,
	sm_error
}
#define sm_admin MAX_PLAYERS+1
stock SM(playerid, SM_Type:type, const message[], OPEN_MP_TAGS:...){
	if(playerid == sm_admin){
		foreach(new i:Player){
			if(IsPlayerAdmin(i)){
				switch(type){
					case sm_info:return SendClientMessage(i, -1, va_return("{f2ed5c}[!] {ffffff}%s", message), ___(3));
					case sm_error:return SendClientMessage(i, -1, va_return("{f74c43}[-] {ffffff}%s", message), ___(3));
				}
			}
		}
		return 1;
	}
	switch(type){
		case sm_info:return SendClientMessage(playerid, -1, va_return("{f2ed5c}[!] {ffffff}%s", message), ___(3));
		case sm_error:return SendClientMessage(playerid, -1, va_return("{f74c43}[-] {ffffff}%s", message), ___(3));
	}
	return 1;
}