package architecture.base 
{
	import Box2D.Dynamics.b2Body;
	
	/**
	 * ...
	 * @author James
	 */
	public interface IPhysicsComponent extends IComponent
	{
		/**
		 * called by the physics manager
		 * @param	other - the other rigid body
		 */
		function beginContact(other:b2Body):void;
		/**
		 * called by the physics manager
		 * @param	other - the other rigid body
		 */
		function endContact(other:b2Body):void;
		
		function get body():b2Body;
		
		function set body(b:b2Body):void;
	}
	
}