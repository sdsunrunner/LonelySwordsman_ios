package utils.objPool
{
	/**
	 * 池属性--池对象 
	 * @author yao yf
	 */
	public class Reusable 
	{
		/**
		 * DisplayObject 对象 子SWF
		 */
		public var object:Object;
		/**
		 * 对象池唯一给予对象的标识符
		 */
		public var name:String;
		/**
		 * 新建一个Reusable对象
		 * @param   _obj 放入的对象 
		 * @param   _name 对象的标识
		 */
		public function Reusable(_obj:Object, _name:String):void 
		{
			if (_name == "") 
			{
				throw new Error("对象标识不能为空！");
				return;
			}
			object = _obj;
			name = _name;
		}
	}
}