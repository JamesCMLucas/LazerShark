package architecture.physics 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	/**
	 * ...
	 * @author Graham
	 */
	public class ShapeDef 
	{
		
		public function ShapeDef() 
		{
			this.texName = new String();
			this.restitution = new Number();
			this.friction = new Number();
			this.density = new Number();
			this.shapeDef = new b2PolygonShape();
			this.complexShapeDef = new Vector.<b2PolygonShape>();
		}
		
		public function defineShape( name:String, res:Number, fric:Number, dens:Number, isCom:Boolean)//, inShape:b2PolygonShape)
		{
		
			this.texName = name;
			this.restitution = res;
			this.friction = fric;
			this.density = dens;
			this.isComplex = isCom;
		
		}
		
		
		
		public function createPoly( vecIn:Vector.<b2Vec2>):void
		{
			this.shapeDef.SetAsVector(vecIn);
		}
		public function createComplexPoly( vecIn:Vector.<b2Vec2>, numVerts:Vector.<Number> ):void
		{
			var index:int = 0;
			var indVerts:Vector.<b2Vec2>;
			for each(var numVert in numVerts)
			{
				indVerts = new Vector.<b2Vec2>();
				var i:int = 0
				for (; i < numVert; i++ )
				{
					indVerts.push(vecIn[index + i]);
				}
				index += i;
				this.complexShapeDef.push(new b2PolygonShape());
				var len:int = this.complexShapeDef.length;
				this.complexShapeDef[len-1].SetAsVector(indVerts);
			}
			
			//this.shapeDef.SetAsVector(vecIn);
		}
		public var texName:String;
		public var restitution:Number;
		public var friction:Number;
		public var density:Number;
		public var complexShapeDef:Vector.<b2PolygonShape>;
		public var isComplex:Boolean;
		public var shapeDef:b2PolygonShape;
		
	}

}