package org.osflash.microlisp.objects
{
	public class Func extends MLObject
	{
		public var func:Object;
		
		public function Func(func:Object)
		{	
			this.func = func;
			this._type = MLObject.TYPE_FUNC;
		}
	}
}