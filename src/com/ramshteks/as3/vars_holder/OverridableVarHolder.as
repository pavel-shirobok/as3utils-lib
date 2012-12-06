package com.ramshteks.as3.vars_holder 
{
	/**
	 * ...
	 * @author ramshteks
	 */
	public class OverridableVarHolder implements IVarsHolder 
	{
		private var _source:IVarsHolder;
		
		private var _ovveridedMap:Array = [];
		
		public function OverridableVarHolder(source:IVarsHolder) 
		{
			_source = source;
		}
		
		public function resetOverridedVar(name:String):void {
			_ovveridedMap[name] = null;
			delete _ovveridedMap[name];
		}
		
		public function resetAllOverridedVars():void {
			for (var key:String in _ovveridedMap) {
				_ovveridedMap[key] = null;
				delete _ovveridedMap[key];
			}
		}
		
		public function overrideVar(name:String, value:*):void {
			_ovveridedMap[name] = value;
		}
		
		public function getVar(name:String):String 
		{
			if (_ovveridedMap[name] != null) {
				return String(_ovveridedMap[name]);
			}
			
			return _source.getVar(name);
		}
		
		/* INTERFACE com.ramshteks.as3.vars_holder.IVarsHolder */
		
		public function hasValue(name:String):Boolean 
		{
			if (_ovveridedMap[name] == null) {
				return _source.hasValue(name);
			}
			
			return true;
		}
		
	}

}