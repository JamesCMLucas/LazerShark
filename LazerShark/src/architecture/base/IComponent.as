package architecture.base 
{
	/**
	 * ...
	 * @author James
	 */
	public interface IComponent 
	{
		/**
		 * getter function for the entity that owns this component
		 */
		function get entity():IEntity;
		/**
		 * setter function for the entity that owns this component
		 */
		function set entity(value:IEntity):void;
	}

}