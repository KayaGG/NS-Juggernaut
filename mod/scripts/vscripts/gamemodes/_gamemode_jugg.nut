global function GamemodeJugg_Init

scruct {

} file

void function GamemodeJugg_Init()
{
    // Gamemode settings
    SetShouldUsePickLoadoutScreen( true )
	SetSwitchSidesBased( false )
	SetRoundBased( false )
	SetRespawnsEnabled( false )
	Riff_ForceSetEliminationMode( eEliminationMode.PilotsTitans )
	Riff_ForceSetSpawnAsTitan( eSpawnAsTitan.Always )
	SetShouldUseRoundWinningKillReplay( true )
	SetRoundWinningKillReplayKillClasses( true, false ) // both titan and pilot kills are tracked
	ScoreEvent_SetupEarnMeterValuesForTitanModes()
	SetLoadoutGracePeriodEnabled( false )
	FlagSet( "ForceStartSpawn" )

	AddCallback_OnPilotBecomesTitan( RefreshThirtySecondWallhackHighlight )
	AddCallback_OnTitanBecomesPilot( RefreshThirtySecondWallhackHighlight )

	SetTimeoutWinnerDecisionFunc( CheckTitanHealthForDraw )
	TrackTitanDamageInPlayerGameStat( PGS_ASSAULT_SCORE )

	ClassicMP_SetCustomIntro( ClassicMP_DefaultNoIntro_Setup, ClassicMP_DefaultNoIntro_GetLength() )
	ClassicMP_ForceDisableEpilogue( true )
	AddCallback_GameStateEnter( eGameState.Playing, WaitForThirtySecondsLeft )
}

