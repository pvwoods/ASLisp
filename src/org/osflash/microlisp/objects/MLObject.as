package org.osflash.microlisp.objects
{
	public class MLObject
	{
		
		public static const TYPE_ATOM:uint = 0;
		public static const TYPE_CONS:uint = 1;
		public static const TYPE_FUNC:uint = 2;
		public static const TYPE_LAMBDA:uint = 3;
		
		protected var _type:uint;
		
		public function get type():uint{
			return _type;
		}
		
		public function toString():String{
			return "[ML_OBJECT_TYPE_" + _type + "]";
		}
		
		
	}
}