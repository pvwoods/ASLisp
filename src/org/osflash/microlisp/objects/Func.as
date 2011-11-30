package org.osflash.microlisp.objects
{
	public class Func extends MLObject
	{
		public var func:Function;
		
		public function Func(func:Function)
		{	
			this.func = func;
			this._type = MLObject.TYPE_FUNC;
		}
	}
}