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
	//Riff_ForceSetSpawnAsTitan( eSpawnAsTitan.Always ) //remove this
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

	AddCallback_GameStateEnter( eGameState.Playing, InitializeTeams )
	//InitializeTeams()
}

void function InitializeTeams(){

	wait( 4 )

	array<entity> players = GetPlayerArray()

	foreach( entity player in players ){
		SetTeam( player, TEAM_MILITIA )
		//RespawnAsPilot( player )
	}

	SetTeam( players[ RandomIntRange( 0 , players.len() ) ], TEAM_IMC )

	entity boss = GetPlayerArrayOfTeam( TEAM_IMC )[0]

	boss.SetPlayerGameStat( PGS_ASSAULT_SCORE, 0 )
	boss.SetPlayerGameStat( PGS_DEATHS, 0 )

	KillPlayer( boss, eDamageSourceId.fall )
	RespawnAsTitan( boss )


	entity soul = boss.GetTitanSoul()
	entity titan = soul.GetTitan()

	titan.SetMaxHealth( 2500 )
	titan.SetHealth( 25 )
	
	soul.SetShieldHealth( soul.GetShieldHealthMax() )
}
