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
		
		public function append(o:MLObject):void{
			var t:Cons = this;
			while(t.cdr) t = t.cdr as Cons;
			t.cdr = new Cons(o, null);
		}
		
		public function toCList():Array{
			var a:Array = [];
			var t:Cons = this;
			while(t != null){
				a.push(t.car);
				t = t.cdr as Cons;
			}
			return a;
		}
		
		override public function toString():String{
			return super.toString() + "[type :: 'cons', \n\tcar:" + (car == null ? "null":car.toString()) + "\n\tcdr:" + (cdr == null ? "null":cdr.toString()) + "]";
		}
	}
}
