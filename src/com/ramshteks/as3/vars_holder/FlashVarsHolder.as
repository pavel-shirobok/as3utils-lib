package com.ramshteks.as3.vars_holder 
{
	import flash.display.Stage;

	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class FlashVarsHolder implements IVarsHolder 
	{
		private var _params:Object;
		public function FlashVarsHolder(stage:Stage) 
		{
			_params = stage.loaderInfo.parameters as Object;
		}
		
		public function getKeys():Array {
			var keys:Array = [];
			for (var key:String in _params) {
				keys.push(key);
			}
			return keys;
		}
		
		public function hasValue(name:String):Boolean {
			return getVar(name) != "";
		}
		
		public function getVar(name:String):String 
		{
			if (_params[name] == undefined) {
				return "";
			}
			
			return String(_params[name]);
		}
		
	}

}