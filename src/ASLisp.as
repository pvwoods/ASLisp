package
{
	import flash.display.Sprite;
	
	import org.osflash.microlisp.MicroLispInterpreter;
	import org.osflash.microlisp.io.SimpleStringScanner;
	
	public class ASLisp extends Sprite
	{
		public function ASLisp()
		{
			var mli:MicroLispInterpreter = new MicroLispInterpreter(new SimpleStringScanner("(QOUTE A)"));
		}
	}
}