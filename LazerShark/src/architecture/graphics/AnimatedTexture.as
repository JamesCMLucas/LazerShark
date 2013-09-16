package architecture.graphics 
{
	import starling.display.Image;
	import starling.events.TouchEvent;
    import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author James
	 */
	public class AnimatedTexture 
	{
		private var currentFrameIndex:int = 0;
		
		private var textures:Vector.<Texture>;
		private var bPlaying:Boolean = false;
		private var bReverse:Boolean = false;
		private var bLooping:Boolean = false;
		
		public function AnimatedTexture() 
		{
			textures = textures.concat();
			currentFrameIndex = 0;
			super(textures[0]);
		}
		
		public function play():void
		{
			bPlaying = true;
		}
		
		public function pause():void
		{
			bPlaying = false;
		}
		
		public function stop():void
		{
			bPlaying = false;
			if (bReverse)
			{
				currentFrameIndex = textures.length - 1;
			}
			else
			{
				currentFrameIndex = 0;
			}
		}
		
		public function setReverse(isReversed:Boolean):void
		{
			bReverse = isReversed;
		}
		
		public function setLooping(isLooping:Boolean):void
		{
			bLooping = isLooping;
		}
		
		public function stepFrame():void
		{
			var frameIndex:int = currentFrameIndex;
			
			if ( !bPlaying ) return;
			
			if (bReverse)
			{
				frameIndex--;
				
				if (frameIndex < 0)
				{
					if ( bLooping )
					{
						currentFrameIndex = textures.length - 1;
						texture = textures[currentFrameIndex];
					}
					else
					{
						bPlaying = false;
					}
				}
				else
				{
					currentFrameIndex = frameIndex;
					texture = textures[currentFrameIndex];
				}
				
				return;
			}
			
			
			frameIndex++;
			if (frameIndex >= textures.length)
			{
				if ( bLooping )
				{
					currentFrameIndex = 0;
					texture = textures[currentFrameIndex];
				}
				else
				{
					bPlaying = false;
				}
			}
			else
			{
				currentFrameIndex = frameIndex;
				texture = textures[currentFrameIndex];
			}
		}
	}

}