package org.osflash.microlisp.io
{
	public class SimpleStringScanner implements IInputScanner
	{
		
		protected var _input:String;
		
		public function SimpleStringScanner(input:String):void
		{
			
			_input = input;
			
		}
		
		public function getChar():String{
			if(hasInput){
				var temp:String = _input.slice(0,1);
				_input = _input.slice(1, _input.length);
				return temp;
			}
			return null;
		}
		
		public function getCharsTo(...args):String{
			if(hasInput){
				
				var temp:Array = [];
				var runningCount:int = 0;
				var index:int = -1;
				
				for each(var char:String in args) temp.push(_input.indexOf(char));
				
				for each(var a:int in temp) runningCount += a;
				
				if(runningCount == -temp.length)
					return null;
				else
					for each(var b:int in temp) index = (b != -1 && (b < index || index == -1)) ? b:index;
				
				var result:String = _input.slice(0,index);
				
				_input = _input.slice(index, _input.length);
				
				return result;
			}
			return null;
		}
		
		
		public function get hasInput():Boolean{
			return _input.length > 0;
		}
		
		public function prependInput(ch:String):void{
			_input = ch + _input;
		}
		
		public function appendInput(ch:String):void{
			_input += ch;
		}
		
	}
}