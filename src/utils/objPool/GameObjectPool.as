package utils.objPool
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class GameObjectPool
	{
		/**
		 * 通过对象池来创建该类型的实例 有可能是废旧的
		 * @param objClass
		 * @return
		 *
		 */
		private static var poolDic:Dictionary=new Dictionary(true);		
		private static var temp:int;
		
		//key:ClassName(类型名称) value:Vector.<Object>
		public static function createObject(objClass:Class):Object
		{
			var className:String = getQualifiedClassName(objClass);
			if(!poolDic[className])
			{
				poolDic[className] = new Vector.<Object>();
				//生成一个存放该类型实例的数组池
			}
			return creatStart(poolDic[className],objClass)
		}
		
		/**
		 * 将消除的实例回收 存在内存池中
		 * @param obj 对象实例
		 *
		 */
		public static function recoverObject(obj:Object):void
		{
			var className:String=getQualifiedClassName(obj);
			if(!poolDic[className])
			{
				poolDic[className]=new Vector.<Object>();
				//生成一个存放该类型实例的数组池
			}
			poolDic[className].push(obj);
		}
		
		/**
		 * 正式从此数组中生产对象
		 * @param list 该类型对象池
		 * @param objClass 该类型
		 *
		 */
		private static function creatStart(list:Vector.<Object>,objClass:Class):Object
		{
			if(list.length>0)//大于0表示有旧的实例可以利用
			{
				return list.pop();
			}
			return new objClass();
		}
	}
}