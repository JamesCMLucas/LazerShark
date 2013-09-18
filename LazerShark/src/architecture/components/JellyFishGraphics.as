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
		private var _visible:Boolean = false;
		private var _offScreen:Boolean = false;
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
			_visible = yeserno;
		}
		
		public function isVisible():Boolean 
		{
			return _visible;
		}
		
		public function get entity():IEntity 
		{
			return _entity;
		}
		
		public function set entity(value:IEntity):void 
		{
			_entity = value as JellyFish;
		}
		
		public function get offScreen():Boolean
		{
			return _offScreen;
		}
		public function set offScreen(value:Boolean):void
		{
			_offScreen = value;
		}
		
	}

}