package org.osflash.microlisp.objects
{
	public class Cons extends MLObject
	{
		
		public var car:MLObject;
		public var cdr:MLObject;
		
		public function Cons(car:MLObject, cdr:MLObject)
		{
			
			this.car = car;
			this.cdr = cdr;
			this._type = MLObject.TYPE_CONS;
			
		}
		
		override public function toString():String{
			return super.toString() + "[type :: 'cons', \n\tcar:" + (car == null ? "null":car.toString()) + "\n\tcdr:" + (cdr == null ? "null":cdr.toString()) + "]";
		}
	}
}