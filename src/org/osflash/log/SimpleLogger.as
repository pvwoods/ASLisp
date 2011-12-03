package org.osflash.log
{
        /**
        * About as simple of a logger as you can get
        **/
        public class SimpleLogger{
            public static var enabled:Boolean = false;

            public static function log(o:*):void{
                if(enabled) trace(o);
            }
        }
}
