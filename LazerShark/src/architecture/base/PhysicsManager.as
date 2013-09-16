package architecture.base 
{
	import architecture.physics.ContactListener;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2NullContact;
	import starling.display.Image;
	
	import jlmath.MathConst;
	
	/**
	 * ...
	 * @author James
	 */
	public class PhysicsManager 
	{
		public static var world:b2World = null;
		public static var velocityIterations:int = 2;
		public static var positionIterations:int = 3;
		public static var dt:Number = 1.0 / 30.0;
		// the bodies flagged for death
		private static var killingFloor:Vector.<b2Body>;
		
		private static var _pixelsPerMetre:Number = 30;
		private static var _metresPerPixel:Number = 1.0 / _pixelsPerMetre;
		
		public static function get pixelsPerMetre():Number
		{
			return _pixelsPerMetre;
		}
		public function set pixelsPerMetre(ppm:Number):void
		{
			_pixelsPerMetre = ppm;
			_metresPerPixel = 1.0 / _pixelsPerMetre;
		}
		
		public static function get metresPerPixel():Number
		{
			return _metresPerPixel;
		}
		public function set metresPerPixel(mpp:Number):void
		{
			_metresPerPixel = mpp;
			_pixelsPerMetre = 1.0 / _metresPerPixel;
		}
		public static function init():void
		{
			world = new b2World(new b2Vec2(), true);
			world.SetContactListener(new ContactListener())
			killingFloor = new Vector.<b2Body>();
		}
		
		public static function setPositionAngle(im:Image, b:b2Body):void
		{
			im.x = b.GetPosition().y * _pixelsPerMetre;
			im.y = b.GetPosition().x * _pixelsPerMetre;
			im.rotation = -b.GetAngle() + MathConst.Pi_Div_2;
		}
		
		public static function step():void
		{
			if (world)
			{
				// get rid of the dead bodies first
				for (var i:int = 0; i < killingFloor.length; i++)
				{
					world.DestroyBody(killingFloor[i]);
				}
				killingFloor.length = 0;
				
				// do a time step
				world.Step(dt, velocityIterations, positionIterations);
			}
		}
		
		public static function sendToTheKillingFloor(body:b2Body):void
		{
			killingFloor.push(body);
		}
	}

}