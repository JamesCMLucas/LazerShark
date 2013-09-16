package architecture.base 
{
	import starling.events.Touch;
	/**
	 * ...
	 * @author James
	 */
	public interface IInputComponent extends IComponent
	{
		function touch(touch:Touch):void;
		function update(dt:Number):void;
	}

}