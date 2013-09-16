package levels 
{
	import architecture.base.IEntity;
	import architecture.base.PhysicsManager;
	import architecture.components.JellyFishGraphics;
	import architecture.components.JellyFishPhysics;
	import architecture.components.LazerGraphics;
	import architecture.components.LazerPhysics;
	import architecture.components.SharkPhysics;
	import architecture.entities.JellyFish;
	import architecture.entities.Lazer;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import flash.media.CameraPosition;
	
	import architecture.components.SharkGraphics;
	import architecture.components.SharkInput;
	
	import architecture.entities.Shark;
	
	import flash.utils.Dictionary;
	
	import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	
	import Box2D.Dynamics.b2Body;
	
	import jlmath.MathConst;
	/**
	 * ...
	 * @author James
	 */
	public class Level extends Sprite
	{
		public static const CLOSING:String = "closing";
		
		public var entities:Dictionary;
		//public static const COMPLETE:String = "complete";
		//public static const FAILED:String = "failed";
		public var user:Shark;
		public var pixelsPerMeter:Number = 50;
		public var metersPerPixel:Number = 1 / pixelsPerMeter;
		public function Level() 
		{
			vecShapes = new Vector.<Lazer>();
			entities = new Dictionary();
			LevelAssets.init();
			PhysicsManager.init();
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, updatePerFrame);
			this.loadTheShark();
		}
		
		public function loadTheShark():void
		{
			// the graphics
			var texAtlas:TextureAtlas = LevelAssets.getTextureAtlas("BullSharkTexture", "BullSharkXml");
			var g:SharkGraphics = new SharkGraphics(texAtlas.getTextures())
			this.addChild(g.image);
			
			// the input
			var i:SharkInput = new SharkInput();
			
			var p:SharkPhysics = new SharkPhysics( Assets.CreateSimpleShape(PhysicsManager.world, "Shark", 2) );
			/*var def:b2BodyDef = new b2BodyDef();
			def.type = b2Body.b2_kinematicBody;
			def.position.Set(5, 5);
			
			p.body = PhysicsManager.world.CreateBody(def);*/
			p.body.SetPosition(new b2Vec2(5, 5));
			
			user = new Shark(0, g, p, i);
			(user as Shark).lazerSound = LevelAssets.getSound("Lazer");
			entities[user.getID()] = user;
			//this.addChild(user.getGraphics() as SharkGraphics);
			
			var jg:JellyFishGraphics = new JellyFishGraphics();
			var jp:JellyFishPhysics = new JellyFishPhysics(Assets.CreateSimpleShape(PhysicsManager.world, "Jellyfish", 2));
			jp.body.SetPosition( new b2Vec2( 15, 5 ) );
			var npc:JellyFish = new JellyFish( 2, jg, jp );
			//jp.entity = npc;
			this.addChild(jg);
			entities[npc.getID()] = npc;
			
		}
		
		private function updatePerFrame(e:EnterFrameEvent):void
		{
			var dt:Number = e.passedTime;
			
			
			this.updateEntities(dt);
			PhysicsManager.step();
		}
		
		/**
		 * update each entity (call once per frame)
		 */
		private function updateEntities(dt:Number):void
		{
			for each (var entity:IEntity in entities)
			{
				entity.update(dt);
			}
			for ( var index:int; index < vecShapes.length; index++ )// each (var l:Lazer in vecShapes)
			{
				
				if ( vecShapes[index].isAlive() )
				{
					vecShapes[index].update(dt);
				}
				else 
				{
					vecShapes[index].getGraphics().image.removeFromParent();
					PhysicsManager.sendToTheKillingFloor(vecShapes[index].physics.body);
					vecShapes.splice(index, 1);
					
				}
			}
		}
		
		/**
		 * close this level down
		 */
        public function close():void
		{
			dispatchEvent(new Event(CLOSING, true));
		}
		
		public function load(name:String):void
		{
			//fill up entities dictionary
		}
		
		public function touch(touch:Touch):void
		{
		//	user.input.touch(touch);
			if (touch.phase == TouchPhase.BEGAN)
			{
				//FireLaser( new b2Vec2((touch.globalX - Constants.CenterX) * metersPerPixel, ( Constants.CenterY - touch.globalY) * metersPerPixel));
				//var pos:b2Vec2 = new b2Vec2( ( touch.globalY ) * PhysicsManager.metresPerPixel, (touch.globalX ) * PhysicsManager.metresPerPixel);
				//var pos:b2Vec2 = new b2Vec2( ( touch.globalX ) * PhysicsManager.metresPerPixel,(touch.globalY ) * PhysicsManager.metresPerPixel);
				//var pos:b2Vec2 = new b2Vec2(5, 6);
				//var pos:b2Vec2 = new b2Vec2(user.getPhysics().body.GetPosition().x + 2, user.getPhysics().body.GetPosition().y - 0.1);
				var pos:b2Vec2 = user.getPhysics().body.GetWorldPoint(new b2Vec2(user.getPhysics().body.GetLocalCenter().x+1.5, user.getPhysics().body.GetLocalCenter().y-.01));
				var dir:b2Vec2 = new b2Vec2(3.0, 0.0);
				var matRot:b2Mat22 = new b2Mat22();
				matRot.Set(user.physics.body.GetAngle());
				dir.MulM(matRot);
				FireLaser(pos, dir);
				//(world.RayCastOne( new b2Vec2(0, 0), new b2Vec2 (0, 3.5)).GetBody()).GetUserData().setForDel();
			}
		}
	
		public var vecShapes:Vector.<Lazer>;
		// addded by Graham September 12 2013
		public function FireLaser( pos:b2Vec2, dir:b2Vec2 ):void
		{
			//TODO create fuction that creates a new shape for the lazer 
				//vecShapes.push(new Shape("Laser",  "Red", 5, 30, false));
		
				vecShapes.push( new Lazer())
				var newShapeIndex:int = vecShapes.length - 1;
				var lg:LazerGraphics = new LazerGraphics(2,2);
				vecShapes[newShapeIndex].LazerSetup( 1, lg, new LazerPhysics( Assets.CreateSimpleShape(PhysicsManager.world, "Laser", 1)));
				vecShapes[newShapeIndex].physics.entity = vecShapes[newShapeIndex];
				this.addChild(lg);
				//vecShapes[newShapeIndex].PhysicsData = new LaserPhysics(vecShapes[newShapeIndex]);
				//vecShapes[newShapeIndex].ID = 3;
				//vecShapes[newShapeIndex].mBody = Assets.CreateSimpleShape(world, vecShapes[newShapeIndex], "Laser", 0);
				//vecShapes[newShapeIndex].physics.body.SetPosition(newPos);
				
				vecShapes[newShapeIndex].physics.body.SetPositionAndAngle(pos, user.getPhysics().body.GetAngle());
				
				vecShapes[newShapeIndex].physics.body.ApplyImpulse(dir, vecShapes[newShapeIndex].physics.body.GetWorldCenter());
		}
		
	}

}