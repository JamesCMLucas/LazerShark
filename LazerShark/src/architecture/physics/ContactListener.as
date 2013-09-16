package architecture.physics 
{
import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import Assets;
	
	/**
	 * ...
	 * @author James
	 */
	public class ContactListener extends b2ContactListener
	{
		
		
		public function ContactListener() 
		{
			
		}
		
		
		
		
		
		override public function BeginContact(contact:b2Contact):void
		{
			if ( !contact.IsTouching() )
			{
				return;
			}
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();
				bodyA.GetUserData().physics.beginContact(bodyB);
				return;
			
			
			/*if ( ( contact.GetFixtureA().GetBody() != null ) && ( contact.GetFixtureB().GetBody() != null ) )
			{
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();
				bodyA.GetUserData().PhysicsData.BeginContact(bodyB);
				return;
				if ( contact.GetFixtureA().IsSensor()  != contact.GetFixtureB().IsSensor())
				{
					
					if (contact.GetFixtureA().IsSensor())
					{
						//bodyA.GetUserData().setPrimed(true);
						//Assets.vecToRender.push(bodyA.GetUserData());
						bodyA.GetUserData().PhysicsData.BeginContact(bodyB);
					}
					else 
					{
						//bodyB.GetUserData().setPrimed(true);
						//Assets.vecToRender.push(bodyB.GetUserData());
						(Shape)(bodyB.GetUserData()).PhysicsData.BeginContact(bodyA);
					}
					
				}
				else if ( !contact.GetFixtureA().IsSensor() && !contact.GetFixtureB().IsSensor())
				{
					//bodyA.GetUserData().setForDel();
					//bodyB.GetUserData().setForDel();
					
				}
			}
				
			*/
		}
		
		
		override public function EndContact(contact:b2Contact):void
		{
			/*if ( ( contact.GetFixtureA().GetBody() != null ) && ( contact.GetFixtureB().GetBody() != null ) )
			{
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();
				bodyA.GetUserData().PhysicsData.EndContact(bodyB);
				return;
				if ( contact.GetFixtureA().IsSensor() != contact.GetFixtureB().IsSensor())
				{
					
					if (!contact.GetFixtureA().IsSensor())
					{
						//bodyA.GetUserData().setPrimed(false);
						//Assets.vecToRemove.push(bodyA.GetUserData());
						bodyB.GetUserData().PhysicsData.EndContact(bodyA);
					}
					else
					{
						//bodyB.GetUserData().setPrimed(false);
						//Assets.vecToRemove.push(bodyB.GetUserData());
						bodyA.GetUserData().PhysicsData.EndContact(bodyB);
					}
				}
				else
				{
					//something was eaten
				}
				
			}/**/
		
			
		}
		
		//override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void
		//{
			/*
			if ( (contact.GetFixtureA() != null) && (contact.GetFixtureB() != null) )
			{
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();
				
				if ( (bodyA != null) && (bodyB != null) )
				{
					if (bodyA.GetType() == b2Body.b2_kinematicBody)
					{
						bodyA.SetPositionAndAngle(new b2Vec2(0.0, 0.0), 0.0);
					}
				}
			}
			*/
		//}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void
		{
			/*
			if ( (contact.GetFixtureA() != null) && (contact.GetFixtureB() != null) )
			{
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();
				
				if ( (bodyA != null) && (bodyB != null) )
				{
					if (bodyA.GetType() == b2Body.b2_kinematicBody)
					{
						bodyA.SetPositionAndAngle(new b2Vec2(0.0, 0.0), 0.0);
					}
				}
			}
			*/
		}
	}

}