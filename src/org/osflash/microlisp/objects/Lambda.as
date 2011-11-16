package org.osflash.microlisp.objects
{
	public class Lambda extends MLObject
	{
		
		public var args:ML_Object;
		public var sexp:ML_Object;
		
		public function Lambda(args:ML_Object, sexp:ML_Object)
		{	
			this.args = args;
			this.sexp = sexp;
			this._type = MLObject.TYPE_LAMBDA;
			
		}
	}
}