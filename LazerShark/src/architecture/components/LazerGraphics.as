package architecture.components 
{
	import architecture.base.IEntity;
	import architecture.base.IGraphicsComponent;
	import architecture.entities.Lazer;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Graham
	 */
	public class LazerGraphics extends Image implements IGraphicsComponent 
	{
		
		public var _entity:Lazer = null;
		private var _offScreen = false;
		public function LazerGraphics( imgHeight:int, imgWidth:int ) 
		{
			super(Assets.createTexture("Lazer"));
			//ShapeImage = new Image(Assets.getTexture(type));
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			this.width = 30;
			this.height = 5;
			super.visible = false;
		}
		public function get image():Image 
		{
			return this;
		}
		
		
		/* INTERFACE architecture.base.IGraphicsComponent */
		public function setVisible(yeserno:Boolean):void 
		{
			super.visible = yeserno;
		}
		
		/* INTERFACE architecture.base.IGraphicsComponent */
		public function isVisible():Boolean 
		{
			return super.visible;
		}
		
		/* INTERFACE architecture.base.IComponent */
		public function get entity():IEntity 
		{
			return _entity;
		}
		
		/* INTERFACE architecture.base.IComponent */
		public function set entity(value:IEntity):void 
		{
			_entity = value as Lazer;
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