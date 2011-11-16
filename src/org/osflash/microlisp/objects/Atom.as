package org.osflash.microlisp.objects
{
	public class Atom extends MLObject
	{
		
		public var name:String;
		
		public function Atom(name:String)
		{
			this.name = name;
			this._type = MLObject.TYPE_ATOM;
		}
		
		override public function toString():String{
			return super.toString() + "[name :: '" + name + "']";
		}
		
	}
}