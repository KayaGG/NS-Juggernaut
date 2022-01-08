global function GamemodeJugg_Init

/*scruct {

} file*/

void function GamemodeJugg_Init()
{
    //Gamemode settings
	SetShouldUsePickLoadoutScreen( true )
	SetSwitchSidesBased( false )
	SetRoundBased( false )
	SetRespawnsEnabled( false )
	Riff_ForceSetEliminationMode( eEliminationMode.PilotsTitans )
	Riff_ForceSetSpawnAsTitan( eSpawnAsTitan.Always ) //remove this
	SetShouldUseRoundWinningKillReplay( true )
	SetRoundWinningKillReplayKillClasses( true, false ) // only track pilot->titan kills
	ScoreEvent_SetupEarnMeterValuesForTitanModes()
	SetLoadoutGracePeriodEnabled( false )
	FlagSet( "ForceStartSpawn" )

	//AddCallback_OnPilotBecomesTitan( RefreshThirtySecondWallhackHighlight )
	//AddCallback_OnTitanBecomesPilot( RefreshThirtySecondWallhackHighlight )

	//SetTimeoutWinnerDecisionFunc( CheckTitanHealthForDraw )
	TrackTitanDamageInPlayerGameStat( PGS_ASSAULT_SCORE )

	ClassicMP_SetCustomIntro( ClassicMP_DefaultNoIntro_Setup, ClassicMP_DefaultNoIntro_GetLength() )
	ClassicMP_ForceDisableEpilogue( true )
	//AddCallback_GameStateEnter( eGameState.Playing, WaitForThirtySecondsLeft )


	InitializeTeams()
}

void function InitializeTeams(){
	array<entity> players = GetPlayerArray()

	foreach( entity player in players ){
		SetTeam( player, TEAM_MILITIA )
		RespawnAsPilot( player )
	}

	SetTeam( players[ RandomInt( players.len() ) ], TEAM_IMC )

	RespawnAsTitan( GetPlayerArrayOfTeam( TEAM_IMC )[0] )

	entity titan = GetPlayerArrayOfTeam( TEAM_IMC )[0].GetTitan()

	titan.SetHealth(1000000000)
}