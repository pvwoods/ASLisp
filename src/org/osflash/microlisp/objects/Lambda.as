package org.osflash.microlisp.objects
{
	public class Lambda extends MLObject
	{
		
		public var args:MLObject;
		public var sexp:MLObject;
		
		public function Lambda(args:MLObject, sexp:MLObject)
		{	
			this.args = args;
			this.sexp = sexp;
			this._type = MLObject.TYPE_LAMBDA;
			
		}
	}
}