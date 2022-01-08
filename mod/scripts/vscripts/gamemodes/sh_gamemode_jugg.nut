global function Sh_GamemodeJugg_Init;

global const string GAMEMODE_JUGG = "jugg"

void function Sh_GamemodeJugg_Init()
{
    //Creates custom gamemode
    AddCallback_OnCustomGamemodesInit( CreateGamemodeJugg )
    //AddCallback_OnRegisteringCustomNetworkVars( JuggRegisterNetworkVars )
}

void function CreateGamemodeJugg()
{
    GameMode_Create( GAMEMODE_JUGG )
    GameMode_SetName( GAMEMODE_JUGG, "#GAMEMODE_JUGG" )
    GameMode_SetDesc( GAMEMODE_JUGG, "#PL_jugg_desc")
	GameMode_SetGameModeAnnouncement( GAMEMODE_JUGG, "ffa_modeDesc" ) //temp
    GameMode_SetDefaultTimeLimits( GAMEMODE_JUGG, 20, 0.0 ) // set to 10 minutes later
   	GameMode_AddScoreboardColumnData( GAMEMODE_JUGG, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 )
	GameMode_AddScoreboardColumnData( GAMEMODE_JUGG, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 )
	GameMode_SetColor( GAMEMODE_JUGG, [147, 204, 57, 255] )

    AddPrivateMatchMode( GAMEMODE_JUGG )
	AddPrivateMatchModeSettingEnum( "#GAMEMODE_JUGG", "Juggernaut", [ "#SETTING_DISABLED", "#SETTING_ENABLED" ], "0" )

	GameMode_SetDefaultScoreLimits( GAMEMODE_JUGG, 150, 0 )

	#if SERVER
		GameMode_AddServerInit( GAMEMODE_JUGG, GamemodeJugg_Init )
		GameMode_AddServerInit( GAMEMODE_JUGG, GamemodeFFAShared_Init )
		GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_JUGG, RateSpawnpoints_Generic )
		GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_JUGG, RateSpawnpoints_Generic )
	#elseif CLIENT
		GameMode_AddClientInit( GAMEMODE_JUGG, ClGamemodeJugg_Init )
		GameMode_AddClientInit( GAMEMODE_JUGG, GamemodeFFAShared_Init )
		GameMode_AddClientInit( GAMEMODE_JUGG, ClGamemodeJugg_Init )
	#endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_JUGG, CompareAssaultScore )
		GameMode_AddSharedInit( GAMEMODE_JUGG, GamemodeFFA_Dialogue_Init )
	#endif
}