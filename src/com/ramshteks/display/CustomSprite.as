package com.ramshteks.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class CustomSprite extends Sprite
	{
		public static var TRACE_RENDERERS:Boolean = false;
		
		protected const GLOBAL_RENDER_MARK:String = "CustomSprite_GLOBAL_RENDER_MARK";
		private var _invalidateMarks:Array = [];
		
		private var _listenersAlreadyExist:Boolean = false;
		
		public function CustomSprite() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_invalidateMarks[GLOBAL_RENDER_MARK] = true;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			onCustomAddedToStage();
		}
		
		protected function onCustomAddedToStage():void 
		{
			
		}
		
		protected final function invalidate(...marks:Array):void {
			if (stage) {
				if(marks){
					for each(var mark:String in marks) {
						_invalidateMarks[mark] = true;
					}
				}
				
				stage.invalidate();
				if (!_listenersAlreadyExist) {
					addEventListener(Event.RENDER, onRender);
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
					_listenersAlreadyExist = true;
				}
				
			}
		}
		
		private function onEnterFrame(e:Event):void 
		{
			onRender(e);
		}
		
		private function onRender(e:Event):void 
		{
			removeEventListener(Event.RENDER, onRender);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_listenersAlreadyExist = false;
			
			for (var mark:String in _invalidateMarks) {
				if(TRACE_RENDERERS)trace(this, "onRender");
				onCustomRender(mark);
			}
			
			clearRenderMarks();
		}
		
		protected function onCustomRender(mark:String = GLOBAL_RENDER_MARK):void 
		{
			
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			removeEventListener(Event.RENDER, onRender);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			onCustomRemovedFromStage();
		}
		
		private function clearRenderMarks():void 
		{
			for each(var key:String in _invalidateMarks) {
				delete _invalidateMarks[key];
			}
			
			_invalidateMarks[GLOBAL_RENDER_MARK] = true;
		}
		
		protected function onCustomRemovedFromStage():void 
		{
			trace(this, "not overrided CustomSprite.onCustomRemovedFromStage");
		}
		
		public function removeAllChildren():void {
			while (numChildren != 0) removeChildAt(numChildren - 1);
		}
		
	}

}