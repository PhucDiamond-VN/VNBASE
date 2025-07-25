//MapFix by Nexius v4.6.6

#if defined _mapfix_included
	#endinput
#endif

#define FILTERSCRIPT

#include <open.mp>
#include <crashdetect>

#define MAPFIX_VERSION					"4.6.6"

#define MAX_MAPFIX_OBJECTS				665

#if !defined MAPFIX_USE_STREAMER
	#define MAPFIX_USE_STREAMER			true
#endif

#if MAPFIX_USE_STREAMER
	#tryinclude <streamer>
#endif

#if MAPFIX_USE_STREAMER\
	&& defined CreateDynamicObject\
	&& defined SetDynamicObjectMaterial\
	&& defined DestroyDynamicObject
	#define mf_CreateObject(%0,%1,%2,%3,%4,%5,%6,%7) _:CreateDynamicObject(%0, %1, %2, %3, %4, %5, %6, -1, -1, -1, %7)
	#define mf_SetObjectMaterial(%0,%1,%2,%3,%4,%5) SetDynamicObjectMaterial(STREAMER_TAG_OBJECT:%0, %1, %2, %3, %4, %5)
	#define mf_DestroyObject(%0) DestroyDynamicObject(STREAMER_TAG_OBJECT:%0)
#else
	#define mf_CreateObject CreateObject
	#define mf_SetObjectMaterial SetObjectMaterial
	#define mf_DestroyObject DestroyObject
#endif

#define mf_CreateFloorObject CreateObject
#define mf_DestroyFloorObject DestroyObject

new
	MapFixObjects[MAX_MAPFIX_OBJECTS],
	MapFixIsEnabled = 1;

public OnFilterScriptInit()
{
	SetCrashDetectLongCallTime(GetConsoleVarAsInt("crashdetect.long_call_time"));
	#if defined GetSVarInt\
		&& defined SetSVarInt
		if(GetSVarInt("MapFixIsEnabled"))
		{
			print("  MapFix already included!");
			MapFixIsEnabled++;
		}
		else SetSVarInt("MapFixIsEnabled", 1);
	#endif
	if(MapFixIsEnabled < 2)
	{
		printf("  MapFix by Nexius v%s loaded (filterscript version).", MAPFIX_VERSION);
		CreateMapFixObjects();
	}
	return 1;
}

public OnFilterScriptExit()
{
	if(MapFixIsEnabled < 2)
	{
		printf("  MapFix by Nexius v%s unloaded (filterscript version).", MAPFIX_VERSION);
		DestroyMapFixObjects();
		#if defined DeleteSVar
			DeleteSVar("MapFixIsEnabled");
		#endif
	}
	return 1;
}

