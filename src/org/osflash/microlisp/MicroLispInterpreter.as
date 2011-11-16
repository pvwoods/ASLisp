package org.osflash.microlisp
{
	import org.osflash.microlisp.io.*;
	import org.osflash.microlisp.objects.*;

	public class MicroLispInterpreter
	{
		// Primitives
		public static const _T:Atom = new Atom("#T");
		public static const _NIL:Cons = new Cons(null, null);
		
		protected var _input:IInputScanner;
		
		
		public function MicroLispInterpreter():void{
		
			_input = new SimpleStringScanner("(QOUTE A)");
			while(_input.hasInput) trace(read(_input).toString());
			
		}
		
		public function read(sc:IInputScanner):MLObject{
			
			var atom:Atom = getNextAtom(sc);
			if(atom.name == "(") return readTail(sc);
			return atom;
			
		}
		
		protected function readTail(sc:IInputScanner):MLObject{
			
			var atom:Atom = getNextAtom(sc);
		    
            return atom.name == ")" ? null:(new Cons(atom.name == "(" ? readTail(sc):atom, readTail(sc));	
		}
		
		protected function getNextAtom(sc:IInputScanner):Atom{
			
			var char:String;
			do { char = sc.getChar() } while(char != null && char == " ");
			
			// there are no more tokens to parse
			if(char == null || (char == "\n" && !sc.hasInput)) return null;
			
			// open bracket atom
			if(char == "(") return new Atom("(");
			
			// close bracket atom
			if(char == ")") return new Atom(")");
			
			var ba:String = (char == " " ? "":char) + sc.getCharsTo(' ', ')');
			
			return ba == null ? null:new Atom(ba);
			
			
		}
		
	}
}
