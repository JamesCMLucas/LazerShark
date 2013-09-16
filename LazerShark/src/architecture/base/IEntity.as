package architecture.base 
{
	/**
	 * ...
	 * @author James
	 */
	public interface IEntity 
	{
		/**
		 * get this entity's id
		 * @return the id
		 */
		function getID():int;
		
		/**
		 * set this entity's id
		 * @param	id the id
		 */
		//function setID(id:int):void;
		/**
		 * update per frame
		 * @param	dt time since previous frame
		 */
		function update(dt:Number):void;
		/**
		 * is this entity alive
		 * will be removed from the level's dictionary if false
		 * @return true/false
		 */
		function isAlive():Boolean;
		
		function getGraphics():IGraphicsComponent;
		function getPhysics():IPhysicsComponent;
	}

}