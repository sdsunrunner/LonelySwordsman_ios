package game.command.initGameLev.initScenceRes
{
	import frame.command.cmdInterface.INotification;
	
	import game.command.GameBaseAsyncCommand;
	import game.interactionType.CommandViewType;
	import game.scenceInterac.fallRockMaker.FallRockRemoveScensor;
	import game.scenceInterac.fallRockMaker.FallRockScensor;
	import game.scenceInterac.fallRockMaker.RockPlatform;
	import game.scenceInterac.ladder.LadderPlatform;
	import game.scenceInterac.ladder.LadderSensor;
	import game.scenceInterac.movingPlatform.LandscapePlatform;
	import game.scenceInterac.trap.ExplodeTrapScensor;
	import game.scenceInterac.trap.TrapPlatform;
	import game.scenceInterac.trap.TrapScensor;
	import game.view.boss.finalBoss.FinalBossView;
	import game.view.boss.monster.Monster;
	import game.view.destructibleItem.DestructibleTerrainPillar;
	import game.view.enemySoldiers.animals.AnimalSoldierEnemy;
	import game.view.enemySoldiers.basis.BaseSoldierEnemy;
	import game.view.enemySoldiers.tall.TallSoldierEnemy;
	import game.view.enemySoldiers.twoKnives.TwoKnivesSoldierEnemy;
	import game.view.enviEnemy.bici.BiCiEnemy;
	import game.view.enviEnemy.dici.DiCiEnemy;
	import game.view.enviEnemy.fallenRock.FallenRock;
	import game.view.gameHeroView.SwordsmanView;
	import game.view.gameInnerGui.GameInnerMenu;
	import game.view.gameScenceView.scenceSensor.ScenceEndSensor;
	import game.view.scenceOrnament.closeShot.Scence1CloseShot;
	import game.view.scenceOrnament.closeShot.Scence2CloseShot;
	import game.view.scenceOrnament.closeShot.Scence5CloseShot;
	import game.view.scenceOrnament.closeShot.ScenceSurvivalCloseShot;
	import game.view.scenceOrnament.mapOrnament.Scence1MapOrnament;
	import game.view.scenceOrnament.mapOrnament.Scence2MapOrnament;
	import game.view.scenceOrnament.mapOrnament.Scence3MapOrnament;
	import game.view.scenceOrnament.mapOrnament.Scence4MapOrnament;
	import game.view.scenceOrnament.mapOrnament.Scence5MapOrnament;
	import game.view.scenceOrnament.mapOrnament.ScenceBossFightMapOrnament;
	import game.view.scenceOrnament.mapOrnament.ScenceSurvivalMapOrnament;
	import game.view.survivalMode.SurvivalModeEnemyCreater;
	
	/**
	 * 初始化游戏场景 
	 * @author songdu
	 * 
	 */	
	public class InitGameScenceCommand extends GameBaseAsyncCommand
	{
		override public function excute(note:INotification):void
		{
			var widgets:Array = [BaseSoldierEnemy,
				SwordsmanView,
				FinalBossView,
				ScenceEndSensor,
				Scence1CloseShot,
				Scence2CloseShot,
				Scence5CloseShot,
				ScenceSurvivalCloseShot,
				Scence1MapOrnament,	
				Scence2MapOrnament,	
				Scence3MapOrnament,	
				Scence4MapOrnament,	
				Scence5MapOrnament,	
				ScenceBossFightMapOrnament,
				ScenceSurvivalMapOrnament,
				TallSoldierEnemy,
				TwoKnivesSoldierEnemy,
				AnimalSoldierEnemy,
				DestructibleTerrainPillar,
				LadderPlatform,
				LadderSensor,
				LandscapePlatform,
				FallRockScensor,
				RockPlatform,
				FallenRock,
				FallRockRemoveScensor,
				Monster,
				BiCiEnemy,
				DiCiEnemy,
				SurvivalModeEnemyCreater,
				GameInnerMenu,
				TrapPlatform,
				TrapScensor,
				ExplodeTrapScensor
				];
			
			this.notify(CommandViewType.SHOW_GAME_LEVEL_VIEW_SCENCE);
			
			Const.gameInitEd = true;			
		}
	}
}