package architecture.components 
{
	import architecture.base.IEntity;
	import architecture.base.IPhysicsComponent;
	import architecture.entities.JellyFish;
	import architecture.entities.Shark;
	import Box2D.Dynamics.b2Body;
	/**
	 * ...
	 * @author James
	 */
	public class SharkPhysics implements IPhysicsComponent
	{
		protected var _entity:IEntity;
		protected var _body:b2Body;
		
		public function SharkPhysics(b:b2Body) 
		{
			body = b;
		}
		
		/* INTERFACE architecture.base.IPhysicsComponent */
		public function beginContact(other:b2Body):void 
		{
			if (other.GetUserData() is JellyFish)
			{
				//(other.GetUserData() as JellyFish).graphics.setVisible(true);
			}
			
		}
		/* INTERFACE architecture.base.IPhysicsComponent */
		public function endContact(other:b2Body, isSensor:Boolean):void 
		{
			if (other.GetUserData() is JellyFish)
			{
				//(other.GetUserData() as JellyFish).graphics.setVisible(false);
			}
		}
		/* INTERFACE architecture.base.IComponent */
		public function get entity():IEntity 
		{
			return _entity;
		}
		/* INTERFACE architecture.base.IComponent */
		public function set entity(value:IEntity):void 
		{
			_entity = value;
			//changed by Graham will explain when asked
			body.SetUserData(_entity);
		}
		
		//TODO CHANGE GETTERS AND SETTERS TO MATCH 
		public function get body():b2Body 
		{
			return _body;
		}
		
		public function set body(input:b2Body):void 
		{
			_body = input;
		}
		
	}

}