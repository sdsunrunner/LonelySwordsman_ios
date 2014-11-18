package utils
{
	import nape.phys.Material;

	/**
	 * 材质工具类 
	 * @author admin
	 * 
	 */	
	public class MaterialUtils
	{
		public static function createEnemyMaterial():Material
		{
			return  new Material(0, 1, 1, 80, 0);
		}
		
		public static function createFianlBossMaterial():Material
		{
			return  Material.steel();
		}
		
		public static function createRockMaterial():Material
		{
			return  new Material(0.5, 1, 1, 100, 100);
		}
	}
}