forward CreateMapFixObjects();
public CreateMapFixObjects()
{
	#if !defined DISABLE_MAPFIX_PLACE_1
		MapFixObjects[0] = mf_CreateObject(2904, 1277.5, 2529.6, 16.9, 0.0, 90.0, 90.0, 4.0);
		MapFixObjects[1] = mf_CreateObject(2634, 1276.4, 2532.7, 16.8, 0.0, 0.0, 128.0, 4.0);
		MapFixObjects[2] = mf_CreateObject(2634, 1276.4, 2526.5, 16.8, 0.0, 0.0, 52.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_2
		MapFixObjects[3] = mf_CreateObject(3037, 2005.9, -1592.1, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[4] = mf_CreateObject(3037, 2016.7, -1592.2, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[5] = mf_CreateObject(3037, 1996.6, -1592.0, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[6] = mf_CreateObject(3037, 1993.3, -1588.7, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[7] = mf_CreateObject(3037, 1953.0, -1558.2, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[8] = mf_CreateObject(3037, 1939.5, -1558.8, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[9] = mf_CreateObject(5066, 1935.0, -1555.1, 16.16, 0.0, 270.0, 45.0, 8.0);
		MapFixObjects[10] = mf_CreateObject(3037, 1957.7, -1590.1, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[11] = mf_CreateObject(3037, 1950.2, -1582.6, 16.13, 0.0, 270.0, 45.0, 12.0);
		MapFixObjects[12] = mf_CreateObject(3117, 1967.85, -1590.1, 16.2, 0.0, 0.0, 315.0, 6.0);
		MapFixObjects[13] = mf_CreateObject(3037, 1977.4, -1616.7, 19.4, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[14] = mf_CreateObject(3037, 1967.2, -1616.7, 19.4, 0.0, 270.0, 90.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_3
		MapFixObjects[15] = mf_CreateObject(1555, -1377.2998, 492.5, 5.6, 0.0, 0.0, 90.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_4
		MapFixObjects[16] = mf_CreateObject(3037, -653.3, -1693.5, 40.0, 345.0, 340.0, 86.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[16], 0, 0, "none", "none", 0);
		MapFixObjects[17] = mf_CreateObject(3037, -643.8, -1694.2, 43.0, 345.0, 345.0, 87.0, 12.0);
		MapFixObjects[18] = mf_CreateObject(3037, -662.7, -1693.0, 38.0, 345.0, 337.0, 85.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_5
		MapFixObjects[19] = mf_CreateObject(1566, -1406.7, 1.4, 6.5, 0.0, 0.0, 0.0, 4.0);
		MapFixObjects[20] = mf_CreateObject(1566, -1406.7, 1.4, 9.4, 0.0, 0.0, 0.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_6
		MapFixObjects[21] = mf_CreateObject(3037, 1908.5, 2222.8, 14.1, 0.0, 270.0, 0.0, 12.0);
		MapFixObjects[22] = mf_CreateObject(3037, 1908.5, 2211.9, 14.1, 0.0, 270.0, 0.0, 12.0);
		MapFixObjects[23] = mf_CreateObject(3037, 1908.5, 2201.1, 14.1, 0.0, 270.0, 0.0, 12.0);
		MapFixObjects[24] = mf_CreateObject(3037, 1843.6, 2201.1, 14.1, 0.0, 270.0, 0.0, 12.0);
		MapFixObjects[25] = mf_CreateObject(3037, 1843.6, 2211.9, 14.1, 0.0, 270.0, 0.0, 12.0);
		MapFixObjects[26] = mf_CreateObject(3037, 1843.6, 2222.8, 14.1, 0.0, 270.0, 0.0, 12.0);
		MapFixObjects[27] = mf_CreateObject(3037, 1855.3, 2234.5, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[28] = mf_CreateObject(3037, 1865.7, 2235.1, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[29] = mf_CreateObject(3037, 1876.1, 2235.1, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[30] = mf_CreateObject(3037, 1886.5, 2235.1, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[31] = mf_CreateObject(3037, 1896.9, 2234.5, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[32] = mf_CreateObject(3037, 1855.3, 2189.5, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[33] = mf_CreateObject(3037, 1865.7, 2189.5, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[34] = mf_CreateObject(3037, 1876.1, 2189.5, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[35] = mf_CreateObject(3037, 1886.5, 2189.5, 14.1, 0.0, 270.0, 90.0, 12.0);
		MapFixObjects[36] = mf_CreateObject(3037, 1896.9, 2189.5, 14.1, 0.0, 270.0, 90.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_7
		MapFixObjects[37] = mf_CreateObject(3117, 2104.2, 2367.6, 11.9, 0.0, 90.0, 90.0, 6.0);
		MapFixObjects[38] = mf_CreateObject(1566, 2115.2, 2368.8, 12.0, 0.0, 0.0, 0.0, 4.0);
		MapFixObjects[39] = mf_CreateObject(1566, 2115.2, 2367.3, 12.0, 0.0, 0.0, 90.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_8
		MapFixObjects[40] = mf_CreateObject(3084, -1613.0, 621.7, 37.0, 0.0, 2.0, 226.6, 17.0);
		mf_SetObjectMaterial(MapFixObjects[40], 0, 0, "none", "none", 0);
		MapFixObjects[41] = mf_CreateObject(3084, -1604.5, 630.7, 37.3, 0.0, 2.0, 226.6, 17.0);
		mf_SetObjectMaterial(MapFixObjects[41], 0, 0, "none", "none", 0);
		MapFixObjects[42] = mf_CreateObject(3084, -1596.0, 639.7, 37.7, 0.0, 2.0, 226.6, 17.0);
		mf_SetObjectMaterial(MapFixObjects[42], 0, 0, "none", "none", 0);
		MapFixObjects[43] = mf_CreateObject(3084, -1587.5, 648.7, 38.1, 0.0, 2.0, 226.6, 17.0);
		mf_SetObjectMaterial(MapFixObjects[43], 0, 0, "none", "none", 0);
		MapFixObjects[44] = mf_CreateObject(3084, -1579.7, 656.9, 38.5, 0.0, 2.0, 226.6, 17.0);
		mf_SetObjectMaterial(MapFixObjects[44], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_9
		MapFixObjects[45] = mf_CreateObject(10558, -1955.0, 745.9, 49.0, 90.0, 90.0, 90.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_10
		MapFixObjects[46] = mf_CreateObject(8957, -2060.3, 474.3, 36.0, 0.0, 0.0, 270.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_11
		MapFixObjects[47] = mf_CreateObject(2957, 396.7, -2058.6, 9.9, 270.0, 0.0, 0.0, 6.0);
		MapFixObjects[48] = mf_CreateObject(3055, 391.4, -2054.5, 9.8, 270.0, 180.0, 180.0, 10.0);
		MapFixObjects[49] = mf_CreateObject(3055, 391.4, -2052.7, 9.8, 270.0, 180.0, 180.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_12
		MapFixObjects[50] = mf_CreateObject(2904, 2181.7, -2218.2, 15.5, 0.0, 0.0, 45.0, 4.0);
		MapFixObjects[51] = mf_CreateObject(2904, 2188.9, -2210.9, 15.5, 0.0, 0.0, 45.0, 4.0);
		MapFixObjects[52] = mf_CreateObject(2904, 2196.5, -2203.7, 15.5, 0.0, 0.0, 45.0, 4.0);
		MapFixObjects[53] = mf_CreateObject(2904, 2203.8, -2197.2, 15.5, 0.0, 0.0, 45.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_13
		MapFixObjects[54] = mf_CreateObject(10558, 1038.2, -1383.0, 17.07, 0.0, 90.0, 90.0, 10.0);
		MapFixObjects[55] = mf_CreateObject(3117, 1041.95, -1383.0, 17.2, 0.0, 0.0, 315.0, 8.0);
		MapFixObjects[56] = mf_CreateObject(3117, 1042.9, -1381.9, 17.2, 0.0, 0.0, 90.0, 8.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_14
		MapFixObjects[57] = mf_CreateObject(3084, 501.0, -1364.9, 20.3, 270.0, 0.0, 107.0, 14.0);
		MapFixObjects[58] = mf_CreateObject(3037, 503.5, -1375.0, 20.3, 0.0, 270.0, 17.0, 12.0);
		MapFixObjects[59] = mf_CreateObject(3037, 496.4, -1362.4, 20.3, 0.0, 270.0, 115.0, 12.0);
		MapFixObjects[60] = mf_CreateObject(3084, 507.4, -1386.0, 19.3, 270.0, 180.0, 285.0, 14.0);
		MapFixObjects[61] = mf_CreateObject(3084, 510.6, -1397.9, 19.3, 270.0, 180.0, 285.0, 14.0);
		MapFixObjects[62] = mf_CreateObject(3084, 507.6, -1404.7, 19.3, 270.0, 0.0, 194.5, 14.0);
		MapFixObjects[63] = mf_CreateObject(3055, 498.9, -1406.3, 19.3, 270.0, 0.0, 14.5, 10.0);
		MapFixObjects[64] = mf_CreateObject(3055, 481.4, -1412.1, 20.5, 270.0, 0.0, 20.5, 15.0);
		mf_SetObjectMaterial(MapFixObjects[64], 0, 0, "none", "none", 0);
		MapFixObjects[65] = mf_CreateObject(3109, 484.8, -1413.2, 19.3, 0.0, 90.0, 20.5, 12.0);
		mf_SetObjectMaterial(MapFixObjects[65], 0, 0, "none", "none", 0);
		MapFixObjects[66] = mf_CreateObject(3109, 479.6, -1415.2, 19.3, 0.0, 90.0, 20.5, 12.0);
		mf_SetObjectMaterial(MapFixObjects[66], 0, 0, "none", "none", 0);
		MapFixObjects[67] = mf_CreateObject(3037, 471.0, -1417.1, 24.6, 0.0, 90.0, 300.5, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_15
		MapFixObjects[68] = mf_CreateObject(5066, -1540.2, -444.9, 6.7, 0.0, 0.0, 315.0, 14.0);
		mf_SetObjectMaterial(MapFixObjects[68], 0, 0, "none", "none", 0);
		mf_SetObjectMaterial(MapFixObjects[68], 1, 0, "none", "none", 0);
		MapFixObjects[69] = mf_CreateObject(10150, -1539.4, -440.9, 6.5, 0.0, 0.0, 45.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[69], 0, 0, "none", "none", 0);
		MapFixObjects[70] = mf_CreateObject(10150, -1544.4, -445.8, 6.5, 0.0, 0.0, 45.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[70], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_16
		MapFixObjects[71] = mf_CreateObject(5066, -1230.8, 51.1, 14.7, 0.0, 0.0, 45.0, 14.0);
		mf_SetObjectMaterial(MapFixObjects[71], 0, 0, "none", "none", 0);
		mf_SetObjectMaterial(MapFixObjects[71], 1, 0, "none", "none", 0);
		MapFixObjects[72] = mf_CreateObject(10150, -1226.8, 50.3, 14.5, 0.0, 0.0, 315.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[72], 0, 0, "none", "none", 0);
		MapFixObjects[73] = mf_CreateObject(10150, -1231.7, 55.1, 14.5, 0.0, 0.0, 315.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[73], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_17
		MapFixObjects[74] = mf_CreateObject(8957, 2781.0, -1358.6, 27.5, 0.0, 0.0, 0.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[74], 0, 0, "none", "none", 0);
		MapFixObjects[75] = mf_CreateObject(8957, 2781.0, -1333.3, 33.0, 0.0, 0.0, 0.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[75], 0, 0, "none", "none", 0);
		MapFixObjects[76] = mf_CreateObject(8957, 2781.2, -1306.4, 39.5, 0.0, 0.0, 0.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[76], 0, 0, "none", "none", 0);
		MapFixObjects[77] = mf_CreateObject(8957, 2781.2, -1281.3, 45.5, 0.0, 0.0, 0.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[77], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_18
		MapFixObjects[78] = mf_CreateObject(3117, -2240.7, 80.5, 37.0, 0.0, 270.0, 45.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_19
		MapFixObjects[79] = mf_CreateObject(1566, -180.7, 1129.48, 20.8, 0.0, 0.0, 0.0, 4.0);
		MapFixObjects[80] = mf_CreateObject(3061, -180.7, 1128.4, 20.5, 0.0, 0.0, 0.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_20
		MapFixObjects[81] = mf_CreateObject(5846, 1547.4, 885.1, 7.88, 7.5, 90.0, 70.0, 24.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_21
		MapFixObjects[82] = mf_CreateObject(5846, -1883.4, 1436.6, -33.7, 357.5, 90.0, 60.0, 24.0);
		mf_SetObjectMaterial(MapFixObjects[82], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_22
		MapFixObjects[83] = mf_CreateObject(8957, 1771.9, 2166.1, 6.0, 0.0, 0.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_23
		MapFixObjects[84] = mf_CreateObject(7930, 839.69, -1062.65, 32.57, 0.0, 90.0, 35.0, 10.0);
		MapFixObjects[85] = mf_CreateObject(1965, 835.25, -1058.65, 32.66, 0.0, 90.0, 298.25, 4.0);
		MapFixObjects[86] = mf_CreateObject(3109, 834.67, -1056.3, 32.63, 0.0, 90.0, 264.0, 4.0);
		MapFixObjects[87] = mf_CreateObject(3109, 835.1, -1054.7, 32.63, 0.0, 90.0, 247.0, 4.0);
		MapFixObjects[88] = mf_CreateObject(1965, 836.8, -1052.6, 32.66, 0.0, 90.0, 219.5, 4.0);
		MapFixObjects[89] = mf_CreateObject(8957, 850.9, -1057.5, 29.2, 0.0, 90.0, 305.0, 10.0);
		MapFixObjects[90] = mf_CreateObject(10184, 847.4, -1048.1, 29.0, 0.0, 90.0, 305.0, 18.0);
		MapFixObjects[91] = mf_CreateObject(10184, 857.0, -1041.4, 29.0, 0.0, 90.0, 305.0, 18.0);
		MapFixObjects[92] = mf_CreateObject(2957, 854.8, -1039.7, 29.4, 90.0, 90.0, 35.5, 6.0);
		MapFixObjects[93] = mf_CreateObject(1966, 861.0, -1036.9, 35.9, 90.0, 0.0, 35.0, 10.0);
		MapFixObjects[94] = mf_CreateObject(1966, 864.1, -1038.4, 35.9, 90.0, 90.0, 35.0, 10.0);
		MapFixObjects[95] = mf_CreateObject(1965, 862.7, -1034.4, 35.9, 0.0, 90.0, 305.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_24
		MapFixObjects[96] = mf_CreateObject(3117, 689.6, -1424.4, 19.8, 0.0, 90.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_25
		MapFixObjects[97] = mf_CreateFloorObject(8957, 681.4, -447.4, -26.7, 0.0, 270.0, 0.0, 10.0);
		MapFixObjects[98] = mf_CreateObject(8957, 680.35, -447.1, -25.0, 0.0, 0.0, 0.0, 10.0);
		MapFixObjects[99] = mf_CreateObject(8957, 682.7, -447.1, -25.0, 0.0, 0.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_26
		MapFixObjects[100] = mf_CreateObject(2904, 2344.1, 377.5, 25.568, 84.0, 0.0, 354.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[100], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_27
		MapFixObjects[101] = mf_CreateObject(3084, 1077.8, 1394.7, 6.4, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[102] = mf_CreateObject(3084, 1078.6, 1404.4, 3.2, 0.0, 38.0, 90.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_28
		MapFixObjects[103] = mf_CreateObject(8957, 2399.1, 2166.2, 13.4, 0.0, 270.0, 90.0, 10.0);
		MapFixObjects[104] = mf_CreateObject(8957, 2416.0, 2166.2, 13.4, 0.0, 270.0, 90.0, 10.0);
		MapFixObjects[105] = mf_CreateObject(8957, 2441.2, 2166.2, 13.4, 0.0, 270.0, 90.0, 10.0);
		MapFixObjects[106] = mf_CreateObject(8957, 2449.6, 2166.2, 13.4, 0.0, 270.0, 90.0, 10.0);
		MapFixObjects[107] = mf_CreateObject(8957, 2474.9, 2166.2, 13.4, 0.0, 270.0, 90.0, 10.0);
		MapFixObjects[108] = mf_CreateObject(8957, 2491.7, 2166.2, 13.4, 0.0, 270.0, 90.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_29
		MapFixObjects[109] = mf_CreateObject(3117, 2275.1, 2351.4, 18.67, 0.0, 0.0, 45.0, 8.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_30
		MapFixObjects[110] = mf_CreateObject(2954, 539.85, 50.05, 21.6, 0.0, 0.0, 100.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[110], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_31
		MapFixObjects[111] = mf_CreateObject(5846, -2438.7, -1398.1, 338.95, 356.0, 252.0, 304.0, 24.0);
		MapFixObjects[112] = mf_CreateObject(5846, -2455.8, -1405.6, 342.2, 353.0, 249.0, 304.0, 24.0);
		MapFixObjects[113] = mf_CreateObject(8957, -2470.0, -1406.9, 345.5, 15.0, 115.0, 118.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_32
		MapFixObjects[114] = mf_CreateObject(3117, 1076.9, 1362.25, 12.3, 0.0, 90.0, 95.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_33
		MapFixObjects[115] = mf_CreateObject(3084, 2356.5, 1881.5, 14.1, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[116] = mf_CreateObject(3084, 2344.0, 1881.5, 14.1, 90.0, 0.0, 0.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_34
		MapFixObjects[117] = mf_CreateObject(10558, -2187.4, 715.9, 78.6, 0.0, 90.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_35
		MapFixObjects[118] = mf_CreateObject(8957, 2862.1, -1406.1, 16.2, 0.0, 88.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_36
		MapFixObjects[119] = mf_CreateObject(3117, 2823.5, -1597.4, 12.7, 0.0, 0.0, 68.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[119], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_37
		MapFixObjects[120] = mf_CreateObject(2938, 2863.7, -1439.5, 15.0, 0.0, 90.0, 0.0, 14.0);
		MapFixObjects[121] = mf_CreateObject(3117, 2864.2, -1446.2, 15.1, 0.0, 0.0, 50.0, 6.0);
		MapFixObjects[122] = mf_CreateObject(3117, 2864.1, -1432.6, 15.1, 0.0, 0.0, 132.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_38
		MapFixObjects[123] = mf_CreateObject(8957, 1003.8, -919.5, 45.5, 0.0, 90.0, 8.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_39
		MapFixObjects[124] = mf_CreateObject(3084, -2904.4, 1247.8, 5.75, 0.0, 0.0, 45.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[124], 0, 0, "none", "none", 0);
		MapFixObjects[125] = mf_CreateObject(3084, -2860.1, 1256.8, 5.7, 0.0, 0.0, 45.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[125], 0, 0, "none", "none", 0);
		MapFixObjects[126] = mf_CreateObject(3084, -2852.3, 1264.6, 5.7, 0.0, 0.0, 45.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[126], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_40
		MapFixObjects[127] = mf_CreateObject(3084, 966.3, -1038.8, 28.9, 270.0, 0.0, 90.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_41
		MapFixObjects[128] = mf_CreateObject(3084, 2403.5, 2661.2, 9.0, 296.0, 0.0, 354.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_42 //by Hare
		MapFixObjects[129] = mf_CreateObject(983, 1199.3, -917.8, 45.3, 0.0, 90.0, 98.0, 8.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_43
		MapFixObjects[130] = mf_CreateObject(3037, 428.1, -1641.33, 43.5, 90.0, 0.0, 311.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_44
		MapFixObjects[131] = mf_CreateObject(8957, 1301.9, -966.1, 36.2, 0.0, 0.0, 90.0, 10.0);
		MapFixObjects[132] = mf_CreateObject(3037, 1298.3, -1001.0, 35.1, 0.0, 0.0, 0.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_45
		MapFixObjects[133] = mf_CreateObject(3117, 2504.6, 1144.86, 18.5, 0.0, 90.0, 90.0, 6.0);
		MapFixObjects[134] = mf_CreateObject(3117, 2508.9, 1144.86, 18.5, 0.0, 90.0, 90.0, 6.0);
		MapFixObjects[135] = mf_CreateObject(3117, 2513.1, 1144.86, 18.5, 0.0, 90.0, 90.0, 6.0);
		MapFixObjects[136] = mf_CreateObject(3117, 2515.73, 1146.4, 18.5, 0.0, 90.0, 0.0, 6.0);
		MapFixObjects[137] = mf_CreateObject(3117, 2515.73, 1152.5, 18.5, 0.0, 90.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_46
		MapFixObjects[138] = mf_CreateObject(3084, -1869.2, -162.8, 16.6, 90.0, 0.0, 86.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_47
		MapFixObjects[139] = mf_CreateObject(3117, 1623.63, -1714.5, 25.1, 0.0, 0.0, 96.0, 8.0);
		MapFixObjects[140] = mf_CreateObject(3117, 1584.8, -1717.85, 25.1, 0.0, 0.0, 96.0, 8.0);
		MapFixObjects[141] = mf_CreateObject(3117, 1587.0, -1743.67, 25.1, 0.0, 0.0, 95.0, 8.0);
		MapFixObjects[142] = mf_CreateObject(3117, 1625.6, -1740.3, 25.1, 0.0, 0.0, 95.0, 8.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_48
		MapFixObjects[143] = mf_CreateObject(3084, -1919.1, 699.6, 74.3, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[144] = mf_CreateObject(3117, -1913.3, 699.1, 74.3, 0.0, 180.0, 99.0, 6.0);
		MapFixObjects[145] = mf_CreateObject(3084, -1931.7, 699.6, 74.3, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[146] = mf_CreateObject(3117, -1939.2, 699.6, 74.3, 0.0, 180.0, 90.0, 6.0);
		MapFixObjects[147] = mf_CreateObject(3084, -1951.7, 699.5, 74.3, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[148] = mf_CreateObject(8957, -1940.7, 697.5, 71.8, 68.0, 0.0, 0.0, 10.0);
		MapFixObjects[149] = mf_CreateObject(8957, -1946.7, 697.5, 71.8, 68.0, 0.0, 0.0, 10.0);
		MapFixObjects[150] = mf_CreateObject(8957, -1943.8, 700.0, 70.3, 68.0, 90.0, 0.0, 10.0);
		MapFixObjects[151] = mf_CreateObject(8957, -1956.6, 697.5, 71.8, 68.0, 0.0, 0.0, 10.0);
		MapFixObjects[152] = mf_CreateObject(8957, -1962.6, 697.5, 71.8, 68.0, 0.0, 0.0, 10.0);
		MapFixObjects[153] = mf_CreateObject(8957, -1959.6, 700.0, 70.3, 68.0, 90.0, 0.0, 10.0);
		MapFixObjects[154] = mf_CreateObject(3084, -1984.3, 699.6, 74.3, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[155] = mf_CreateObject(3084, -1971.6, 699.6, 74.3, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[156] = mf_CreateObject(3117, -1964.1, 699.6, 74.3, 0.0, 180.0, 90.0, 6.0);
		MapFixObjects[157] = mf_CreateObject(3117, -1990.1, 699.1, 74.3, 0.0, 180.0, 82.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_49
		MapFixObjects[158] = mf_CreateObject(8957, -2456.6, 763.4, 43.0, 29.0, 0.0, 0.0, 10.0);
		MapFixObjects[159] = mf_CreateObject(8957, -2456.6, 772.0, 42.8, 44.0, 0.0, 0.0, 10.0);
		MapFixObjects[160] = mf_CreateObject(8957, -2399.3, 764.1, 38.6, 42.0, 0.0, 0.0, 10.0);
		MapFixObjects[161] = mf_CreateObject(8957, -2399.3, 768.6, 38.4, 56.0, 0.0, 0.0, 10.0);
		MapFixObjects[162] = mf_CreateObject(8957, -2486.0, 764.0, 38.6, 41.0, 0.0, 0.0, 10.0);
		MapFixObjects[163] = mf_CreateObject(8957, -2486.0, 768.6, 38.6, 56.0, 0.0, 0.0, 10.0);
		MapFixObjects[164] = mf_CreateObject(8957, -2413.5, 761.7, 38.5, 0.0, 90.0, 90.0, 10.0);
		MapFixObjects[165] = mf_CreateObject(3117, -2470.7, 759.0, 41.2, 298.0, 90.0, 90.0, 6.0);
		MapFixObjects[166] = mf_CreateObject(3117, -2472.8, 759.0, 41.2, 298.0, 90.0, 270.0, 6.0);
		MapFixObjects[167] = mf_CreateObject(3117, -2410.8, 759.0, 40.2, 298.0, 90.0, 90.0, 6.0);
		MapFixObjects[168] = mf_CreateObject(3117, -2416.5, 759.0, 40.2, 298.0, 90.0, 270.0, 6.0);
		MapFixObjects[169] = mf_CreateObject(3117, -2412.5, 759.0, 41.2, 298.0, 90.0, 90.0, 6.0);
		MapFixObjects[170] = mf_CreateObject(3117, -2414.7, 759.0, 41.2, 298.0, 90.0, 270.0, 6.0);
		MapFixObjects[171] = mf_CreateObject(3117, -2413.7, 759.0, 39.5, 90.0, 90.0, 270.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_50
		MapFixObjects[172] = mf_CreateObject(3109, -1650.4, 537.3, 37.9, 0.0, 0.0, 46.0, 4.0);
		MapFixObjects[173] = mf_CreateObject(3109, -1674.3, 560.0, 37.9, 0.0, 0.0, 46.0, 4.0);
		MapFixObjects[174] = mf_CreateObject(9583, -1651.2, 537.6, 38.6, 0.0, 82.0, 46.5, 24.0);
		mf_SetObjectMaterial(MapFixObjects[174], 0, 0, "none", "none", 0);
		MapFixObjects[175] = mf_CreateObject(9583, -1674.7, 560.65, 38.6, 0.0, 82.0, 46.5, 24.0);
		mf_SetObjectMaterial(MapFixObjects[175], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_51
		MapFixObjects[176] = mf_CreateObject(17540, 2735.7, -1267.8, 62.9, 0.0, 0.0, 90.0, 36.0);
		mf_SetObjectMaterial(MapFixObjects[176], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_52
		MapFixObjects[177] = mf_CreateObject(8957, -755.95, -1848.4, 14.3, 5.0, 335.0, 349.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[177], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_53
		MapFixObjects[178] = mf_CreateObject(906, -609.8, -1899.4, 3.5, 0.0, 10.0, 156.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[178], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_54
		MapFixObjects[179] = mf_CreateObject(2957, -405.0, 2242.8, 44.0, 0.0, 34.0, 285.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[179], 0, 0, "none", "none", 0);
		MapFixObjects[180] = mf_CreateObject(2957, -405.4, 2244.5, 44.0, 0.0, 326.0, 285.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_55
		MapFixObjects[181] = mf_CreateObject(1965, -1119.3, 852.2, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[181], 0, 0, "none", "none", 0);
		MapFixObjects[182] = mf_CreateObject(1965, -1121.03, 854.6, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[182], 0, 0, "none", "none", 0);
		MapFixObjects[183] = mf_CreateObject(1965, -1121.95, 855.9, 31.1, 0.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[183], 0, 0, "none", "none", 0);
		MapFixObjects[184] = mf_CreateObject(1965, -1131.0, 868.3, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[184], 0, 0, "none", "none", 0);
		MapFixObjects[185] = mf_CreateObject(1965, -1129.24, 865.87, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[185], 0, 0, "none", "none", 0);
		MapFixObjects[186] = mf_CreateObject(1965, -1128.3, 864.58, 31.1, 0.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[186], 0, 0, "none", "none", 0);
		MapFixObjects[187] = mf_CreateObject(1965, -1134.4, 841.1, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[187], 0, 0, "none", "none", 0);
		MapFixObjects[188] = mf_CreateObject(1965, -1136.17, 843.53, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[188], 0, 0, "none", "none", 0);
		MapFixObjects[189] = mf_CreateObject(1965, -1136.5, 845.2, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[189], 0, 0, "none", "none", 0);
		MapFixObjects[190] = mf_CreateObject(1965, -1146.15, 857.3, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[190], 0, 0, "none", "none", 0);
		MapFixObjects[191] = mf_CreateObject(1965, -1144.38, 854.87, 30.5, 0.0, 90.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[191], 0, 0, "none", "none", 0);
		MapFixObjects[192] = mf_CreateObject(1965, -1142.8, 854.0, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[192], 0, 0, "none", "none", 0);
		MapFixObjects[193] = mf_CreateObject(1965, -1075.0, 889.9, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[193], 0, 0, "none", "none", 0);
		MapFixObjects[194] = mf_CreateObject(1965, -1081.3, 898.7, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[194], 0, 0, "none", "none", 0);
		MapFixObjects[195] = mf_CreateObject(1965, -1102.2, 870.1, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[195], 0, 0, "none", "none", 0);
		MapFixObjects[196] = mf_CreateObject(1965, -1108.6, 878.8, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[196], 0, 0, "none", "none", 0);
		MapFixObjects[197] = mf_CreateObject(1965, -1155.6, 831.3, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[197], 0, 0, "none", "none", 0);
		MapFixObjects[198] = mf_CreateObject(1965, -1162.0, 840.0, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[198], 0, 0, "none", "none", 0);
		MapFixObjects[199] = mf_CreateObject(1965, -1183.0, 811.4, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[199], 0, 0, "none", "none", 0);
		MapFixObjects[200] = mf_CreateObject(1965, -1189.3, 820.2, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[200], 0, 0, "none", "none", 0);
		MapFixObjects[201] = mf_CreateObject(1965, -1328.3, 705.8, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[201], 0, 0, "none", "none", 0);
		MapFixObjects[202] = mf_CreateObject(1965, -1334.6, 714.6, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[202], 0, 0, "none", "none", 0);
		MapFixObjects[203] = mf_CreateObject(1965, -1355.6, 686.0, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[203], 0, 0, "none", "none", 0);
		MapFixObjects[204] = mf_CreateObject(1965, -1362.0, 694.7, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[204], 0, 0, "none", "none", 0);
		MapFixObjects[205] = mf_CreateObject(1965, -1374.9, 672.0, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[205], 0, 0, "none", "none", 0);
		MapFixObjects[206] = mf_CreateObject(1965, -1381.3, 680.7, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[206], 0, 0, "none", "none", 0);
		MapFixObjects[207] = mf_CreateObject(1965, -1390.1, 660.9, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[207], 0, 0, "none", "none", 0);
		MapFixObjects[208] = mf_CreateObject(1965, -1396.4, 669.7, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[208], 0, 0, "none", "none", 0);
		MapFixObjects[209] = mf_CreateObject(1965, -1409.3, 647.0, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[209], 0, 0, "none", "none", 0);
		MapFixObjects[210] = mf_CreateObject(1965, -1415.8, 655.7, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[210], 0, 0, "none", "none", 0);
		MapFixObjects[211] = mf_CreateObject(1965, -1436.8, 627.0, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[211], 0, 0, "none", "none", 0);
		MapFixObjects[212] = mf_CreateObject(1965, -1443.1, 635.8, 31.1, 90.0, 0.0, 306.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[212], 0, 0, "none", "none", 0);
		MapFixObjects[213] = mf_CreateObject(3037, -1440.6, 630.9, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[213], 0, 0, "none", "none", 0);
		MapFixObjects[214] = mf_CreateObject(3037, -1413.1, 650.9, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[214], 0, 0, "none", "none", 0);
		MapFixObjects[215] = mf_CreateObject(3037, -1358.3, 690.7, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[215], 0, 0, "none", "none", 0);
		MapFixObjects[216] = mf_CreateObject(3037, -1330.8, 710.7, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[216], 0, 0, "none", "none", 0);
		MapFixObjects[217] = mf_CreateObject(3037, -1186.9, 815.3, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[217], 0, 0, "none", "none", 0);
		MapFixObjects[218] = mf_CreateObject(3037, -1159.4, 835.2, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[218], 0, 0, "none", "none", 0);
		MapFixObjects[219] = mf_CreateObject(3037, -1104.7, 875.0, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[219], 0, 0, "none", "none", 0);
		MapFixObjects[220] = mf_CreateObject(3037, -1077.2, 895.0, 30.73, 0.0, 90.0, 36.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[220], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_56
		MapFixObjects[221] = mf_CreateObject(8957, 1725.6, 2122.3, 13.1, 0.0, 0.0, 90.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_57
		MapFixObjects[222] = mf_CreateObject(3084, 1682.3, 1379.8, 16.1, 0.0, 0.0, 299.0, 14.0);
		MapFixObjects[223] = mf_CreateObject(3084, 1672.8, 1396.5, 16.1, 0.0, 0.0, 300.5, 14.0);
		MapFixObjects[224] = mf_CreateObject(8957, 1677.5, 1388.2, 14.8, 0.0, 0.0, 30.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_58
		MapFixObjects[225] = mf_CreateObject(2904, 2143.0, 1621.3, 1001.9, 0.0, 0.0, 0.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[225], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_59
		MapFixObjects[226] = mf_CreateObject(3117, 1175.7, 1224.0, 13.5, 0.0, 90.0, 90.0, 6.0);
		MapFixObjects[227] = mf_CreateObject(2954, 1174.8, 1224.18, 13.2, 0.0, 0.0, 0.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[227], 0, 0, "none", "none", 0);
		MapFixObjects[228] = mf_CreateObject(2954, 1174.7, 1224.18, 15.2, 0.0, 90.0, 0.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[228], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_60
		MapFixObjects[229] = mf_CreateObject(8957, -208.3, 1055.7, 22.8, 0.0, 90.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_61
		MapFixObjects[230] = mf_CreateObject(5846, 2319.5, 1733.2, 7.5, 7.5, 270.0, 0.0, 24.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_62
		MapFixObjects[231] = mf_CreateObject(8957, 2393.8, 1483.7, 9.7, 0.0, 90.0, 90.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_63
		MapFixObjects[232] = mf_CreateObject(8957, -2690.7, 518.5, 17.1, 0.0, 0.0, 90.0, 10.0);
		MapFixObjects[233] = mf_CreateObject(3084, -2688.8, 512.1, 20.2, 90.0, 0.0, 90.0, 14.0);
		MapFixObjects[234] = mf_CreateObject(3084, -2688.8, 499.6, 20.2, 90.0, 0.0, 90.0, 14.0);
		MapFixObjects[235] = mf_CreateObject(3084, -2688.8, 487.1, 20.2, 90.0, 0.0, 90.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_64
		MapFixObjects[236] = mf_CreateObject(3084, 1003.8, -1161.3, 27.0, 90.0, 0.0, 0.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_65
		MapFixObjects[237] = mf_CreateObject(3093, 807.0, -1032.6, 26.4, 0.0, 90.0, 26.0, 4.0);
		MapFixObjects[238] = mf_CreateObject(3093, 812.5, -1030.2, 26.4, 0.0, 90.0, 26.0, 4.0);
		MapFixObjects[239] = mf_CreateObject(3093, 818.1, -1027.4, 26.4, 0.0, 90.0, 26.3, 4.0);
		MapFixObjects[240] = mf_CreateObject(3093, 823.8, -1024.6, 26.4, 0.0, 90.0, 26.3, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_66
		MapFixObjects[241] = mf_CreateObject(3084, 1653.1, -1333.3, 108.7, 90.0, 0.0, 90.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[241], 0, 0, "none", "none", 0);
		MapFixObjects[242] = mf_CreateObject(3084, 1653.1, -1353.3, 108.7, 90.0, 0.0, 90.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[242], 0, 0, "none", "none", 0);
		MapFixObjects[243] = mf_CreateObject(3055, 1653.7, -1343.3, 108.7, 90.0, 0.0, 90.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[243], 0, 0, "none", "none", 0);
		MapFixObjects[244] = mf_CreateObject(3084, 1681.5, -1324.9, 108.7, 90.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[244], 0, 0, "none", "none", 0);
		MapFixObjects[245] = mf_CreateObject(3084, 1661.5, -1324.9, 108.7, 90.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[245], 0, 0, "none", "none", 0);
		MapFixObjects[246] = mf_CreateObject(3055, 1671.5, -1325.5, 108.7, 90.0, 0.0, 0.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[246], 0, 0, "none", "none", 0);
		MapFixObjects[247] = mf_CreateObject(3084, 1689.9, -1333.3, 108.7, 90.0, 0.0, 90.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[247], 0, 0, "none", "none", 0);
		MapFixObjects[248] = mf_CreateObject(3084, 1689.9, -1353.3, 108.7, 90.0, 0.0, 90.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[248], 0, 0, "none", "none", 0);
		MapFixObjects[249] = mf_CreateObject(3055, 1688.7, -1343.3, 108.7, 90.0, 0.0, 90.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[249], 0, 0, "none", "none", 0);
		MapFixObjects[250] = mf_CreateObject(3084, 1661.5, -1361.7, 108.7, 90.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[250], 0, 0, "none", "none", 0);
		MapFixObjects[251] = mf_CreateObject(3084, 1681.5, -1361.7, 108.7, 90.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[251], 0, 0, "none", "none", 0);
		MapFixObjects[252] = mf_CreateObject(3055, 1671.5, -1360.5, 108.7, 90.0, 0.0, 0.0, 15.0);
		mf_SetObjectMaterial(MapFixObjects[252], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_67
		MapFixObjects[253] = mf_CreateObject(8957, 2194.0, -1099.1, 27.9, 0.0, 90.0, 66.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_68
		MapFixObjects[254] = mf_CreateObject(8957, 2617.6, 1078.2, 9.5, 0.0, 90.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_69
		MapFixObjects[255] = mf_CreateObject(5020, 1838.5, 1285.5, 9.7, 0.0, 88.0, 0.0, 9.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_70
		MapFixObjects[256] = mf_CreateObject(4100, 1902.1, -1055.2, 24.11, 1.5, 0.0, 319.7, 18.0);
		mf_SetObjectMaterial(MapFixObjects[256], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_71
		MapFixObjects[257] = mf_CreateObject(3168, -640.5, 2717.2, 71.4, 0.0, 0.0, 42.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_72 //by Jimmi, 0.3.7 objects are used
		MapFixObjects[258] = mf_CreateObject(19866, 2417.3059, 2387.3217, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[259] = mf_CreateObject(19866, 2417.0258, 2387.3217, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[260] = mf_CreateObject(19866, 2417.3059, 2382.3217, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[261] = mf_CreateObject(19866, 2417.0258, 2382.3217, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[262] = mf_CreateObject(19866, 2417.3051, 2377.301, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[263] = mf_CreateObject(19866, 2417.031, 2377.3283, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[264] = mf_CreateObject(19866, 2417.3059, 2372.321, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[265] = mf_CreateObject(19866, 2417.031, 2372.3283, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[266] = mf_CreateObject(19866, 2417.3059, 2367.321, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[267] = mf_CreateObject(19866, 2417.031, 2367.3283, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[268] = mf_CreateObject(19866, 2417.3059, 2363.1809, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[269] = mf_CreateObject(19866, 2417.0258, 2363.1809, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[270] = mf_CreateObject(19866, 2417.0258, 2359.301, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[271] = mf_CreateObject(19866, 2417.3059, 2359.3007, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[272] = mf_CreateObject(19866, 2417.3059, 2397.062, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[273] = mf_CreateObject(19866, 2417.3059, 2400.7619, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[274] = mf_CreateObject(19866, 2417.0258, 2397.0617, 9.8151, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[275] = mf_CreateObject(19866, 2417.0258, 2400.7817, 9.8151, 0.0, 0.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_73 //by Walter Correa, 0.3e objects are used
		MapFixObjects[276] = mf_CreateFloorObject(19380, 2530.5444, -1686.4581, 1014.406, 0.0, 90.0, 90.0, 16.0);
		MapFixObjects[277] = mf_CreateFloorObject(19380, 2530.5444, -1686.4581, 1018.0872, 0.0, 90.0, 90.0, 16.0);
		MapFixObjects[278] = mf_CreateFloorObject(2987, 2531.6193, -1683.7325, 1015.0974, 90.0, 0.0, 90.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[278], 0, 0, "none", "none", 0);
		MapFixObjects[279] = mf_CreateObject(19380, 2528.3588, -1685.8667, 1012.8079, 0.0, 0.0, 90.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[279], 0, 0, "none", "none", 0);
		MapFixObjects[280] = mf_CreateObject(19380, 2523.6545, -1682.6535, 1012.8079, 0.0, 0.0, 0.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[280], 0, 0, "none", "none", 0);
		MapFixObjects[281] = mf_CreateObject(19380, 2524.2971, -1681.1002, 1012.8079, 0.0, 0.0, 90.0, 16.0);
		MapFixObjects[282] = mf_CreateObject(19380, 2533.2294, -1685.9915, 1012.8079, 0.0, 0.0, 0.0, 16.0);
		MapFixObjects[283] = mf_CreateObject(19380, 2527.7893, -1685.9915, 1012.8079, 0.0, 0.0, 0.0, 16.0);
		MapFixObjects[284] = mf_CreateObject(2987, 2531.8166, -1680.9843, 1016.0134, 0.0, 0.0, 0.0, 4.0);
		MapFixObjects[285] = mf_CreateObject(2987, 2531.8166, -1681.2143, 1016.0134, 0.0, 0.0, 0.0, 4.0);
		MapFixObjects[286] = mf_CreateObject(1566, 2529.9609, -1681.0909, 1018.9467, 0.0, 90.0, 0.0, 4.0);
		MapFixObjects[287] = mf_CreateObject(1566, 2530.8859, -1681.3482, 1015.8281, 0.0, 0.0, -10.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[287], 0, 0, "none", "none", 0);
		MapFixObjects[288] = mf_CreateObject(2948, 2526.3342, -1681.8027, 1014.9155, 0.0, 90.0, 0.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[288], 0, 0, "none", "none", 0);
		MapFixObjects[289] = mf_CreateObject(2948, 2531.9921, -1675.7945, 1014.9516, 0.0, 90.0, 90.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[289], 0, 0, "none", "none", 0);
		MapFixObjects[290] = mf_CreateObject(2948, 2532.3266, -1681.723, 1015.1895, 0.0, 90.0, 0.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[290], 0, 0, "none", "none", 0);
		MapFixObjects[291] = mf_CreateObject(2948, 2534.84, -1672.7554, 1014.9516, 0.0, 90.0, 90.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[291], 0, 0, "none", "none", 0);
		MapFixObjects[292] = mf_CreateObject(2948, 2535.6123, -1672.7554, 1014.9516, 0.0, 90.0, 90.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[292], 0, 0, "none", "none", 0);
		MapFixObjects[293] = mf_CreateObject(2948, 2534.9394, -1676.5258, 1015.2634, 0.0, 0.0, 90.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[293], 0, 0, "none", "none", 0);
		MapFixObjects[294] = mf_CreateObject(2948, 2536.0615, -1676.5258, 1015.2634, 0.0, 0.0, 90.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[294], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_74 //by Apec & substantive., 0.3e objects are used
		MapFixObjects[295] = mf_CreateObject(19464, 293.1319, -1616.1232, 34.7051, 0.0, 0.0, 80.0, 14.0);
		mf_SetObjectMaterial(MapFixObjects[295], 0, 0, "none", "none", 0);
		MapFixObjects[296] = mf_CreateObject(19464, 287.3273, -1615.127, 34.7051, 0.0, 0.0, 80.0, 14.0);
		mf_SetObjectMaterial(MapFixObjects[296], 0, 0, "none", "none", 0);
		MapFixObjects[297] = mf_CreateObject(19464, 281.4706, -1614.0808, 34.7051, 0.0, 0.0, 80.0, 14.0);
		mf_SetObjectMaterial(MapFixObjects[297], 0, 0, "none", "none", 0);
		MapFixObjects[298] = mf_CreateObject(19464, 287.37, -1611.42, 17.48, 0.0, 0.0, -100.0, 14.0);
		mf_SetObjectMaterial(MapFixObjects[298], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_75
		MapFixObjects[299] = mf_CreateObject(5020, 1861.7, 1363.3, 55.8, 0.0, 0.0, 90.0, 8.0);
		MapFixObjects[300] = mf_CreateObject(5020, 1907.2, 1298.8, 55.8, 0.0, 0.0, 180.0, 8.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_76
		MapFixObjects[301] = mf_CreateObject(3037, 1714.5, 896.8, 14.3, 0.0, 270.0, 0.0, 12.0);
		MapFixObjects[302] = mf_CreateObject(3037, 1714.5, 906.3, 14.3, 0.0, 270.0, 0.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_77
		MapFixObjects[303] = mf_CreateObject(3084, -880.8, 1640.2, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[303], 0, 0, "none", "none", 0);
		MapFixObjects[304] = mf_CreateObject(3084, -887.22, 1650.9, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[304], 0, 0, "none", "none", 0);
		MapFixObjects[305] = mf_CreateObject(3084, -893.65, 1661.6, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[305], 0, 0, "none", "none", 0);
		MapFixObjects[306] = mf_CreateObject(3084, -900.07, 1672.3, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[306], 0, 0, "none", "none", 0);
		MapFixObjects[307] = mf_CreateObject(3084, -906.5, 1683.0, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[307], 0, 0, "none", "none", 0);
		MapFixObjects[308] = mf_CreateObject(3084, -870.1, 1646.8, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[308], 0, 0, "none", "none", 0);
		MapFixObjects[309] = mf_CreateObject(3084, -876.53, 1657.5, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[309], 0, 0, "none", "none", 0);
		MapFixObjects[310] = mf_CreateObject(3084, -882.95, 1668.2, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[310], 0, 0, "none", "none", 0);
		MapFixObjects[311] = mf_CreateObject(3084, -889.37, 1678.9, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[311], 0, 0, "none", "none", 0);
		MapFixObjects[312] = mf_CreateObject(3084, -895.8, 1689.6, 25.3, 0.0, 0.0, 301.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[312], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_78
		MapFixObjects[313] = mf_CreateObject(1566, -2105.4, -498.5, 49.5, 0.0, 0.0, 90.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_79
		MapFixObjects[314] = mf_CreateObject(10149, -2557.25, 991.2, 80.6, 90.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[314], 0, 0, "none", "none", 0);
		MapFixObjects[315] = mf_CreateObject(10149, -2557.25, 986.4, 80.6, 90.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[315], 0, 0, "none", "none", 0);
		MapFixObjects[316] = mf_CreateObject(10149, -2557.25, 984.9, 82.3, 0.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[316], 0, 0, "none", "none", 0);
		MapFixObjects[317] = mf_CreateObject(10149, -2557.25, 992.6, 82.3, 0.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[317], 0, 0, "none", "none", 0);
		MapFixObjects[318] = mf_CreateObject(10149, -2555.3, 986.8, 82.3, 0.0, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[318], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_80
		MapFixObjects[319] = mf_CreateObject(10184, -2283.1, 916.7, 85.5, 270.0, 0.0, 0.0, 18.0);
		MapFixObjects[320] = mf_CreateObject(2957, -2281.1, 916.6, 94.4, 90.0, 0.0, 90.0, 6.0);
		MapFixObjects[321] = mf_CreateObject(2957, -2283.0, 916.5, 75.2, 0.0, 0.0, 90.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_81 //by ZiGGi
		MapFixObjects[322] = mf_CreateObject(1498, 2401.755, -1714.5, 13.1243, 0.0, 0.0, 0.0, 150.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_82
		MapFixObjects[323] = mf_CreateObject(3084, 2235.9, 2233.2, 14.1, 270.0, 0.0, 90.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_83
		MapFixObjects[324] = mf_CreateObject(3037, -2313.0, 771.7, 57.0, 0.0, 0.0, 358.5, 12.0);
		MapFixObjects[325] = mf_CreateObject(3037, -2313.3, 761.5, 57.0, 0.0, 0.0, 358.5, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_84 //by Hare
		MapFixObjects[326] = mf_CreateObject(3037, 1082.427, -1191.49622, 19.2386, 0.0, 0.0, 0.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_85
		MapFixObjects[327] = mf_CreateObject(3037, 1227.2, 312.9, 21.1, 0.0, 270.0, 66.0, 12.0);
		MapFixObjects[328] = mf_CreateObject(3037, 1223.8, 311.1, 21.8, 0.0, 270.0, 66.0, 12.0);
		MapFixObjects[329] = mf_CreateObject(3037, 1232.3, 307.3, 21.8, 0.0, 270.0, 66.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_86
		MapFixObjects[330] = mf_CreateObject(1966, -2730.6, 834.9, 59.8, 0.0, 0.0, 90.0, 10.0);
		MapFixObjects[331] = mf_CreateObject(1966, -2734.0, 831.4, 59.8, 0.0, 0.0, 0.0, 10.0);
		MapFixObjects[332] = mf_CreateObject(1966, -2734.0, 838.4, 59.8, 0.0, 0.0, 0.0, 10.0);
		MapFixObjects[333] = mf_CreateObject(5340, -2737.7, 835.0, 60.6, 0.0, 0.0, 0.0, 8.0);
		MapFixObjects[334] = mf_CreateObject(3117, -2737.7, 833.3, 59.2, 0.0, 0.0, 90.0, 6.0);
		MapFixObjects[335] = mf_CreateObject(1966, -2735.38, 835.0, 58.8, 270.0, 0.0, 90.0, 10.0);
		MapFixObjects[336] = mf_CreateObject(1966, -2734.0, 831.4, 56.0, 0.0, 0.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_87
		MapFixObjects[337] = mf_CreateObject(3084, 1328.7, -997.1, 47.1, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[338] = mf_CreateObject(3084, 1328.7, -984.8, 47.1, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[339] = mf_CreateObject(3084, 1328.7, -972.4, 47.1, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[340] = mf_CreateObject(3084, 1322.5, -1003.2, 47.1, 0.0, 0.0, 0.0, 14.0);
		MapFixObjects[341] = mf_CreateObject(3084, 1310.6, -1003.2, 47.1, 0.0, 0.0, 0.0, 14.0);
		MapFixObjects[342] = mf_CreateObject(3084, 1304.4, -997.1, 47.1, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[343] = mf_CreateObject(3084, 1304.4, -984.7, 47.1, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[344] = mf_CreateObject(3084, 1304.4, -972.4, 47.1, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[345] = mf_CreateObject(3084, 1310.6, -966.2, 47.1, 0.0, 0.0, 0.0, 14.0);
		MapFixObjects[346] = mf_CreateObject(3084, 1322.5, -966.2, 47.1, 0.0, 0.0, 0.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_88
		MapFixObjects[347] = mf_CreateObject(3084, -1800.3, 1516.5, -32.9, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[348] = mf_CreateObject(3084, -1800.3, 1504.1, -32.9, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[349] = mf_CreateObject(3084, -1800.3, 1491.7, -32.9, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[350] = mf_CreateObject(3084, -1820.2, 1447.4, -32.7, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[351] = mf_CreateObject(3084, -1820.2, 1459.8, -32.7, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[352] = mf_CreateObject(3084, -1820.2, 1472.2, -32.7, 0.0, 0.0, 90.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_89
		MapFixObjects[353] = mf_CreateObject(3037, -2340.1, 796.8, 51.8, 90.0, 0.0, 90.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_90
		MapFixObjects[354] = mf_CreateObject(3117, 2091.1, -2079.3, 25.1, 90.0, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[354], 0, 0, "none", "none", 0);
		MapFixObjects[355] = mf_CreateObject(3117, 2009.6, -2079.3, 25.1, 90.0, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[355], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_91 //by KinG7
		MapFixObjects[356] = mf_CreateObject(1501, -383.46, -1439.64, 25.33, 0.0, 0.0, 90.0, 150.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_92 //by KinG7
		MapFixObjects[357] = mf_CreateObject(1505, -2574.495, 1153.023, 54.669, 0.0, 0.0, -19.444, 150.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_93 //by KinG7
		MapFixObjects[358] = mf_CreateObject(1496, -1800.7048, 1201.0538, 24.1293, 0.0, 0.0, 0.0, 150.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_94 //by KinG7
		MapFixObjects[359] = mf_CreateObject(1522, -1390.7784, 2639.247, 54.9744, 0.0, 0.0, 0.0, 150.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_95 //by KinG7
		MapFixObjects[360] = mf_CreateObject(1498, 2038.036, 2721.37, 10.53, 0.0, 0.0, -180.0, 150.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_96
		MapFixObjects[361] = mf_CreateObject(2957, -2550.5, 193.9, 6.5, 0.0, 0.0, 285.5, 13.0);
		mf_SetObjectMaterial(MapFixObjects[361], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_97
		MapFixObjects[362] = mf_CreateObject(3037, 875.6, -1565.0, 16.7, 0.0, 270.0, 293.0, 12.0);
		MapFixObjects[363] = mf_CreateObject(2957, 869.3, -1567.8, 16.7, 90.0, 0.0, 12.0, 6.0);
		MapFixObjects[364] = mf_CreateObject(2957, 882.3, -1562.4, 16.7, 90.0, 0.0, 31.997, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_98
		MapFixObjects[365] = mf_CreateObject(3037, 770.2, -3.6, 1004.2, 0.0, 90.0, 90.0, 12.0);
		MapFixObjects[366] = mf_CreateObject(3037, 760.0, -3.6, 1004.2, 0.0, 90.0, 90.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_99
		MapFixObjects[367] = mf_CreateObject(3117, 145.2, -199.6, 3.95, 0.0, 0.0, 315.25, 8.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_100
		MapFixObjects[368] = mf_CreateObject(10184, 353.2, -1603.6, 36.1, 0.0, 90.0, 88.25, 18.0);
		MapFixObjects[369] = mf_CreateObject(10184, 370.2, -1604.1, 36.1, 0.0, 90.0, 88.25, 18.0);
		MapFixObjects[370] = mf_CreateObject(10184, 387.2, -1604.6, 36.1, 0.0, 90.0, 88.25, 18.0);
		MapFixObjects[371] = mf_CreateObject(10184, 355.1, -1633.0, 36.1, 0.0, 90.0, 263.0, 18.0);
		MapFixObjects[372] = mf_CreateObject(10184, 372.3, -1635.1, 36.1, 0.0, 90.0, 263.25, 18.0);
		MapFixObjects[373] = mf_CreateObject(10184, 389.5, -1637.4, 36.1, 0.0, 90.0, 261.0, 18.0);
		MapFixObjects[374] = mf_CreateObject(2957, 388.9, -1635.5, 41.5, 270.0, 0.0, 10.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_101 //by Romzes, 0.3e objects are used
		MapFixObjects[375] = mf_CreateObject(19454, 242.593, -178.5028, 4.17, 0.0, 90.0, 0.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_102 //by $continue$
		MapFixObjects[376] = mf_CreateObject(1685, -2397.2, 2407.9, 13.2, 0.0, 46.0, 243.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[376], 0, 0, "none", "none", 0);
		MapFixObjects[377] = mf_CreateObject(1685, -2395.7, 2407.2, 13.2, 0.0, 46.0, 243.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[377], 0, 0, "none", "none", 0);
		MapFixObjects[378] = mf_CreateObject(1685, -2397.7, 2407.0, 12.2, 0.0, 46.0, 243.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[378], 0, 0, "none", "none", 0);
		MapFixObjects[379] = mf_CreateObject(1685, -2396.2, 2406.3, 12.2, 0.0, 46.0, 243.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[379], 0, 0, "none", "none", 0);
		MapFixObjects[380] = mf_CreateObject(1685, -2396.0, 2407.6, 13.22, 0.0, 316.0, 243.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[380], 0, 0, "none", "none", 0);
		MapFixObjects[381] = mf_CreateObject(1685, -2397.1, 2408.2, 13.3, 0.0, 316.0, 243.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[381], 0, 0, "none", "none", 0);
		MapFixObjects[382] = mf_CreateObject(1685, -2395.5, 2408.7, 12.0, 0.0, 316.0, 243.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[382], 0, 0, "none", "none", 0);
		MapFixObjects[383] = mf_CreateObject(1685, -2396.6, 2409.1, 12.32, 0.0, 138.0, 245.75, 12.0);
		mf_SetObjectMaterial(MapFixObjects[383], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_103
		MapFixObjects[384] = mf_CreateFloorObject(3037, 376.4, 194.8, 1013.0, 0.0, 270.0, 90.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_104
		MapFixObjects[385] = mf_CreateObject(3055, 260.6, 1823.2, 9.7, 90.0, 0.0, 0.0, 10.0);
		MapFixObjects[386] = mf_CreateObject(3055, 260.6, 1826.8, 9.7, 90.0, 0.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_105
		MapFixObjects[387] = mf_CreateObject(2957, -207.2, 1171.8, 21.6, 90.0, 0.0, 270.0, 6.0);
		MapFixObjects[388] = mf_CreateObject(2957, -207.2, 1164.9, 22.3, 90.0, 0.0, 270.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_106
		MapFixObjects[389] = mf_CreateObject(2957, -207.8, 1073.6, 20.4, 0.0, 0.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_107
		MapFixObjects[390] = mf_CreateObject(3084, 1682.7, -2003.9, 18.8, 270.0, 0.0, 270.0, 14.0);
		MapFixObjects[391] = mf_CreateObject(3084, 1682.7, -1991.5, 18.8, 270.0, 180.0, 90.0, 14.0);
		MapFixObjects[392] = mf_CreateObject(3084, 1682.7, -1979.1, 18.8, 270.0, 0.0, 270.0, 14.0);
		MapFixObjects[393] = mf_CreateObject(3084, 1682.7, -1966.7, 18.8, 270.0, 0.0, 270.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_108
		MapFixObjects[394] = mf_CreateObject(3084, 374.1, -1765.8, 9.3, 272.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[394], 0, 0, "none", "none", 0);
		MapFixObjects[395] = mf_CreateObject(3084, 366.6, -1765.8, 9.3, 280.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[395], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_109
		MapFixObjects[396] = mf_CreateObject(2954, 406.6, -1287.3, 49.0, 0.0, 0.0, 296.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[396], 0, 0, "none", "none", 0);
		MapFixObjects[397] = mf_CreateObject(2954, 406.6, -1287.3, 51.0, 0.0, 0.0, 296.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[397], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_110
		MapFixObjects[398] = mf_CreateObject(2957, 1101.1, -1291.1, 17.5, 0.0, 0.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_111
		MapFixObjects[399] = mf_CreateObject(2904, 430.8, -1250.5, 49.1, 0.0, 90.0, 21.5, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_112
		MapFixObjects[400] = mf_CreateObject(3084, 997.6, -1209.3, 22.0, 90.0, 0.0, 0.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_113
		MapFixObjects[401] = mf_CreateObject(2938, -1556.4, 355.5, 25.3, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[402] = mf_CreateObject(2938, -1556.4, 355.5, 37.3, 90.0, 0.0, 0.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_114
		MapFixObjects[403] = mf_CreateObject(2938, -1611.4, 871.6, 26.6, 0.0, 270.0, 90.0, 14.0);
		MapFixObjects[404] = mf_CreateObject(2938, -1599.8, 871.6, 26.6, 0.0, 270.0, 90.0, 14.0);
		MapFixObjects[405] = mf_CreateObject(2938, -1588.8, 871.6, 26.6, 0.0, 270.0, 90.0, 14.0);
		MapFixObjects[406] = mf_CreateObject(3084, -1611.5, 868.9, 26.6, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[407] = mf_CreateObject(3084, -1600.0, 868.9, 26.6, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[408] = mf_CreateObject(3084, -1588.9, 868.9, 26.6, 90.0, 0.0, 0.0, 14.0);
		MapFixObjects[409] = mf_CreateObject(2938, -1611.6, 867.3, 29.2, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[410] = mf_CreateObject(2938, -1611.6, 867.3, 34.6, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[411] = mf_CreateObject(2938, -1599.8, 867.3, 29.2, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[412] = mf_CreateObject(2938, -1588.7, 867.3, 29.2, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[413] = mf_CreateObject(2938, -1599.8, 867.3, 34.6, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[414] = mf_CreateObject(2938, -1588.7, 867.3, 34.6, 0.0, 0.0, 270.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_115
		MapFixObjects[415] = mf_CreateObject(2938, 2482.9, 2358.7, 15.1, 0.0, 90.0, 90.0, 14.0);
		MapFixObjects[416] = mf_CreateObject(2938, 2482.9, 2353.3, 15.1, 0.0, 90.0, 90.0, 14.0);
		MapFixObjects[417] = mf_CreateObject(2938, 2494.8, 2358.7, 15.1, 0.0, 90.0, 90.0, 14.0);
		MapFixObjects[418] = mf_CreateObject(2938, 2494.8, 2353.3, 15.1, 0.0, 90.0, 90.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_116
		MapFixObjects[419] = mf_CreateObject(3117, -2553.4, 1181.4, 43.9, 86.0, 60.0, 10.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_117 //by Romzes, 0.3e objects are used
		MapFixObjects[420] = mf_CreateObject(19362, 1209.8636, -16.1376, 1001.9523, 0.0, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[420], 0, 0, "none", "none", 0);
		MapFixObjects[421] = mf_CreateObject(19362, 1211.3809, -17.6581, 1001.9523, 0.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[421], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_118
		MapFixObjects[422] = mf_CreateObject(3055, 2317.9, -1026.0, 1053.3, 270.0, 0.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_119
		MapFixObjects[423] = mf_CreateObject(3117, 161.3, -22.3, 7.3, 90.0, 90.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_120
		MapFixObjects[424] = mf_CreateObject(3037, 958.7, -1550.1, 20.3, 0.0, 0.0, 0.0, 12.0);
		MapFixObjects[425] = mf_CreateObject(3037, 958.7, -1557.2, 20.3, 0.0, 0.0, 0.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_121
		MapFixObjects[426] = mf_CreateObject(3117, -2008.9, -1038.0, 56.5, 0.0, 0.0, 10.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_122
		MapFixObjects[427] = mf_CreateObject(3037, 858.2, -614.0, 27.2, 0.0, 0.0, 90.0, 12.0);
		MapFixObjects[428] = mf_CreateObject(3037, 864.6, -614.0, 27.2, 0.0, 0.0, 90.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_123
		MapFixObjects[429] = mf_CreateObject(2957, 953.0, -994.4, 40.9, 90.0, 0.0, 270.6, 13.0);
		mf_SetObjectMaterial(MapFixObjects[429], 0, 0, "none", "none", 0);
		MapFixObjects[430] = mf_CreateObject(2957, 952.96, -990.5, 40.9, 90.0, 0.0, 270.6, 13.0);
		mf_SetObjectMaterial(MapFixObjects[430], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_124
		MapFixObjects[431] = mf_CreateObject(3084, -1911.9, 750.1, 102.0, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[432] = mf_CreateObject(3084, -1911.9, 762.5, 102.0, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[433] = mf_CreateObject(3084, -1911.9, 774.9, 102.0, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[434] = mf_CreateObject(3084, -1911.9, 783.4, 102.0, 0.0, 0.0, 90.0, 14.0);
		MapFixObjects[435] = mf_CreateObject(3084, -1918.0, 789.6, 102.0, 0.0, 0.0, 0.0, 14.0);
		MapFixObjects[436] = mf_CreateObject(3084, -1930.4, 789.6, 102.0, 0.0, 0.0, 0.0, 14.0);
		MapFixObjects[437] = mf_CreateObject(3084, -1942.8, 789.6, 102.0, 0.0, 0.0, 0.0, 14.0);
		MapFixObjects[438] = mf_CreateObject(3084, -1948.4, 789.6, 102.0, 0.0, 0.0, 0.0, 14.0);
		MapFixObjects[439] = mf_CreateObject(3084, -1918.0, 743.8, 102.0, 0.0, 0.0, 180.0, 14.0);
		MapFixObjects[440] = mf_CreateObject(3084, -1930.4, 743.8, 102.0, 0.0, 0.0, 180.0, 14.0);
		MapFixObjects[441] = mf_CreateObject(3084, -1942.8, 743.8, 102.0, 0.0, 0.0, 180.0, 14.0);
		MapFixObjects[442] = mf_CreateObject(3084, -1948.4, 743.8, 102.0, 0.0, 0.0, 180.0, 14.0);
		MapFixObjects[443] = mf_CreateObject(3084, -1954.5, 750.1, 102.0, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[444] = mf_CreateObject(3084, -1954.5, 762.5, 102.0, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[445] = mf_CreateObject(3084, -1954.5, 774.9, 102.0, 0.0, 0.0, 270.0, 14.0);
		MapFixObjects[446] = mf_CreateObject(3084, -1954.5, 783.4, 102.0, 0.0, 0.0, 270.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_125
		MapFixObjects[447] = mf_CreateObject(3037, 1054.3, -940.3, 44.3, 0.0, 270.0, 77.5, 12.0);
		MapFixObjects[448] = mf_CreateObject(3037, 1062.2, -939.1, 44.3, 0.0, 270.0, 300.0, 12.0);
		MapFixObjects[449] = mf_CreateObject(3084, 1036.4, -942.6, 44.0, 90.0, 0.0, 8.5, 14.0);
		MapFixObjects[450] = mf_CreateObject(2957, 1046.6, -941.1, 44.3, 90.0, 0.0, 8.5, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_126
		MapFixObjects[451] = mf_CreateObject(2938, -1479.5, 696.9, -33.0, 0.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[451], 0, 0, "none", "none", 0);
		MapFixObjects[452] = mf_CreateObject(2938, -1479.5, 708.2, -33.0, 0.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[452], 0, 0, "none", "none", 0);
		MapFixObjects[453] = mf_CreateObject(2938, -1479.5, 690.2, -33.0, 0.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[453], 0, 0, "none", "none", 0);
		MapFixObjects[454] = mf_CreateObject(2938, -1485.4, 684.3, -33.0, 0.0, 0.0, 270.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[454], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_127
		MapFixObjects[455] = mf_CreateObject(3117, 1519.1, 1911.6, 14.0, 14.5, 90.0, 0.0, 6.0);
		MapFixObjects[456] = mf_CreateObject(3117, 1652.1, 1911.6, 14.0, 14.5, 90.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_128 //by Romzes, 0.3e objects are used
		MapFixObjects[457] = mf_CreateObject(19426, 617.2022, -1124.6236, 47.2562, 0.0, 0.0, 31.6442, 12.0);
		mf_SetObjectMaterial(MapFixObjects[457], 0, 13699, "cunte2_lahills", "hedge2", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_129
		MapFixObjects[458] = mf_CreateObject(2938, 1318.5, 353.9, 18.4, 0.0, 270.0, 66.0, 14.0);
		MapFixObjects[459] = mf_CreateObject(2938, 1307.6, 358.7, 18.4, 0.0, 270.0, 66.0, 14.0);
		MapFixObjects[460] = mf_CreateObject(2938, 1301.6, 361.4, 18.4, 0.0, 270.0, 66.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_130 //by reAL_
		MapFixObjects[461] = mf_CreateObject(2938, 445.4595, 511.5701, 1003.7977, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[461], 0, 0, "none", "none", 0);
		MapFixObjects[462] = mf_CreateObject(2938, 450.7594, 511.5701, 1003.7977, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[462], 0, 0, "none", "none", 0);
		MapFixObjects[463] = mf_CreateObject(2957, 456.1647, 513.8776, 1003.7949, 90.0, 0.0, 90.0, 6.0);
		MapFixObjects[464] = mf_CreateObject(2957, 454.3006, 513.8814, 1003.8049, 90.0, 0.0, 90.0, 6.0);
		MapFixObjects[465] = mf_CreateObject(2904, 453.1383, 513.4265, 1004.3114, 0.0, 90.0, 90.0, 4.0);
		MapFixObjects[466] = mf_CreateObject(2957, 455.4764, 511.4462, 1002.1149, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[467] = mf_CreateObject(3117, 453.0726, 515.1799, 1001.9401, 0.0, 90.0, 0.0, 6.0);
		MapFixObjects[468] = mf_CreateObject(3117, 453.1283, 511.2336, 1001.9401, 0.0, 90.0, 0.0, 6.0);
		MapFixObjects[469] = mf_CreateObject(3037, 452.8891, 507.164, 1001.6256, 0.0, 0.0, 0.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[469], 0, 0, "none", "none", 0);
		MapFixObjects[470] = mf_CreateObject(3117, 442.3696, 509.1084, 1001.9041, 0.0, 90.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_131 //by Sonic X, 0.3e objects are used
		MapFixObjects[471] = mf_CreateObject(19374, -563.356, -181.631, 79.983, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[472] = mf_CreateObject(19374, -572.3, -176.617, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[473] = mf_CreateObject(19374, -572.3, -177.9, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[474] = mf_CreateObject(19374, -568.8, -176.617, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[475] = mf_CreateObject(19374, -568.8, -177.9, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[476] = mf_CreateObject(19374, -565.3, -176.617, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[477] = mf_CreateObject(19374, -565.3, -177.9, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[478] = mf_CreateObject(19374, -562.915, -176.617, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[479] = mf_CreateObject(19374, -562.915, -177.9, 80.23, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[480] = mf_CreateObject(19374, -537.33, -98.473, 64.867, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[481] = mf_CreateObject(19374, -528.4, -101.95, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[482] = mf_CreateObject(19374, -528.4, -103.7, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[483] = mf_CreateObject(19374, -531.9, -103.6, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[484] = mf_CreateObject(19374, -531.9, -101.95, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[485] = mf_CreateObject(19374, -535.4, -103.6, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[486] = mf_CreateObject(19374, -537.75, -103.6, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[487] = mf_CreateObject(19374, -537.75, -101.95, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[488] = mf_CreateObject(19374, -535.4, -101.95, 65.0, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[489] = mf_CreateObject(19374, 2355.8, -648.51, 129.636, 0.0, 90.0, 0.0, 13.0);
		MapFixObjects[490] = mf_CreateObject(19374, 2352.2, -657.6, 129.763, 0.0, 90.0, 270.0, 13.0);
		MapFixObjects[491] = mf_CreateObject(19374, 2350.94, -657.6, 129.763, 0.0, 90.0, 270.0, 13.0);
		MapFixObjects[492] = mf_CreateObject(19374, 2350.94, -654.2, 129.763, 0.0, 90.0, 270.0, 13.0);
		MapFixObjects[493] = mf_CreateObject(19374, 2350.94, -650.7, 129.763, 0.0, 90.0, 270.0, 13.0);
		MapFixObjects[494] = mf_CreateObject(19374, 2350.94, -648.0, 129.763, 0.0, 90.0, 270.0, 13.0);
		MapFixObjects[495] = mf_CreateObject(19374, 2352.2, -648.0, 129.763, 0.0, 90.0, 270.0, 13.0);
		MapFixObjects[496] = mf_CreateObject(19374, 2352.2, -650.7, 129.763, 0.0, 90.0, 270.0, 13.0);
		MapFixObjects[497] = mf_CreateObject(19374, 2352.2, -654.2, 129.763, 0.0, 90.0, 270.0, 13.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_132 //by Romzes, 0.3e objects are used
		MapFixObjects[498] = mf_CreateObject(19368, 2159.43, 2821.227, 11.2046, 0.0, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[498], 0, 0, "none", "none", 0);
		MapFixObjects[499] = mf_CreateObject(19368, 2159.43, 2820.4243, 11.2046, 0.0, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[499], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_133
		MapFixObjects[500] = mf_CreateObject(3055, 960.7, 2103.3, 1015.9, 0.0, 0.0, 0.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_134
		MapFixObjects[501] = mf_CreateObject(3117, 2329.7, 3.0, 30.4, 35.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[501], 0, 0, "none", "none", 0);
		MapFixObjects[502] = mf_CreateObject(3117, 2329.7, 4.5, 30.4, 35.0, 0.0, 180.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[502], 0, 0, "none", "none", 0);
		MapFixObjects[503] = mf_CreateObject(3117, 2329.7, -0.4, 30.4, 35.0, 0.0, 180.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[503], 0, 0, "none", "none", 0);
		MapFixObjects[504] = mf_CreateObject(3117, 2329.7, -1.9, 30.4, 35.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[504], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_135
		MapFixObjects[505] = mf_CreateObject(3117, 2333.8, 51.8, 30.0, 0.0, 90.0, 0.0, 6.0);
		MapFixObjects[506] = mf_CreateObject(3117, 2332.1, 51.8, 28.3, 0.0, 0.0, 0.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_136
		MapFixObjects[507] = mf_CreateObject(3084, 2498.1, -2018.8, 12.4, 270.0, 0.0, 0.0, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_137
		MapFixObjects[508] = mf_CreateFloorObject(3055, 189.5, 175.1, 1002.0, 90.0, 0.0, 0.0, 10.0);
		MapFixObjects[509] = mf_CreateObject(3055, 187.8, 175.4, 1003.0, 0.0, 0.0, 270.0, 10.0);
		MapFixObjects[510] = mf_CreateObject(3055, 191.5, 173.2, 1003.0, 0.0, 0.0, 270.0, 10.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_138
		MapFixObjects[511] = mf_CreateObject(3117, 2235.5, -1105.18, 1052.9, 270.0, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[511], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_139
		MapFixObjects[512] = mf_CreateObject(2938, 608.9, -76.5, 998.7, 0.0, 0.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[512], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_140
		MapFixObjects[513] = mf_CreateObject(696, -2362.8, -1963.3, 295.7, 0.0, 0.0, 0.0, 60.0);
		mf_SetObjectMaterial(MapFixObjects[513], 0, 0, "none", "none", 0);
		mf_SetObjectMaterial(MapFixObjects[513], 1, 0, "none", "none", 0);
		mf_SetObjectMaterial(MapFixObjects[513], 2, 0, "none", "none", 0);
		MapFixObjects[514] = mf_CreateObject(696, -2398.6, -1928.2, 300.9, 0.0, 0.0, 0.0, 60.0);
		mf_SetObjectMaterial(MapFixObjects[514], 0, 0, "none", "none", 0);
		mf_SetObjectMaterial(MapFixObjects[514], 1, 0, "none", "none", 0);
		mf_SetObjectMaterial(MapFixObjects[514], 2, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_141
		MapFixObjects[515] = mf_CreateObject(3084, -1506.9, 916.9, 6.18, 90.0, 0.0, 268.0, 14.0);
		MapFixObjects[516] = mf_CreateObject(3084, -1507.5, 904.5, 6.18, 90.0, 0.0, 265.99, 14.0);
		MapFixObjects[517] = mf_CreateObject(3084, -1508.4, 892.1, 6.18, 90.0, 0.0, 265.99, 14.0);
		MapFixObjects[518] = mf_CreateObject(3084, -1509.3, 879.7, 6.18, 90.0, 0.0, 265.99, 14.0);
		MapFixObjects[519] = mf_CreateObject(3084, -1510.3, 867.4, 6.18, 90.0, 0.0, 265.99, 14.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_142
		MapFixObjects[520] = mf_CreateObject(3084, -1.9, -0.2, 999.9, 0.0, 0.0, 90.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[520], 0, 0, "none", "none", 0);
		MapFixObjects[521] = mf_CreateObject(3084, 2.5, -0.3, 999.9, 0.0, 0.0, 90.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[521], 0, 0, "none", "none", 0);
		MapFixObjects[522] = mf_CreateObject(2957, 0.3, -6.4, 1000.0, 0.0, 0.0, 0.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[522], 0, 0, "none", "none", 0);
		MapFixObjects[523] = mf_CreateObject(2957, 0.3, -6.1, 998.3, 90.0, 0.0, 0.0, 6.0);
		MapFixObjects[524] = mf_CreateObject(2957, 0.8, 7.6, 999.7, 0.0, 0.0, 0.0, 6.0);
		MapFixObjects[525] = mf_CreateObject(10184, 0.2, 0.9, 1001.8, 0.0, 90.0, 0.0, 18.0);
		MapFixObjects[526] = mf_CreateObject(3117, -0.9, 6.5, 999.4, 0.0, 90.0, 0.0, 6.0);
		MapFixObjects[527] = mf_CreateObject(3117, 2.6, 6.5, 999.4, 0.0, 90.0, 180.0, 6.0);
		MapFixObjects[528] = mf_CreateObject(3117, -0.7, 5.6, 1000.0, 0.0, 90.0, 270.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[528], 0, 0, "none", "none", 0);
		MapFixObjects[529] = mf_CreateObject(3117, 2.6, 5.6, 1000.0, 0.0, 90.0, 270.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[529], 0, 0, "none", "none", 0);
		MapFixObjects[530] = mf_CreateObject(3117, 0.9, 6.6, 1001.3, 0.0, 180.0, 179.995, 6.0);
		MapFixObjects[531] = mf_CreateObject(1566, -0.9, 6.0, 1000.0, 0.0, 0.0, 270.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[531], 0, 0, "none", "none", 0);
		MapFixObjects[532] = mf_CreateObject(1566, -0.8, 2.8, 1000.0, 0.0, 0.0, 180.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[532], 0, 0, "none", "none", 0);
		MapFixObjects[533] = mf_CreateObject(2893, -0.8, 3.05, 1002.0, 73.5, 0.0, 90.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[533], 0, 0, "none", "none", 0);
		MapFixObjects[534] = mf_CreateObject(3117, -1.9, 4.5, 1001.3, 0.0, 180.0, 90.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_143 //by _leon_lacartez_, 0.3e objects are used
		MapFixObjects[535] = mf_CreateObject(19377, 2187.3974, 1628.4919, 1042.3125, 270.0, 180.0, 180.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[535], 0, 0, "none", "none", 0);
		MapFixObjects[536] = mf_CreateObject(19377, 2191.6188, 1628.4919, 1042.3125, 270.0, 180.0, 180.0, 16.0);
		MapFixObjects[537] = mf_CreateObject(19377, 2187.3974, 1618.0515, 1042.3125, 270.0, 180.0, 180.0, 16.0);
		MapFixObjects[538] = mf_CreateObject(19377, 2191.6188, 1618.0151, 1042.3125, 270.0, 180.0, 180.0, 16.0);
		MapFixObjects[539] = mf_CreateObject(19377, 2189.7272, 1620.1258, 1042.3125, 270.0, 180.0, 270.0, 16.0);
		MapFixObjects[540] = mf_CreateObject(19377, 2175.1777, 1620.1258, 1042.3125, 270.0, 180.0, 270.0, 16.0);
		MapFixObjects[541] = mf_CreateFloorObject(19377, 2182.8872, 1628.7283, 1042.3125, 0.0, 90.0, 0.0, 16.0);
		MapFixObjects[542] = mf_CreateFloorObject(19377, 2182.8872, 1619.1282, 1042.3125, 0.0, 90.0, 0.0, 16.0);
		MapFixObjects[543] = mf_CreateFloorObject(19377, 2193.3618, 1628.7283, 1042.3125, 0.0, 90.0, 0.0, 16.0);
		MapFixObjects[544] = mf_CreateFloorObject(19377, 2193.3618, 1619.1003, 1042.3125, 0.0, 90.0, 0.0, 16.0);
		MapFixObjects[545] = mf_CreateObject(19377, 2182.4968, 1633.6617, 1042.3125, 270.0, 180.0, 90.0, 16.0);
		MapFixObjects[546] = mf_CreateObject(19377, 2177.5153, 1628.4919, 1042.3125, 270.0, 180.0, 180.0, 16.0);
		MapFixObjects[547] = mf_CreateObject(19377, 2192.9362, 1633.6617, 1042.3125, 270.0, 180.0, 90.0, 16.0);
		MapFixObjects[548] = mf_CreateObject(19377, 2182.4968, 1619.3806, 1042.3125, 270.0, 180.0, 90.0, 16.0);
		MapFixObjects[549] = mf_CreateObject(19377, 2177.5153, 1618.0323, 1042.3125, 270.0, 180.0, 180.0, 16.0);
		MapFixObjects[550] = mf_CreateObject(19377, 2182.7370, 1628.7283, 1047.1828, 0.0, 90.0, 0.0, 16.0);
		MapFixObjects[551] = mf_CreateObject(19377, 2193.1574, 1628.7283, 1047.1828, 0.0, 90.0, 0.0, 16.0);
		MapFixObjects[552] = mf_CreateObject(19377, 2193.1574, 1619.1281, 1047.1828, 0.0, 90.0, 0.0, 16.0);
		MapFixObjects[553] = mf_CreateObject(19377, 2182.7592, 1619.1281, 1047.1828, 0.0, 90.0, 0.0, 16.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_144 //by _leon_lacartez_, 0.3e objects are used
		MapFixObjects[554] = mf_CreateFloorObject(19377, 447.1334, -107.2663, 998.4553, 0.0, 90.0, 180.0, 16.0);
		MapFixObjects[555] = mf_CreateFloorObject(19377, 457.5733, -107.2663, 998.4553, 0.0, 90.0, 180.0, 16.0);
		MapFixObjects[556] = mf_CreateObject(19377, 461.1731, -107.2663, 997.5545, 0.0, 180.0, 180.0, 16.0);
		MapFixObjects[557] = mf_CreateObject(19377, 441.7835, -107.2663, 998.4854, 0.0, 180.0, 180.0, 16.0);
		MapFixObjects[558] = mf_CreateObject(19377, 447.1334, -103.3863, 998.4553, 90.0, 90.0, 180.0, 16.0);
		MapFixObjects[559] = mf_CreateObject(19377, 457.6134, -103.4063, 998.4553, 90.0, 90.0, 180.0, 16.0);
		MapFixObjects[560] = mf_CreateObject(19377, 457.6134, -111.7963, 998.4553, 90.0, 90.0, 180.0, 16.0);
		MapFixObjects[561] = mf_CreateObject(19377, 447.1234, -111.7963, 998.4553, 90.0, 90.0, 180.0, 16.0);
		MapFixObjects[562] = mf_CreateObject(19377, 447.1334, -104.0, 1002.3131, 11.5, 90.0, 180.0, 16.0);
		MapFixObjects[563] = mf_CreateObject(19377, 457.5735, -104.0, 1002.3131, 11.5, 90.0, 180.0, 16.0);
		MapFixObjects[564] = mf_CreateObject(19377, 447.1334, -109.4549, 1002.6306, -10.3, 90.0, 180.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[564], 0, 0, "none", "none", 0);
		MapFixObjects[565] = mf_CreateObject(19377, 457.6135, -109.4549, 1002.6306, -10.3, 90.0, 180.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[565], 0, 0, "none", "none", 0);
		MapFixObjects[566] = mf_CreateObject(19377, 450.2434, -106.4663, 994.7451, 90.0, 90.0, 180.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[566], 0, 0, "none", "none", 0);
		MapFixObjects[567] = mf_CreateObject(19377, 460.6732, -106.4663, 994.7451, 90.0, 90.0, 180.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[567], 0, 0, "none", "none", 0);
		MapFixObjects[568] = mf_CreateObject(19377, 460.6732, -106.0064, 994.7451, 90.0, 90.0, 180.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[568], 0, 0, "none", "none", 0);
		MapFixObjects[569] = mf_CreateObject(19377, 450.2434, -106.0063, 994.7451, 90.0, 90.0, 180.0, 18.0);
		mf_SetObjectMaterial(MapFixObjects[569], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_145 //by _leon_lacartez_
		MapFixObjects[570] = mf_CreateObject(3037, 603.617, -10.7536, 1001.9877, 0.0, 0.0, 0.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[570], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_146
		MapFixObjects[571] = mf_CreateObject(9339, 2317.03, 1416.4, 22.96, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[571], 0, 0, "none", "none", 0);
		MapFixObjects[572] = mf_CreateObject(9339, 2317.03, 1442.5, 22.98, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[572], 0, 0, "none", "none", 0);
		MapFixObjects[573] = mf_CreateObject(9339, 2317.03, 1468.6, 22.99, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[573], 0, 0, "none", "none", 0);
		MapFixObjects[574] = mf_CreateObject(9339, 2317.03, 1490.7, 23.01, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[574], 0, 0, "none", "none", 0);
		MapFixObjects[575] = mf_CreateObject(9339, 2317.03, 1416.4, 35.76, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[575], 0, 0, "none", "none", 0);
		MapFixObjects[576] = mf_CreateObject(9339, 2317.03, 1442.5, 35.78, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[576], 0, 0, "none", "none", 0);
		MapFixObjects[577] = mf_CreateObject(9339, 2317.03, 1468.6, 35.79, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[577], 0, 0, "none", "none", 0);
		MapFixObjects[578] = mf_CreateObject(9339, 2317.03, 1490.7, 35.81, 0.05, 0.0, 0.0, 28.0);
		mf_SetObjectMaterial(MapFixObjects[578], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_147 //by Hare
		MapFixObjects[579] = mf_CreateObject(983, 2287.5, -1722.35, 15.2, 0.0, 90.0, 90.0, 8.0);
		MapFixObjects[580] = mf_CreateObject(983, 2290.0, -1722.35, 15.2, 0.0, 90.0, 90.0, 8.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_148
		MapFixObjects[581] = mf_CreateObject(3037, -1971.5, 748.9, 83.1, 0.0, 0.0, 0.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[581], 0, 0, "none", "none", 0);
		MapFixObjects[582] = mf_CreateObject(3037, -1971.5, 759.1, 83.1, 0.0, 0.0, 0.0, 16.0);
		mf_SetObjectMaterial(MapFixObjects[582], 0, 0, "none", "none", 0);
		MapFixObjects[583] = mf_CreateObject(2960, -1971.75, 745.8, 85.2, 0.0, 0.0, 270.0, 6.0);
		MapFixObjects[584] = mf_CreateObject(2960, -1971.75, 750.4, 85.2, 0.0, 0.0, 270.0, 6.0);
		MapFixObjects[585] = mf_CreateObject(2960, -1971.75, 755.0, 85.2, 0.0, 0.0, 270.0, 6.0);
		MapFixObjects[586] = mf_CreateObject(2960, -1971.75, 759.6, 85.2, 0.0, 0.0, 270.0, 6.0);
		MapFixObjects[587] = mf_CreateObject(2960, -1971.75, 763.1, 85.2, 0.0, 0.0, 270.0, 6.0);
		MapFixObjects[588] = mf_CreateObject(3084, -1973.9, 742.6, 77.7, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[588], 0, 0, "none", "none", 0);
		MapFixObjects[589] = mf_CreateObject(3084, -1973.9, 742.6, 65.2, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[589], 0, 0, "none", "none", 0);
		MapFixObjects[590] = mf_CreateObject(3084, -1980.4, 742.6, 77.7, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[590], 0, 0, "none", "none", 0);
		MapFixObjects[591] = mf_CreateObject(3084, -1980.4, 742.6, 65.2, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[591], 0, 0, "none", "none", 0);
		MapFixObjects[592] = mf_CreateObject(3084, -1986.5, 742.6, 77.7, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[592], 0, 0, "none", "none", 0);
		MapFixObjects[593] = mf_CreateObject(3084, -1986.5, 742.6, 65.2, 0.0, 90.0, 0.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[593], 0, 0, "none", "none", 0);
		MapFixObjects[594] = mf_CreateObject(3084, -1992.9, 749.0, 77.7, 0.0, 90.0, 270.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[594], 0, 0, "none", "none", 0);
		MapFixObjects[595] = mf_CreateObject(3084, -1992.9, 749.0, 65.2, 0.0, 90.0, 270.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[595], 0, 0, "none", "none", 0);
		MapFixObjects[596] = mf_CreateObject(3084, -1992.9, 755.5, 77.7, 0.0, 90.0, 270.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[596], 0, 0, "none", "none", 0);
		MapFixObjects[597] = mf_CreateObject(3084, -1992.9, 755.5, 65.2, 0.0, 90.0, 270.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[597], 0, 0, "none", "none", 0);
		MapFixObjects[598] = mf_CreateObject(3084, -1992.9, 761.6, 77.7, 0.0, 90.0, 270.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[598], 0, 0, "none", "none", 0);
		MapFixObjects[599] = mf_CreateObject(3084, -1992.9, 761.6, 65.2, 0.0, 90.0, 270.0, 17.0);
		mf_SetObjectMaterial(MapFixObjects[599], 0, 0, "none", "none", 0);
		MapFixObjects[600] = mf_CreateObject(3093, -1973.9, 742.5, 59.0, 0.0, 90.0, 0.0, 4.0);
		MapFixObjects[601] = mf_CreateObject(3093, -1980.4, 742.5, 59.0, 0.0, 90.0, 0.0, 4.0);
		MapFixObjects[602] = mf_CreateObject(3093, -1986.5, 742.5, 59.0, 0.0, 90.0, 0.0, 4.0);
		MapFixObjects[603] = mf_CreateObject(3084, -1972.4, 744.1, 77.7, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[604] = mf_CreateObject(3084, -1972.4, 744.1, 65.2, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[605] = mf_CreateObject(3084, -1975.3, 744.1, 77.7, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[606] = mf_CreateObject(3084, -1975.3, 744.1, 65.2, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[607] = mf_CreateObject(3084, -1978.9, 744.1, 77.7, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[608] = mf_CreateObject(3084, -1981.8, 744.1, 77.7, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[609] = mf_CreateObject(3084, -1981.8, 744.1, 65.2, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[610] = mf_CreateObject(3084, -1978.9, 744.1, 65.2, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[611] = mf_CreateObject(3084, -1985.0, 744.1, 77.7, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[612] = mf_CreateObject(3084, -1987.9, 744.1, 77.7, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[613] = mf_CreateObject(3084, -1987.9, 744.1, 65.2, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[614] = mf_CreateObject(3084, -1985.0, 744.1, 65.2, 0.0, 90.0, 270.0, 17.0);
		MapFixObjects[615] = mf_CreateObject(3093, -1993.0, 749.0, 59.0, 0.0, 90.0, 270.0, 4.0);
		MapFixObjects[616] = mf_CreateObject(3093, -1993.0, 755.5, 59.0, 0.0, 90.0, 270.0, 4.0);
		MapFixObjects[617] = mf_CreateObject(3093, -1993.0, 761.6, 59.0, 0.0, 90.0, 270.0, 4.0);
		MapFixObjects[618] = mf_CreateObject(3084, -1991.4, 747.6, 77.7, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[619] = mf_CreateObject(3084, -1991.4, 747.6, 65.2, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[620] = mf_CreateObject(3084, -1991.4, 750.5, 77.7, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[621] = mf_CreateObject(3084, -1991.4, 750.5, 65.2, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[622] = mf_CreateObject(3084, -1991.4, 754.1, 77.7, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[623] = mf_CreateObject(3084, -1991.4, 754.1, 65.2, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[624] = mf_CreateObject(3084, -1991.4, 756.98, 77.7, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[625] = mf_CreateObject(3084, -1991.4, 756.98, 65.2, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[626] = mf_CreateObject(3084, -1991.4, 760.2, 77.7, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[627] = mf_CreateObject(3084, -1991.4, 760.2, 65.2, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[628] = mf_CreateObject(3084, -1991.4, 763.1, 77.7, 0.0, 90.0, 0.0, 17.0);
		MapFixObjects[629] = mf_CreateObject(3084, -1991.4, 763.1, 65.2, 0.0, 90.0, 0.0, 17.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_149 //by MDarklight, 0.3e objects are used
		MapFixObjects[630] = mf_CreateObject(19437, 2766.7778, 178.68, 19.58, 90.0, 7.3, 90.0, 4.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_150 //by Vlad (Map Stock), 0.3e objects are used
		MapFixObjects[631] = mf_CreateObject(19445, -2016.662, 56.7692, 27.58, -8.1, 0.0, -1.4, 22.0);
		mf_SetObjectMaterial(MapFixObjects[631], 0, 9514, "711_sfw", "ws_carpark2", 0);
		MapFixObjects[632] = mf_CreateObject(19445, -2016.8947, 47.2777, 28.93, -8.1, 0.0, -1.4, 22.0);
		mf_SetObjectMaterial(MapFixObjects[632], 0, 9514, "711_sfw", "ws_carpark2", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_151 //by Apec
		MapFixObjects[633] = mf_CreateObject(17122, -212.0, -1543.3, 4.24, 0.0, 0.0, 0.0, 300.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_152
		MapFixObjects[634] = mf_CreateObject(2957, -2102.2, -2433.2, 38.1, 0.0, 0.0, 52.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[634], 0, 0, "none", "none", 0);
		MapFixObjects[635] = mf_CreateObject(2957, -2102.1, -2433.3, 38.1, 0.0, 0.0, 52.0, 13.0);
		mf_SetObjectMaterial(MapFixObjects[635], 0, 0, "none", "none", 0);
		MapFixObjects[636] = mf_CreateObject(1566, -2103.7, -2435.3, 36.4, 0.0, 0.0, 52.0, 12.0);
		mf_SetObjectMaterial(MapFixObjects[636], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_153
		MapFixObjects[637] = mf_CreateObject(2957, 2064.13, 2725.9, 13.3, 90.0, 0.0, 270.0, 6.0);
		MapFixObjects[638] = mf_CreateObject(2957, 2066.3, 2722.4, 13.3, 90.0, 0.0, 270.0, 6.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_154
		MapFixObjects[639] = mf_CreateObject(3037, 1089.7, -1485.5, 19.3, 0.0, 0.0, 286.0, 12.0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_155 //by Tornamic, 0.3c objects are used
		MapFixObjects[640] = mf_CreateObject(18980, -597.0, 1932.406, 16.372, -19.4, 0.3, 76.9, 23.0);
		mf_SetObjectMaterial(MapFixObjects[640], 0, 0, "none", "none", 0);
		MapFixObjects[641] = mf_CreateObject(18762, -603.0, 1933.861, 27.8096, 0.0, -90.5, -13.5, 13.0);
		mf_SetObjectMaterial(MapFixObjects[641], 0, 0, "none", "none", 0);
		MapFixObjects[642] = mf_CreateObject(18980, -598.6, 1925.8063, 16.372, -19.4, 0.3, 76.9, 23.0);
		mf_SetObjectMaterial(MapFixObjects[642], 0, 0, "none", "none", 0);
		MapFixObjects[643] = mf_CreateObject(18980, -595.4387, 1938.997, 16.372, -19.4, 0.3, 76.9, 23.0);
		mf_SetObjectMaterial(MapFixObjects[643], 0, 0, "none", "none", 0);
		MapFixObjects[644] = mf_CreateObject(18762, -601.4393, 1940.452, 27.8096, 0.0, -90.5, -13.5, 13.0);
		mf_SetObjectMaterial(MapFixObjects[644], 0, 0, "none", "none", 0);
		MapFixObjects[645] = mf_CreateObject(18980, -601.78, 1912.5563, 16.372, -19.4, 0.3, 76.9, 23.0);
		mf_SetObjectMaterial(MapFixObjects[645], 0, 0, "none", "none", 0);
		MapFixObjects[646] = mf_CreateObject(18762, -604.6, 1927.2613, 27.8096, 0.0, -90.5, -13.5, 13.0);
		mf_SetObjectMaterial(MapFixObjects[646], 0, 0, "none", "none", 0);
		MapFixObjects[647] = mf_CreateObject(18762, -607.7815, 1914.0113, 27.8096, 0.0, -90.5, -13.5, 13.0);
		mf_SetObjectMaterial(MapFixObjects[647], 0, 0, "none", "none", 0);
		MapFixObjects[648] = mf_CreateObject(18980, -603.372, 1905.9567, 16.372, -19.4, 0.3, 76.9, 23.0);
		mf_SetObjectMaterial(MapFixObjects[648], 0, 0, "none", "none", 0);
		MapFixObjects[649] = mf_CreateObject(18980, -600.2116, 1919.1474, 16.372, -19.4, 0.3, 76.9, 23.0);
		mf_SetObjectMaterial(MapFixObjects[649], 0, 0, "none", "none", 0);
		MapFixObjects[650] = mf_CreateObject(18762, -606.2122, 1920.6024, 27.8096, 0.0, -90.5, -13.5, 13.0);
		mf_SetObjectMaterial(MapFixObjects[650], 0, 0, "none", "none", 0);
		MapFixObjects[651] = mf_CreateObject(18762, -609.3726, 1907.4117, 27.8096, 0.0, -90.5, -13.5, 13.0);
		mf_SetObjectMaterial(MapFixObjects[651], 0, 0, "none", "none", 0);
		MapFixObjects[652] = mf_CreateObject(18980, -609.2677, 1919.7518, 27.7857, -90.0, 0.0, -13.5, 23.0);
		mf_SetObjectMaterial(MapFixObjects[652], 0, 0, "none", "none", 0);
		MapFixObjects[653] = mf_CreateObject(18980, -606.9364, 1929.4665, 27.7857, -90.0, 0.0, -13.5, 23.0);
		mf_SetObjectMaterial(MapFixObjects[653], 0, 0, "none", "none", 0);
	#endif
	#if !defined DISABLE_MAPFIX_PLACE_156
		MapFixObjects[654] = mf_CreateObject(3084, 2843.2, -2042.6, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[655] = mf_CreateObject(3084, 2843.2, -2055.0, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[656] = mf_CreateObject(3084, 2840.0, -2042.6, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[657] = mf_CreateObject(3084, 2840.0, -2055.0, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[658] = mf_CreateObject(3084, 2843.1, -1974.9, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[659] = mf_CreateObject(3084, 2843.1, -1987.3, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[660] = mf_CreateObject(3084, 2843.4, -1885.3, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[661] = mf_CreateObject(3084, 2843.4, -1897.7, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[662] = mf_CreateObject(3084, 2837.4, -1896.1, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[663] = mf_CreateObject(3084, 2837.4, -1908.5, 9.82, -90.0, 180.0, -90.0, 14.0);
		MapFixObjects[664] = mf_CreateObject(3084, 2837.4, -1920.9, 9.82, -90.0, 180.0, -90.0, 14.0);
	#endif
	#undef mf_CreateObject
	#undef mf_SetObjectMaterial
	#undef mf_CreateFloorObject
	return 1;
}

forward DestroyMapFixObjects();
public DestroyMapFixObjects()
{
	for(new i = sizeof(MapFixObjects) - 1; i >= 0; --i)
	{
		if(MapFixObjects[i])
		{
			switch(i)
			{
				case 97, 276..278, 384, 508, 541..544, 554, 555: mf_DestroyFloorObject(MapFixObjects[i]);
				default: mf_DestroyObject(MapFixObjects[i]);
			}
			MapFixObjects[i] = 0;
		}
	}
	#undef mf_DestroyObject
	#undef mf_DestroyFloorObject
	return 1;
}
