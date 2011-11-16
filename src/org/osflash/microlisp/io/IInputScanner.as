package org.osflash.microlisp.io
{
	public interface IInputScanner
	{
		function getChar():String;
		function getCharsTo(...args):String;
		function get hasInput():Boolean;
		function prependInput(ch:String):void;
		function appendInput(ch:String):void;
	}
}