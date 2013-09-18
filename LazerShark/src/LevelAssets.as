package  
{
	import Box2D.Common.Math.b2Vec2;
	import levels.LevelData;
	import starling.core.Starling;
	import flash.display.Bitmap;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author James
	 */
	public class LevelAssets 
	{
		// textures holds textures AND xml atlas data (also as textures)
		private static var sTextures:Dictionary;
		private static var sSounds:Dictionary;
		private static var sContentScaleFactor:int;
		
		
		public static function init():void
		{
			sContentScaleFactor = Starling.current.contentScaleFactor < 1.5 ? 1 : 2;
			sTextures = new Dictionary();
			sSounds = new Dictionary();
		}
		
		public static function getTexture(name:String):Texture
		{
			var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
            
			var data:Object = new textureClass[name];
			
            if (data is Bitmap)
			{
				sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
			}
            else if (data is ByteArray)
			{
				sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
			}
			else
			{
				throw new ArgumentError("bad texture name, mofo...in LevelAssets.getTexture(name:String)");
			}
			return sTextures[name];
		}
		
		public static function getSound(name:String):Sound
		{
			var soundObj:Object = new SoundEmbeds[name];
			if (soundObj is Sound)
			{
				sSounds[name] = soundObj as Sound;
			}
			else
			{
				throw new ArgumentError("bad sound name, mofo...in LevelAssets.getSound(name:String)");
			}
			return sSounds[name];
		}
		
		public static function create(name:String):Object
		{
			var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
            return new textureClass[name];
		}
		
		public static function getTextureAtlas(imageName:String, xmlName:String):TextureAtlas
		{
			var tex:Texture = getTexture(imageName)
			if (tex == null) return null;
			var xml:XML = XML(create(xmlName));
			if (xml == null) return null;
			return new TextureAtlas(tex, xml);
		}
		
		public static function getLevelData(lvlIndex:int):Vector.<LevelData>
		{
			var xml:XML = XML(create("Levels"));
			var ret:Vector.<LevelData> = new Vector.<LevelData>();
			var numLvl:int = xml.*[lvlIndex].@numEnemies;
			//Levels.push(new Vector.<LevelData>());
			for (var c:int = 0; c < numLvl; c++)
			{
				ret.push(new LevelData());
				ret[c].Set(xml.*[lvlIndex].*[c].@type, new b2Vec2(xml.*[lvlIndex].*[c].@PosX, xml.*[lvlIndex].*[c].@PosY));
			}
			return ret;		
		
		}
	}

}