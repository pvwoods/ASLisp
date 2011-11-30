package org.osflash.microlisp
{
	import org.osflash.microlisp.io.*;
	import org.osflash.microlisp.objects.*;

	public class MicroLispInterpreter
	{
		// Primitives
		public static const _T:Atom = new Atom("#T");
		public static const _NIL:Cons = new Cons(null, null);
		
		public const _ENV:Array = 
			[
				new Cons(new Cons(new Atom("QOUTE"),new Cons(new Func(function(c:Cons):MLObject{return c.car}),null)), null),
				new Cons(new Cons(new Atom("CAR"),new Cons(new Func(function(c:Cons):MLObject{return (c.car as Cons).car}),null)), null),
				new Cons(new Cons(new Atom("CDR"),new Cons(new Func(function(c:Cons):MLObject{return (c.car as Cons).cdr}),null)), null),
				new Cons(new Cons(new Atom("CONS"),new Cons(new Func(function(c:Cons):MLObject{
					var t:Cons = new Cons(c.car, null);
					var a:Cons = (c.cdr as Cons).car as Cons;
					for(var o:MLObject in a.toList()) t.append(o);
					return t;
				}),null)), null),
				new Cons(new Cons(new Atom("EQUAL"),new Cons(new Func(function(c:Cons):MLObject{
					return ((c.car as Atom).name == ((c.cdr as Cons).car as Atom).name) ? _T:_NIL;
				}),null)), null),
				new Cons(new Cons(new Atom("ATOM"),new Cons(new Func(function(c:Cons):MLObject{return (c.car is Atom) ? _T:_NIL}),null)), null),

				new Cons(new Cons(new Atom("COND"),new Cons(new Func(function(c:Cons):MLObject{
					var p:MLObject;
					for(var o:MLObject in c.toList()){
						p = eval((o as Cons).car);
						if(p != _NIL) return eval(((o as Cons).cdr as Cons).car);
					}
					return _NIL;
				}),null)), null),
				/* need to implement LAMBDA*/
				new Cons(new Cons(new Atom("LAMBDA"),new Cons(new Func(function(c:Cons):MLObject{return c}),null)), null),
				/* need to implement LABEL*/
				new Cons(new Cons(new Atom("LABEL"),new Cons(new Func(function(c:Cons):MLObject{return c}),null)), null)
							
			];
		
		protected var _input:IInputScanner;
		
		
		public function MicroLispInterpreter(input:IInputScanner):void{
		
			_input = input;
			while(_input.hasInput) eval(read(_input));
			
		}
		
		public function eval(expression:MLObject):MLObject{
			return new MLObject();
		}
		
		public function read(sc:IInputScanner):MLObject{
			var atom:Atom = getNextAtom(sc);
			if(atom.name == "(") return readTail(sc);
			return atom;
			
		}
		
		protected function readTail(sc:IInputScanner):MLObject{
			var atom:Atom = getNextAtom(sc);
            return atom.name == ")" ? null:(new Cons(atom.name == "(" ? readTail(sc):atom, readTail(sc)));	
		}
		
		protected function getNextAtom(sc:IInputScanner):Atom{
			
			var char:String;
			do { char = sc.getChar() } while(char != null && char == " ");
			
			// there are no more tokens to parse
			if(char == null || (char == "\n" && !sc.hasInput)) return null;
			
			// open/close bracket atom
			if(char == "(" || char == ")") return new Atom(char);
			
			var ba:String = (char == " " ? "":char) + sc.getCharsTo(' ', ')');
			return ba == null ? null:new Atom(ba);
			
			
		}
		
	}
}
