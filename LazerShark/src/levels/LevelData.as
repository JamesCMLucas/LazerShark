package levels 
{
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author Graham
	 */
	public class LevelData 
	{
		
		private var type:String;
		private var pos:b2Vec2;
		public function LevelData() 
		{
			type = new String();
			pos = new b2Vec2();
		}
		
		public function Set( t:String, p:b2Vec2):void
		{
			type = t;
			pos = p;
		}
		
		public function SetType( input:String ):void
		{
			type = input;
		}
		
		public function GetType():String
		{
			return type;
		}
		
		public function SetPos( X:Number, Y:Number ):void
		{
			pos.x = X;
			pos.y = Y;
		}
		
		public function GetPos():b2Vec2
		{
			return pos;
		}
		
		
	}

}