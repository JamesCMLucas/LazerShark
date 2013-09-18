package architecture.components 
{
	import architecture.base.IEntity;
	import architecture.base.IGraphicsComponent;
	import architecture.entities.Shark;
	import architecture.graphics.TeeterTexture;
	import starling.display.Image;
	
	import starling.textures.Texture;
	
	import jlmath.MathConst;
	/**
	 * ...
	 * @author James
	 */
	public class SharkGraphics extends TeeterTexture implements IGraphicsComponent
	{
		protected var sharky:Shark = null;
		private var _offScreen = false;
		public function SharkGraphics(texVec:Vector.<Texture>)
		{
			super(texVec, 50.0);
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			this.x = Constants.CenterX;
			this.y = Constants.GameHeight * ( 1.0 - MathConst.Golden_Ratio_Inverse );
			this.rotation = MathConst.Pi_Div_2;
		}
		
		
		
		/* INTERFACE architecture.base.IGraphicsComponent */
		public function setVisible(yeserno:Boolean):void 
		{
			this.visible = yeserno;
		}
		
		/* INTERFACE architecture.base.IGraphicsComponent */
		public function isVisible():Boolean 
		{
			return this.visible;
		}
		
		/* INTERFACE architecture.base.IGraphicsComponent */
		
		public function get image():Image 
		{
			return this;
		}
		
		/*
		public function set image(value:Image):void 
		{
			if (value is TeeterTexture)
			{
				teeter = value as TeeterTexture;
			}
			else
			{
				throw new ArgumentError("SharkGraphics image must be a TeeterTexture");
			}
		}*/
		
		/* INTERFACE architecture.base.IComponent */
		public function get entity():IEntity 
		{
			return sharky;
		}
		
		/* INTERFACE architecture.base.IComponent */
		public function set entity(value:IEntity):void 
		{
			sharky = value as Shark;
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