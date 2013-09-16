package architecture.components 
{
	import architecture.base.IEntity;
	import architecture.base.IPhysicsComponent;
	import architecture.entities.Lazer;
	import Box2D.Dynamics.b2Body;
	
	/**
	 * ...
	 * @author Graham
	 */
	public class LazerPhysics implements IPhysicsComponent 
	{	
		public var _entity:IEntity
		public var _body:b2Body;
		
		public function LazerPhysics(b:b2Body) 
		{
			_body = b;
		}
		
		/* INTERFACE architecture.base.IPhysicsComponent */
		
		public function beginContact(other:b2Body):void 
		{
			switch(other.GetUserData().getID())
			{
					case 0:
						{
							break;
						}
					case 2:
						{
							(_entity as Lazer).fire();
							break;
						}
			}
			
		}
		
		public function endContact(other:b2Body):void 
		{
			
		}
		
		public function get body():b2Body 
		{
			return _body;
		}
		
		public function set body(input:b2Body):void 
		{
			_body = input
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