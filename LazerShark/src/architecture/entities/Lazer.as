package architecture.entities 
{
	import architecture.base.IEntity;
	import architecture.base.IGraphicsComponent;
	import architecture.base.IPhysicsComponent;
	import architecture.base.PhysicsManager;
	import architecture.components.LazerGraphics;
	import architecture.components.LazerPhysics;
	import flash.media.Sound;
	/**
	 * ...
	 * @author James
	 */
	public class Lazer implements IEntity
	{
		private var id:int = -1;
		private var bAlive:Boolean = true;
		public var lazerSound:Sound;
		public var graphics:LazerGraphics;
		public var physics:LazerPhysics;
		
		
		protected var fireSound:Sound;
		
		public function Lazer() 
		{
			fireSound = LevelAssets.getSound("Lazer");
		}
		public function LazerSetup(theID:int, g:LazerGraphics, p:LazerPhysics)
		{
			id = theID;
			bAlive = true;
			
			
			graphics = g;
			if (graphics == null)
			{
				throw new ArgumentError("LazerGraphics cannot be null");
			}
			graphics.entity = this;
			
			physics = p;
			
			if (physics == null)
			{
				throw new ArgumentError("LazerPhysics cannot be null");
			}
			physics.entity = this; 
		
			
		}
		
		public function fire():void
		{
				fireSound.play();
		}
		public function getID():int
		{
			return id;
		}
		
		public function update(dt:Number):void
		{
			
			//input.update(dt);
			PhysicsManager.setPositionAngle(graphics, physics.body);
			
		}
		
		public function isAlive():Boolean
		{
			return bAlive;
		}
		public function setAlive( value:Boolean )
		{
			bAlive = value;
		}
		
		public function getGraphics():IGraphicsComponent 
		{
			return graphics;
		}
		
		public function getPhysics():IPhysicsComponent 
		{
			return physics;
		}
		
	}

}