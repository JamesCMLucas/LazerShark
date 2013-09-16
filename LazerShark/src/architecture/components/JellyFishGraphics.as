package architecture.components 
{
	import architecture.base.IEntity;
	import architecture.base.IGraphicsComponent;
	import architecture.entities.JellyFish;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Graham
	 */
	public class JellyFishGraphics extends Image implements IGraphicsComponent 
	{
		public var _entity:JellyFish = null;
		public function JellyFishGraphics() 
		{
			super(Assets.createTexture("Jellyfish"));
			//ShapeImage = new Image(Assets.getTexture(type));
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			this.width = 29;
			this.height = 49;
		}
		
		/* INTERFACE architecture.base.IGraphicsComponent */
		
		public function get image():Image 
		{
			return this;
		}
		
		public function setVisible(yeserno:Boolean):void 
		{
			
		}
		
		public function isVisible():Boolean 
		{
			return true;
		}
		
		public function get entity():IEntity 
		{
			return _entity;
		}
		
		public function set entity(value:IEntity):void 
		{
			_entity = value as JellyFish;
		}
		
	}

}