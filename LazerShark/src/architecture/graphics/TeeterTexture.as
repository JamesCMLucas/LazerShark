package architecture.graphics 
{
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author James
	 */
	public class TeeterTexture extends Image
	{
		private var centreFrameIndex:int = 0;
		private var currentFrameIndex:int = 0;
		private var textures:Vector.<Texture>;
		private var tiltRangeVec:Vector.<Number>;
		private var currentTiltValue:Number = 0.0;
		
		public function TeeterTexture(texVec:Vector.<Texture>, maxTilt:Number) 
		{
			textures = texVec.concat();
			centreFrameIndex = textures.length / 2;
			currentFrameIndex = centreFrameIndex;
			
			// set the start texture in the image to the centre frame
			super( textures[centreFrameIndex] );
			
			tiltRangeVec = new Vector.<Number>(textures.length+1);
			this.setMaxTilt(maxTilt);
		}
		
		public function setMaxTilt( maxTilt:Number ):void
		{
			var range:Number = maxTilt / centreFrameIndex;
			var halfRange:Number = range * 0.5;
			
			tiltRangeVec[centreFrameIndex] = -halfRange;
			tiltRangeVec[centreFrameIndex + 1] = halfRange;
			
			var i:int = 0;
			for (i = centreFrameIndex + 2; i < tiltRangeVec.length; i++ )
			{
				tiltRangeVec[i] = tiltRangeVec[i - 1] + range;
			}
			for (i = centreFrameIndex - 1; i >= 0; i-- )
			{
				tiltRangeVec[i] = tiltRangeVec[i + 1] - range;
			}
		}
		
		public function getTexture(frameID:int):Texture
        {
            if (frameID < 0 || frameID >= textures.length) throw new ArgumentError("Invalid frame id");
            return textures[frameID];
        }
	
		public function getCurrentTiltValue():Number
		{
			return currentTiltValue;
		}
		
		public function setTilt(tilt:Number):void
		{
			currentTiltValue = tilt;
			if (currentTiltValue > tiltRangeVec[tiltRangeVec.length - 1])
			{
				currentTiltValue = tiltRangeVec[tiltRangeVec.length - 1];
			}
			else if (currentTiltValue < tiltRangeVec[0])
			{
				currentTiltValue = tiltRangeVec[0];
			}
			
			var frame:int = centreFrameIndex;
			
			if ( tilt >= 0.0 )
			{
				while ( frame < (textures.length - 1) && tilt > tiltRangeVec[frame + 1] )
				{
					frame++
				}
			}
			else
			{
				while ( frame > 0 && tilt < tiltRangeVec[frame] )
				{
					frame--;
				}
			}
			
			if ( frame != currentFrameIndex )
			{
				currentFrameIndex = frame;
				super.texture = textures[currentFrameIndex];
			}
		}
		
		public function increaseTiltBy(tilt:Number):void
		{
			this.setTilt(currentTiltValue + tilt);
		}
		
		public function decreaseTiltBy(tilt:Number):void
		{
			this.setTilt(currentTiltValue - tilt);
		}
	}

}