package com.ramshteks.utils {
	public function updateAfterEvent():void {
		mouseEvent.updateAfterEvent();
	}
}

import flash.events.MouseEvent;
internal class mouseEvent 
{
	public static const event:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OVER);
	public static function updateAfterEvent():void {
		event.updateAfterEvent();
	}
}