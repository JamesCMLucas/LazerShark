package  
{
	/**
	 * ...
	 * @author James
	 */
	
	 import architecture.base.IPhysicsComponent;
	 import architecture.physics.ShapeDef;
	 import Box2D.Collision.Shapes.b2PolygonShape;
	 import Box2D.Common.Math.b2Vec2;
	 import Box2D.Dynamics.b2Body;
	 import Box2D.Dynamics.b2BodyDef;
	 import Box2D.Dynamics.b2FixtureDef;
	 import Box2D.Dynamics.b2World;
	 import flash.display.Bitmap;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
	
	public class Assets 
	{
		// If you're developing a game for the Flash Player / browser plugin, you can directly
        // embed all textures directly in this class. This demo, however, provides two sets of
        // textures for different resolutions. That's useful especially for mobile development,
        // where you have to support devices with different resolutions.
        //
        // For that reason, the actual embed statements are in separate files; one for each
        // set of textures. The correct set is chosen depending on the "contentScaleFactor".
        
        // TTF-Fonts
		// The 'embedAsCFF'-part IS REQUIRED!!!!
        /*
		[Embed(source="../media/fonts/Ubuntu-R.ttf", embedAsCFF="false", fontFamily="Ubuntu")]        
        private static const UbuntuRegular:Class;
		*/
		
		// Texture cache
        
        private static var sContentScaleFactor:int = 1;
        private static var sTextures:Dictionary = new Dictionary();
        private static var sSounds:Dictionary = new Dictionary();
		private static var sAtlas:Dictionary = new Dictionary();
        private static var sTextureAtlas:TextureAtlas;
        private static var sBitmapFontsLoaded:Boolean;
		
		/*
		public static function getTexture(name:String):Texture
        {
            if (sTextures[name] == undefined)
            {
                var data:Object = create(name);
                
                if (data is Bitmap)
				{
					//return Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
                    sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
				}
                else if (data is ByteArray)
				{
					//return Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
                    sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
				}
				else
				{
					//return null;
				}
            }
            
            return sTextures[name];
        }
		*/
		/*
		public static function getSound(name:String):Sound
        {
            var sound:Sound = sSounds[name] as Sound;
            if (sound) return sound;
            else throw new ArgumentError("Sound not found: " + name);
        }
		*/
		
		public static function loadBitmapFonts():void
        {
            if (!sBitmapFontsLoaded)
            {
				/*
                var texture:Texture = getTexture("DesyrelTexture");
                var xml:XML = XML(create("DesyrelXml"));
                TextField.registerBitmapFont(new BitmapFont(texture, xml));
				*/
                sBitmapFontsLoaded = true;
            }
        }
        
		/*
        public static function prepareSounds():void
        {
            sSounds["Step"] = new StepSound();
			sSounds["Laser"] = new LaserBlastSound();
        }
		*/
        /*
        public static function create(name:String):Object
        {
            var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
            return new textureClass[name];
        }
		*/
		
		/////////// BEGIN  //////////////////////
		
		
		
		
		/**
		 * creates a new object, embedded texture.
		 * @param	name the name of the embedded texture
		 * @return the texture, or null if name is invalid
		 */
		public static function createTexture(name:String):Texture
		{
			var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
            
			var data:Object = new textureClass[name];
			
            if (data is Bitmap)
			{
				return Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
			}
            else if (data is ByteArray)
			{
				return Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * creates a new texture atlas
		 * @param	imageName name of the embedded image
		 * @param	xmlName name of the embedded xml
		 * @return a new texture atlas, or null if one of the names are invalid
		 */
		public static function createTextureAtlas(imageName:String,xmlName:String):TextureAtlas
		{
			var tex:Texture = Assets.createTexture(imageName);
			if (tex == null) return null;
			var xml:XML = XML(Assets.createTexture(xmlName));
			if (xml == null) return null;
			return new TextureAtlas(tex, xml);
		}
		
		/**
		 * creates a new sound object
		 * @param	name the name of the embedded sound
		 * @return the sound, or null if the name is invalid
		 */
		public static function createSound(name:String):Sound
		{
			var soundObj:Object = new SoundEmbeds[name];
			if (soundObj is Sound)
			{
				return soundObj as Sound;
			}
			else
			{
				return null;
			}
		}
		
		public static function get contentScaleFactor():Number { return sContentScaleFactor; }
        public static function set contentScaleFactor(value:Number):void 
        {
			/*
            for each (var texture:Texture in sTextures)
                texture.dispose();
            
            sTextures = new Dictionary();
			*/
            sContentScaleFactor = value < 1.5 ? 1 : 2; // assets are available for factor 1 and 2 
        }
			
		//Added by Graham, September 9, 2013
		private static var dictShapesDef:Dictionary;
		private static var vecToRender:Vector.<IPhysicsComponent>;
		private static var vecToRemove:Vector.<IPhysicsComponent>;
		public static var numShapeDef:int;
		
		public static function createXML(name:String):Object
        {
            var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
            return new textureClass[name];
        }
		
		//Added by Graham August 5 2013
		public static function LoadShapes():void
		{
			
			vecToRender = new Vector.<IPhysicsComponent>();
			vecToRemove = new Vector.<IPhysicsComponent>();
			
		/*	dictColour = new Dictionary();
			dictColour["Blue"] = 0x0000FF;
			dictColour["Green"] = 0x006600;
			dictColour["Red"] = 0xFF0000;
			
			vecColour = new Vector.<String>();
			vecColour.push("Red");
			vecColour.push("Green");
			vecColour.push("Blue");*/
			//dictColour["Blue"];
			
			
			
			

			

			
			
			
			
			//gameShapes = new Vector.<ShapeDef>();
			dictShapesDef = new Dictionary();//.<ShapeDef>();
			
			//var loader:XMLLoader = new XMLLoader();
			//gameShapes = vec;// loader.Load();
			
			var xml:XML = XML(createXML("ShapesXml"));
			
			
			
			var len:Number = xml.*.length();
			numShapeDef = len;
			var vec:Vector.<b2Vec2> ;
			for (var i:int = new int(0); i < len; i++)
			{
				vec = new Vector.<b2Vec2>();
				//gameShapes.push(new ShapeDef());
				var type:String = xml.*[i].@type;
				dictShapesDef[type] = new ShapeDef();
				//gameShapes[i].setVerts( xml.*[i].@numVerts );
				
				
				
				if (type == "Star")
				{
					//gameShapes[i].defineShape( xml.*[i].@image, xml.*[i].@res, xml.*[i].@fric, xml.*[i].@dens, true );
					dictShapesDef[type].defineShape( xml.*[i].@image, xml.*[i].@res, xml.*[i].@fric, xml.*[i].@dens, true );
					var numShapes:Number = xml.*[i].@numShapes;
					var vecShapes:Vector.<Number> = new Vector.<Number>();
					for (var c:int = new int(0); c < numShapes; c++ )
					{
						var numVerts:Number = xml.*[i].*[c].@numVerts;
						vecShapes.push(numVerts);
						for (var index:int = new int(0); index < numVerts; index++ )
						{
							vec.push(new b2Vec2(xml.*[i].*[c].*[index].@posX, xml.*[i].*[c].*[index].@posY));
						}
					}
					//gameShapes[i].createComplexPoly(vec, vecShapes);
					dictShapesDef[type].createComplexPoly(vec, vecShapes);
					
				}
				else 
				{
					var numVerts:Number = xml.*[i].@numVerts;
					//gameShapes[i].defineShape( xml.*[i].@image, xml.*[i].@res, xml.*[i].@fric, xml.*[i].@dens, false );
					dictShapesDef[type].defineShape( xml.*[i].@image, xml.*[i].@res, xml.*[i].@fric, xml.*[i].@dens, false );
					//var numVerts:Number = 
					//trace(i);
					for (var index:int = new int(0); index < numVerts; index++ )
					{
				
						vec.push(new b2Vec2(xml.*[i].*[index].@posX * .008, xml.*[i].*[index].@posY * .008));
						
						//gameShapes[i].addPoint();
					}
					//trace(i);
					//gameShapes[i].createPoly(vec);
					dictShapesDef[type].createPoly(vec);
				}

				
			
				

			}
			/*for ( var i:int = 0; i < gameShapes.length(); i++ )
			{
				dictShapes[gameShapes[i].texName] = gameShapes[i];
			}*/
			
			
			
		}
		public static function GetShapeInfo( index:String ):ShapeDef //( index:int ):ShapeDef //
		{
			return dictShapesDef[index]
		}
		public static function GetTextureName( retIndex:int ):String//( index:String ):String //
		{
			var ret:String = new String();
			var index:int = 0;// index < retIndex; index++ )for (
			for each(var def:ShapeDef in dictShapesDef)
			{
				ret = def.texName;
				if (index >= retIndex)
				{
					break;
				}
			}
			return ret;
		}
		public static function CreateSimpleShape(world:b2World, shapeType:String, id:int ):b2Body//, myShape:IPhysicsComponent
		{
			var ret:b2Body;
			var shapeInfo:ShapeDef = dictShapesDef[shapeType];//; //
			var shapeBodyDef:b2BodyDef = new b2BodyDef();
			var shapeFixtureDef:b2FixtureDef = new b2FixtureDef();
			shapeBodyDef.position.Set(0, 0);
			shapeBodyDef.type = b2Body.b2_dynamicBody;
			if( shapeType == "Laser")
			{
				
				//shapeFixtureDef.isSensor = true;
				//shapeBodyDef.position.Set(0, 1.5);
			}
			
			shapeFixtureDef.shape = shapeInfo.shapeDef//circleShape;//
			shapeFixtureDef.friction = shapeInfo.friction;//0.02;//
			shapeFixtureDef.density =  shapeInfo.density;//10.0;//
			shapeFixtureDef.restitution = shapeInfo.restitution;//0.3;//
			shapeFixtureDef.filter.categoryBits = Constants.shapeNum;
			shapeFixtureDef.filter.groupIndex = id;
			//shapeBodyDef.userData = myShape;
			ret = world.CreateBody(shapeBodyDef);
			ret.CreateFixture(shapeFixtureDef);
			//myShape.setBody(world.CreateBody(shapeBodyDef));
			//myShape.getBody().CreateFixture(shapeFixtureDef);
			
			
			/*var sensorDef:b2FixtureDef = new b2FixtureDef();
			var circleShape:b2CircleShape = new b2CircleShape()
			circleShape.SetRadius(.5);
			sensorDef.shape = circleShape;
			sensorDef.isSensor = true;
			//sensorDef.filter.groupIndex = id;
			sensorDef.filter.categoryBits = Constants.sensorNum;
			sensorDef.filter.maskBits = Constants.shapeNum;*/ 
			//TODO change so only the shark has a sensor
			

			
			//ship->m_body->CreateFixture(&myFixtureDef);
			// myShape.mBody.CreateFixture(sensorDef);
			
			if ( shapeType == "Laser")
			{
				//ret.ApplyImpulse(new b2Vec2(3, 0), ret.GetLocalCenter());
				
			}
			return ret;
			//return myShape.getBody();
		}
		
		public static function CreateComplexShape( world:b2World, myShape:IPhysicsComponent, shapeType:String, id:int ):b2Body
		{
			
			var shapeInfo:ShapeDef = dictShapesDef[shapeType];//gameShapes[2]; //
			// make the first circle body
			
			var newShape:b2PolygonShape = new b2PolygonShape();
			var shapeBodyDef:b2BodyDef = new b2BodyDef();
			var shapeFixtureDef:b2FixtureDef = new b2FixtureDef();
			shapeBodyDef.type = b2Body.b2_dynamicBody;
			shapeBodyDef.position.Set(0, 0);

			myShape.body = world.CreateBody(shapeBodyDef);
			myShape.body.SetUserData(myShape);
			
			var partFixtureDef:b2FixtureDef = new b2FixtureDef();				
			partFixtureDef.friction = shapeInfo.friction;//0.02;//
			partFixtureDef.density =  shapeInfo.density;//10.0;//
			partFixtureDef.restitution = shapeInfo.restitution;//0.3;//
			//partFixtureDef.filter.groupIndex = id;
			//partFixtureDef.userData = myShape1;
			var i:int = 0;
			for each( var part:b2PolygonShape in shapeInfo.complexShapeDef)
			{
				partFixtureDef.shape = part//circleShape;//
				
				myShape.body.CreateFixture(partFixtureDef);
			}
			
			
			//add radar sensor to ship
			/*var sensorDef:b2FixtureDef = new b2FixtureDef();
			var circleShape:b2CircleShape = new b2CircleShape()
			circleShape.SetRadius(.5);
			sensorDef.shape = circleShape;
			sensorDef.isSensor = true;
			sensorDef.filter.categoryBits = Constants.sensorNum;
			sensorDef.filter.maskBits = Constants.shapeNum;*/
			//myFixtureDef.filter.categoryBits = RADAR_SENSOR;
			//myFixtureDef.filter.maskBits = ENEMY_AIRCRAFT;//radar only collides with aircraft
			
			//ship->m_body->CreateFixture(&myFixtureDef);
			// myShape.mBody.CreateFixture(sensorDef);
			
			trace("complex Shapes Created");
			
			return myShape.body;
			
			
		}
		
		
		/*public static  function GetColour( index:int):String
		{
			return vecColour[index];
		}*/
		
		public static function GetToRender():Vector.<IPhysicsComponent>
		{
			return vecToRender;
		}
		
		public static function GetToRemove():Vector.<IPhysicsComponent>
		{
			return vecToRemove;
		}
		
		public static function ClearVecs():void
		{
			
			vecToRender = new Vector.<IPhysicsComponent>();
			vecToRemove = new Vector.<IPhysicsComponent>();
		}
		
		
	
		
	}

}