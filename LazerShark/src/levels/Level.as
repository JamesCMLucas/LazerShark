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
		private var entityID:int;
		public function Level() 
		{
			
			entities = new Dictionary();
			LevelAssets.init();
			PhysicsManager.init();
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, updatePerFrame);
			entityID = 0;
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

			p.body.SetPosition(new b2Vec2(5, 5));
			
			user = new Shark(entityID, g, p, i);
			(user as Shark).lazerSound = LevelAssets.getSound("Lazer");
			entities[user.getID()] = user;
			
			entityID++;
			var lvlData:Vector.<LevelData> = LevelAssets.getLevelData(0);
			
			for each( var ld:LevelData in lvlData)
			{
				var jg:JellyFishGraphics = new JellyFishGraphics();
				var jp:JellyFishPhysics = new JellyFishPhysics(Assets.CreateSimpleShape(PhysicsManager.world, ld.GetType(), 2));// "Jellyfish", 2));
				jp.body.SetPosition( ld.GetPos() );
				var npc:JellyFish = new JellyFish( entityID, jg, jp );
				entities[npc.getID()] = npc;
				entityID++;
			}
			
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
				if (!entity.isAlive())
				{
					entity.getGraphics().image.removeFromParent();
					PhysicsManager.sendToTheKillingFloor(entity.getPhysics().body);
					delete entities[entity.getID()];
					continue;
				}
				entity.update(dt);
				if (entity is JellyFish)
				{
					if (entity.getGraphics().isVisible()) //(entity.getGraphics().isVisible() && entity.getGraphics().image.parent == null)
					{
						this.addChild(entity.getGraphics().image);
						entity.getGraphics().setVisible(false);
					}
					else if (entity.getGraphics().offScreen)//(!entity.getGraphics().isVisible() && entity.getGraphics().image.parent != null)
					{
						entity.getGraphics().image.removeFromParent();
						entity.getGraphics().offScreen = false;
					}
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
				var pos:b2Vec2 = user.getPhysics().body.GetWorldPoint(new b2Vec2(user.getPhysics().body.GetLocalCenter().x+1.5, user.getPhysics().body.GetLocalCenter().y-.01));
				var dir:b2Vec2 = new b2Vec2(3.0, 0.0);
				var matRot:b2Mat22 = new b2Mat22();
				matRot.Set(user.physics.body.GetAngle());
				dir.MulM(matRot);
				FireLaser(pos, dir);
			}
		}
	
		
		// addded by Graham September 12 2013
		public function FireLaser( pos:b2Vec2, dir:b2Vec2 ):void
		{
			
				var lazer:Lazer = new Lazer();
				
				var lg:LazerGraphics = new LazerGraphics(2,2);
				lazer.LazerSetup( entityID, lg, new LazerPhysics( Assets.CreateSimpleShape(PhysicsManager.world, "Laser", 1)));
				lazer.physics.entity = lazer;
				entities[lazer.getID()] = lazer;
				this.addChild(lg);
				
				
				lazer.physics.body.SetPositionAndAngle(pos, user.getPhysics().body.GetAngle());
				
				lazer.physics.body.ApplyImpulse(dir, lazer.physics.body.GetWorldCenter());
				entityID++;
		}
		
	}

}