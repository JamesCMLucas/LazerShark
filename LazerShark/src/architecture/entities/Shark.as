package architecture.entities 
{
	import architecture.base.IPhysicsComponent;
	import architecture.base.IEntity;
	import architecture.base.IGraphicsComponent;
	import architecture.components.SharkGraphics;
	import architecture.components.SharkInput;
	import architecture.components.SharkPhysics;
	import architecture.base.PhysicsManager;
	
	import flash.media.Sound;
	/**
	 * ...
	 * @author James
	 */
	public class Shark implements IEntity
	{
		private var id:int = -1;
		private var bAlive:Boolean = true;
		public var lazerSound:Sound;
		public var lazer:Lazer;
		public var graphics:SharkGraphics;
		public var physics:SharkPhysics;
		public var input:SharkInput;
		
		public function Shark(theID:int,g:SharkGraphics,p:SharkPhysics,i:SharkInput) 
		{
			id = theID;
			bAlive = true;
			lazer = new Lazer();
			
			graphics = g;
			if (graphics == null)
			{
				throw new ArgumentError("SharkGraphics cannot be null");
			}
			graphics.entity = this;
			
			physics = p;
			
			if (physics == null)
			{
				throw new ArgumentError("SharkPhysics cannot be null");
			}
			physics.entity = this;
			
			input = i;
			if (input == null)
			{
				throw new ArgumentError("SharkInput cannot be null");
			}
			input.entity = this;
		}
		
		public function getID():int
		{
			return id;
		}
		
		public function update(dt:Number):void
		{
			input.update(dt);
			
			var maxAngularVelocity:Number = 3.14159;
			
			var currentAngle:Number = physics.body.GetAngle();
			var dTheta:Number = input.targetAngle - currentAngle;
			var omega:Number = dTheta / dt;
			if (omega > maxAngularVelocity)
			{
				omega = maxAngularVelocity;
			}
			else if (omega < -maxAngularVelocity)
			{
				omega = -maxAngularVelocity;
			}
			physics.body.SetAngularVelocity(omega);
			
			graphics.setTilt(input.tilt);
			
			PhysicsManager.setPositionAngle(graphics, physics.body);
			
			//graphics.rotation = physics.body.GetAngle();
		}
		
		public function isAlive():Boolean
		{
			return bAlive;
		}
		
		public function fireLazer():void
		{
			lazer.fire();
		}
		
		/* INTERFACE architecture.base.IEntity */
		
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