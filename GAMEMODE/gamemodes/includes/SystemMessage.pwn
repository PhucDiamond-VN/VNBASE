enum SM_Type{
	sm_info,
	sm_error
}
stock SM(playerid, SM_Type:type, const message[], ...){
	switch(type){
		case sm_info:return SendClientMessage(playerid, -1, va_return("{f2ed5c}[!] {ffffff}%s", message), ___(3));
		case sm_error:return SendClientMessage(playerid, -1, va_return("{f74c43}[-] {ffffff}%s", message), ___(3));
	}
	return 1;
}