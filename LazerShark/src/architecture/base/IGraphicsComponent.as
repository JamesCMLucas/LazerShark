package architecture.base 
{
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author James
	 */
	public interface IGraphicsComponent extends IComponent
	{
		/**
		 * set the visibility of this graphics component
		 */
		function setVisible(yeserno:Boolean):void;
		/**
		 * get the visibility of this graphics component
		 */
		function isVisible():Boolean;
		/**
		 * getter...any graphics component is/has an image
		 */
		function get image():Image;
	}

}