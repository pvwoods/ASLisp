package org.osflash.microlisp
{
	import org.osflash.microlisp.io.*;
	import org.osflash.microlisp.objects.*;

	public class MicroLispInterpreter
	{
		// Primitives
		public static const _T:Atom = new Atom("#T");
		public static const _NIL:Cons = new Cons(null, null);
		
		public var _ENV:Cons; 
		
		protected var _input:IInputScanner;
		
		
		public function MicroLispInterpreter(input:IInputScanner):void{
			
			buildEnvironment();
			
			_input = input;
			
			while(_input.hasInput) eval(read(_input));
			
		}
		
		public function buildEnvironment():void{
			
			_ENV = new Cons(new Cons(new Atom("QOUTE"),new Cons(new Func(function(c:Cons):MLObject{
				return c.car
			}),null)), null);
				
			_ENV.append(new Cons(new Cons(new Atom("CAR"),new Cons(new Func(function(c:Cons):MLObject{
				return (c.car as Cons).car
			}),null)), null));
			
			_ENV.append(new Cons(new Cons(new Atom("CDR"),new Cons(new Func(function(c:Cons):MLObject{
				return (c.car as Cons).cdr
			}),null)), null));
				
			_ENV.append(new Cons(new Cons(new Atom("CONS"),new Cons(new Func(function(c:Cons):MLObject{
				var t:Cons = new Cons(c.car, null);
				var a:Cons = (c.cdr as Cons).car as Cons;
				for(var o:MLObject in a.toCList()) t.append(o);
				return t;
			}),null)), null));
			
			_ENV.append(new Cons(new Cons(new Atom("EQUAL"),new Cons(new Func(function(c:Cons):MLObject{
				return ((c.car as Atom).name == ((c.cdr as Cons).car as Atom).name) ? _T:_NIL;
			}),null)), null));
			
			_ENV.append(new Cons(new Cons(new Atom("ATOM"),new Cons(new Func(function(c:Cons):MLObject{
				return (c.car is Atom) ? _T:_NIL;
			}),null)), null));
				
			
			_ENV.append(new Cons(new Cons(new Atom("COND"),new Cons(new Func(function(c:Cons):MLObject{
				var p:MLObject;
				for(var o:MLObject in c.toCList()){
					p = eval((o as Cons).car);
					if(p != _NIL) return eval(((o as Cons).cdr as Cons).car);
				}
				return _NIL;
			}),null)), null));
			
			_ENV.append(new Cons(new Cons(new Atom("LAMBDA"),new Cons(new Func(function(c:Cons):MLObject{
				var lam:Lambda = c.car as Lambda;
				var arg:MLObject = c.cdr;
				var t:MLObject = interleave(lam.args as Cons, c);
				var exp:MLObject = replaceAtom(lam.sexp,t);
				return eval(exp);
			}),null)), null));
			
			_ENV.append(new Cons(new Cons(new Atom("LABEL"),new Cons(new Func(function(c:Cons):MLObject{
				_ENV.append(new Cons(new Atom((c.car as Atom).name), new Cons((c.cdr as Cons).car, null)))
				return _T;
			}),null)), null));
		}
		
		public function eval(expression:MLObject):MLObject{
			if(exp is Cons){
				var c:Cons = exp as Cons;
				if((c.car is Atom) && (c.car as Atom).name == "LAMBDA"){
					return new Lambda((c.cdr as Cons).car, ((c.cdr as Cons).cdr as Cons).car); 
				}else{
					return evalFunction();
				}
			}else{
				
			}
			return expression;
		}
		
		public function evalFunction(expression:MLObject):MLObject{
			return expression;
		}
		
		public function interleave(c1:Cons, c2:Cons):MLObject{
			var t:Cons = new Cons(new Cons(c1.car, new Cons(c2.car, null)), null);
			c1 = c1.cdr as Cons;
			c2 = c2.cdr as Cons;
			for(var i:uint = 0; i < c1.toCList().length; i++){
				t.append(new Cons(c1.car, new Cons(c2.car, null)));
				c2 = c2.cdr as Cons;
			}
			return t;
		}
		
		public function toCons(a:Array):Cons{
			var t:Cons;
			for each(var i:MLObject in a){
				if(t == null)
					t = new Cons(i, null);
				else
					t.append(i);
			}
			return t;
		}
		
		public function replaceAtom(exp:MLObject, to:MLObject):MLObject{
			if(exp is Cons){
				var a:Array = [];
				for each(var o:MLObject in (to as Cons).toCList()) a.push(replaceAtom(o, to));
				return toCons(a);
			}else{
				var atom:Atom;
				var replacement:MLObject;
				for each(var b:Cons in (to as Cons).toCList()){
					atom = b.car as Atom;
					replacement = (b.cdr as Cons).car;
					if(atom.name == (exp as Atom).name) return replacement;
				}
			}
			return exp;
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
