package architecture.entities 
{
	import architecture.base.IEntity;
	import architecture.base.IGraphicsComponent;
	import architecture.base.IPhysicsComponent;
	import architecture.base.PhysicsManager;
	import architecture.components.JellyFishGraphics;
	import architecture.components.JellyFishPhysics;
	/**
	 * ...
	 * @author James
	 */
	public class JellyFish implements IEntity
	{
		private var id:int = -1;
		private var bAlive:Boolean = true;
		//public var lazerSound:Sound;
		public var graphics:JellyFishGraphics;
		public var physics:JellyFishPhysics;
		
		
		public function JellyFish(theID:int, g:JellyFishGraphics, p:JellyFishPhysics)
		{
			id = theID;
			bAlive = true;
			
			
			graphics = g;
			if (graphics == null)
			{
				throw new ArgumentError("JellyFishGraphics cannot be null");
			}
			graphics.entity = this;
			
			physics = p;
			
			if (physics == null)
			{
				throw new ArgumentError("JellyFishPhysics cannot be null");
			}
			physics.entity = this; 
		
			
		}

		public function getID():int
		{
			return id;
		}
		public function shot():void
		{
			bAlive = false;
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