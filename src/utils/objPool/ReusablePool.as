package utils.objPool
{
	
	public class ReusablePool
	{
		/**
		 * 
		 */
		private static var reusablePool : ReusablePool;
		/**
		 * 池对象
		 */
		private static var reusable:Reusable;
		/**
		 * 用于存取对象
		 */
		private static var reusableArr:Array = new Array();
		/**
		 * 最大对象数量
		 */
		private static var maxPoolSize:int = 1000;
		/**
		 * @private
		 * 此类为单例 不要实例化
		 * @param   enforcer
		 */
		public function ReusablePool(enforcer:AccessRestriction):void 
		{
			if ( enforcer == null )
			{
				throw new Error("此类为单例 不要实例！" );
			}
		}
		/**
		 * 单例此类
		 * @return ReusablePool
		 */
		public static function getInstance() : ReusablePool 
		{
			if( reusablePool == null ) 
			{
				reusablePool = new ReusablePool(new AccessRestriction());
			}
			return reusablePool;
		}
		/**
		 * 设置最大对象数量
		 * @param   value
		 */
		public function setMaxPoolSize(value:Number):void
		{
			maxPoolSize = value;
		}
		/**
		 * 获取池中对象
		 * @param   name 获取对象的标识字符
		 * @return Reusable对象
		 */
		public function getReusable(name:String):Reusable
		{
			var index:int = -1;
			var len:int = reusableArr.length;
			for (var i:int = 0; i < len; i++)   
			{
				if (reusableArr[i].name == name) 
				{
					index = i;
					break;
				}
			}
			if (index == -1) 
			{
				throw new Error("查询不到此对象-> " + name);
			}
			reusable = new Reusable(reusableArr[index].object, reusableArr[index].name);
			return reusable;
		}
		/**
		 * 存储对象到池中 
		 * @param   reusable
		 */
		public function setReusable(reusable:Reusable):void  
		{
			if (hasReusable(reusable.name)) 
			{
				trace("#重复存储相同对象或对象标识重复！");
				return;
			}
			if (reusableArr.length < maxPoolSize) 
			{
				reusableArr.push({object: reusable.object, name: reusable.name});
			}
			else 
			{
				throw new Error("对象池已满，请清除不需要的对象或设置对象池setMaxPoolSize");  
			}
		}
		/**
		 * 删除池中指定标识的对象
		 * @param name 要删除对象的标识符
		 */
		public function removeReusable(name:String):void 
		{
			var index:int = -1;
			var len:int = reusableArr.length;
			for (var i:int = 0; i < len; i++)  
			{
				if (reusableArr[i].name == name) 
				{
					index = i;
					break;
				}
			}
			if (index == -1) 
			{
				throw new Error("查询不到要删除的对象-> " + name);
				return;
			}
			reusableArr.splice(i, 1);
		}
		
		/**
		 * 检查对象是否在池中
		 * @param name 对象标识
		 * @return Boolean
		 */
		public function hasReusable(name:String):Boolean 
		{
			var len:int = reusableArr.length;
			for (var i:int = 0; i < len; i++)  
			{
				if (reusableArr[i].name == name)
				{
					return true;
					break;
				}
			}
			return false;
		}
	}
}

class AccessRestriction {}