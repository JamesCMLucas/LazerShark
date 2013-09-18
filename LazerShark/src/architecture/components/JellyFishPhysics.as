package architecture.components 
{
	import architecture.base.IEntity;
	import architecture.base.IPhysicsComponent;
	import architecture.entities.JellyFish;
	import architecture.entities.Lazer;
	import architecture.entities.Shark;
	import Box2D.Dynamics.b2Body;
	
	/**
	 * ...
	 * @author Graham
	 */
	public class JellyFishPhysics implements IPhysicsComponent 
	{
		
		public var _entity:IEntity
		public var _body:b2Body;
		
		public function JellyFishPhysics( b:b2Body) 
		{
			_body = b;
		}
		
		/* INTERFACE architecture.base.IPhysicsComponent */
		
		public function beginContact(other:b2Body):void 
		{
			
			if ( other.GetUserData() is Shark)
			{
				(_entity as JellyFish).getGraphics().setVisible(true);
			}
			else if ( other.GetUserData() is Lazer )
			{
				(_entity as JellyFish).shot();
			}
		}
		
		public function endContact(other:b2Body, isSensor:Boolean):void 
		{
			if ( other.GetUserData() is Shark)
			{
				(_entity as JellyFish).getGraphics().offScreen = true;
			}
		}
		
		public function get body():b2Body 
		{
			return _body;
		}
		
		public function set body(input:b2Body):void 
		{
			_body = input;
		}
		
		public function get entity():IEntity 
		{
			return _entity;
		}
		
		public function set entity(value:IEntity):void 
		{
			_entity = value;
			_body.SetUserData(_entity);
		}
		
	}

}