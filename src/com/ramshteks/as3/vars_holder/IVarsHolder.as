package com.ramshteks.as3.vars_holder 
{
	
	/**
	 * ...
	 * @author Shirobok Pavel (ramshteks@gmail.com)
	 */
	public interface IVarsHolder 
	{
		function getVar(name:String):String;
		function hasValue(name:String):Boolean;
	}
	
}