package com.ramshteks.as3.vars_holder 
{

	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public class XMLVarsHolder implements IVarsHolder 
	{
		private var _xml:XMLList;
		
		public function XMLVarsHolder(xml:XMLList) 
		{
			_xml = xml;
			
		}

		public function getVar(name:String):String 
		{
			var result:String = String(_xml[name].@value);
			if (result == "" || result == null) {
				return "";
			}
			return result;
		}
		
		/* INTERFACE com.ramshteks.vars_holder.IVarsHolder */
		
		public function hasValue(name:String):Boolean 
		{
			return false;
		}
		
	}

}