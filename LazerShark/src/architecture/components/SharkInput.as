package architecture.components 
{
	import adobe.utils.CustomActions;
	import architecture.base.IEntity;
	import architecture.base.IInputComponent;
	import architecture.entities.Shark;
	import com.adobe.nativeExtensions.Gyroscope;
	import com.adobe.nativeExtensions.GyroscopeEvent;
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import jlmath.MathConst;
	
	/**
	 * ...
	 * @author James
	 */
	public class SharkInput implements IInputComponent
	{
		protected var sharky:Shark;
		protected var gyroscope:Gyroscope;
		
		
		protected var accelerometer:Accelerometer;
		protected var accX:Number = 0.0;
		protected var accY:Number = 0.0;
		protected var accAlpha:Number = 0.8;
		//protected var maxAngle:Number = MathConst.Pi_Div_3;
		public var targetAngle:Number = 0.0;
		public var tilt:Number = 0.0;
		public var speed:Number = 0.0;
		
		protected var maxTilt:Number = 50.0;
		protected var gyroX:Number = 0.0;
		protected var minGyroThreshold:Number = 0.03;
		protected var gyroAlpha:Number = 0.8;
		protected var speedFactor:Number = 150.0;
		
		public function SharkInput() 
		{
			gyroscope = new Gyroscope();
			gyroscope.setRequestedUpdateInterval(0);
			gyroscope.addEventListener(GyroscopeEvent.UPDATE, updateGyro);
			
			accelerometer = new Accelerometer();
			accelerometer.setRequestedUpdateInterval(0);
			accelerometer.addEventListener(AccelerometerEvent.UPDATE, updateAccel);
		}
		
		public function touch(touch:Touch):void
		{
			if (touch.phase == TouchPhase.BEGAN)
			{
				sharky.fireLazer();
			}
		}
		
		public function update(dt:Number):void
		{
			targetAngle = Math.atan2(accY, accX);
			
			
			if (Math.abs(gyroX) < minGyroThreshold)
			{
				return;
			}
			tilt += gyroX * dt * speedFactor;
			
			speed = gyroX * speedFactor;
			
			if (tilt > maxTilt)
			{
				tilt = maxTilt;
			}
			else if (tilt < -maxTilt)
			{
				tilt = -maxTilt;
			}
		}
		
		private function updateAccel(e:AccelerometerEvent):void
		{
			//smoothing
			
			var ax:Number = e.accelerationX;
			var ay:Number = e.accelerationY;
			
			accX *= (1.0 - accAlpha);
			accX += (accAlpha * ax);
			accY *= (1.0 - accAlpha);
			accY += (accAlpha * ay);
		}
		
		private function updateGyro(e:GyroscopeEvent):void
		{
			// smoothing
			var gx:Number = e.x;
			
			gyroX *= (1.0 - gyroAlpha);
			gyroX += (gyroAlpha * gx);
		}
		
		/* INTERFACE architecture.base.IComponent */
		public function get entity():IEntity 
		{
			return sharky;
		}
		
		/* INTERFACE architecture.base.IComponent */
		public function set entity(value:IEntity):void 
		{
			if (value is Shark)
			{
				sharky = value as Shark;
			}
			else
			{
				throw new ArgumentError("SharkInput needs a shark entity, yo");
			}
		}
		
	}

}