package playerData
{
	/**
	 * 初始化数据 
	 * @author admin
	 * 
	 */	
	public class PlayerInitData
	{
		public static const PLAYER_LEV_INIT:String = 
			'<?xml version="1.0" encoding="UTF-8"?>'+
			'	<data>'+
			'	<hero life_count="3" hero_hp="300" hero_mp="300" hp_proto="'
			+Const.HP_PROTO_INIT_COUNT+'" mp_proto="'
			+Const.MP_PROTO_INIT_COUNT+'"/>		'+
			'	<game_lev game_lev_id="-1"/>'+
			'	<ballte_mode  hero_is_un_lock="0"  monster_is_un_lock="0"/>	'+
			'	<surver_best  surver_best="0"/>	'+
			'	<kill_count  kill_count="0"/>	'+
			'	</data>';
	}
}