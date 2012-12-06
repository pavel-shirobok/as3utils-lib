package com.ramshteks.as3 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class StringUtils 
	{
		private static const regexVar:RegExp = /%[A-Za-z]*%/;
		
		/**
		 * Modified and return string, user var name having format "%varname%"
		 * @example StringUtils.printf("Some text, %var%, %var2%, %var%", 1, "test", {});
		 * return "Some text, 1, test, [object Object]"
		 * @param	string formatted string
		 * @param	...args arguments to insert into 
		 * @return modified string
		 */
		public static function printf(string:String, ...args):String {
			var res:String = string;
			for each(var p:String in args) {
				res = res.replace(regexVar, p);
			}
			
			return res;
		}
		
		/**
		 * Cutting string, and adding @param ending in end of string
		 * 
		 * @example StringUtils.cut("Text", 4, "...");//return "T..."
		 * 
		 * @param	str input string
		 * @param	max max chars in result string, including length of @param ending
		 * @param	ending string adding into end of string
		 * @return string
		 */
		static public function cut(str:String, max:int, ending:String="..."):String 
		{
			var res:String = str;
			
			if (str.length > max - ending.length) {
				res = res.substr(0, max - ending.length) + ending;
			}
			return res;
		}
		
		static public function printfwv(string:String, vars:Object):String {
			if (vars == null) return string;
			
			const NOT_EXIST:int = -1;
			
			const ALPHABET:String = "qwertyuiopasdfghjklzxcvbnm_1234567890";
			const S_TEXT:int = 1;
			const S_VAR:int = 2;
			const PREFIX:String = "%";
			
			var src:String = string;
			var buffer:String = "";
			var state:int = S_TEXT;
			var var_buff:String = "";
			var c:String;
			
			for (var i:int = 0, len:int = src.length; i < len; i++) {
				c = src.charAt(i);
				
				switch(state) {
					case S_TEXT:
						if (PREFIX == c) {
							state = S_VAR;
						}else {
							buffer += c;
						}
						break;
						
					case S_VAR:
						if (ALPHABET.indexOf(c) != NOT_EXIST) {
							var_buff += c;
						}else {
							if (c == PREFIX) {
								var correct_object:Boolean = true;
								try {
									vars[var_buff];
									if (vars[var_buff] == undefined) correct_object = false;
								}catch (e:Error) {
									correct_object = false;
									trace("warning: was catched exception when using source-object:" + e.message);
								}
								
								if (!correct_object){
									buffer += PREFIX + var_buff;
									var_buff = "";
									i--;
									state = S_TEXT;
								}else {
									buffer += vars[var_buff];
								}
							}else{
								buffer += PREFIX + var_buff + c;
							}
							var_buff = "";
							state = S_TEXT;
						}
						break;
				}
			}
			
			if (state == S_VAR) {
				buffer += PREFIX + var_buff;
			}
			
			return buffer;
		}
		
		static public function merge(...objs:Array):String 
		{
			return objs.join(', ');
		}
		
		/*private static var _tf:TextField = new TextField();
		static public function html_str_len(string:String):int {
			_tf.htmlText = string;
			return _tf.length;
		}*/
		
		static public function html_special_chars(string:String):String {
			var buffer:String = "";
			for (var i:int = 0, len:int = string.length; i < len; i++) {
				buffer += getHtmlSpecialCharPseudoOrNoChange(string.charAt(i));
			}
			return buffer;
		}
		
		static public function getRandomString(len:int):String 
		{
			var alphabet:String = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
			var res:String = "";
			
			for (var i:int = 0; i < len; i++) {
				res = res.concat(alphabet.charAt(alphabet.length * Math.random()));
			}
			
			return res;
		}
		
		private static const special_chars:Array = [  {c:"<", r:"&lt;"},
												    {c:">", r:"&gt;"},
													{c:"&", r:"&amp;"} ];
		private static function getHtmlSpecialCharPseudoOrNoChange(c:String):String {
			for each(var o:Object in special_chars) if (o.c == c) return o.r;
			return c;
		}
		
		/*
		static public function check(str:String, rule:Function):Boolean {
			return false;
		}
		
		static public function multicheck(str:String, rules:Function):Boolean {
			return false;
		}
		
		static public function rule_htmlchars(str:String):Boolean{
			
		}*/
		
	}

}