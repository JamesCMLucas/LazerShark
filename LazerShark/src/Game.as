package  
{
	import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	
	import flash.ui.Keyboard;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
	import flash.ui.Mouse;
    import flash.ui.MouseCursor;
    import levels.Level;
	
    import starling.core.Starling;
    import starling.display.BlendMode;
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author James
	 */
	public class Game extends Sprite 
	{
		private var mMainMenu:Sprite;
        private var mCurrentLevel:Level;
		private var myFunction:Function;
		
		public function Game() 
		{
			// The following settings are for mobile development (iOS, Android):
            //
            // You develop your game in a *fixed* coordinate system of 320x480; the game might 
            // then run on a device with a different resolution, and the assets class will
            // provide textures in the most suitable format.
            
            Starling.current.stage.stageWidth  = 320;
            Starling.current.stage.stageHeight = 480;
            Assets.contentScaleFactor = Starling.current.contentScaleFactor;
			
			// load general assets
            //Assets.prepareSounds();
            //Assets.loadBitmapFonts();
            Assets.LoadShapes();
            // create and show menu screen
            var bg:Image = new Image(Assets.createTexture("Background"));
            bg.blendMode = BlendMode.NONE;
            addChild(bg);
            
            mMainMenu = new Sprite();
            addChild(mMainMenu);

			
			//var logo:Image = new Image(Assets.getTexture("Logo"));
            //mMainMenu.addChild(logo);
			
			var levelsToCreate:Array = [
				["The Level", Level],
                //["ship control test", ShipControlTestScene]
			];
			
			var buttonTexture:Texture = Assets.createTexture("ButtonBig");
            var count:int = 0;
			for each (var levelToCreate:Array in levelsToCreate)
            {
                var sceneTitle:String = levelToCreate[0];
                var sceneClass:Class  = levelToCreate[1];
                
                var button:Button = new Button(buttonTexture, sceneTitle);
                button.x = count % 2 == 0 ? 28 : 167;
                button.y = 180 + int(count / 2) * 52;
                button.name = getQualifiedClassName(sceneClass);
                button.addEventListener(Event.TRIGGERED, onButtonTriggered);
                mMainMenu.addChild(button);
                ++count;
            }
			
			addEventListener(Level.CLOSING, onSceneClosing);
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			
			myFunction = tracePosition;
			// show information about rendering method (hardware/software)
            
            var driverInfo:String = Starling.context.driverInfo;
            var infoText:TextField = new TextField(310, 64, driverInfo, "Verdana", 10);
            infoText.x = 5;
            infoText.y = 475 - infoText.height;
            infoText.vAlign = VAlign.BOTTOM;
            infoText.touchable = false;
            mMainMenu.addChild(infoText);
		}
		
		private function tracePosition(x:Number,y:Number):void
		{
			trace("(" + x + ", " + y + ")");
		}
		
		private function onTouch(e:TouchEvent):void
		{   
            var touch:Touch = e.getTouch(this);
			
			if (touch == null) return;
			
			if (mCurrentLevel != null)
			{
				mCurrentLevel.touch(touch);
			}
			
			/*
			if (touch.phase == TouchPhase.BEGAN)
			{
				myFunction(touch.globalX,touch.globalY);
			}
			*/
		}
		
		private function onAddedToStage(event:Event):void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
        }
        
        private function onRemovedFromStage(event:Event):void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
        }
        
        private function onKey(event:KeyboardEvent):void
        {
            if (event.keyCode == Keyboard.SPACE)
                Starling.current.showStats = !Starling.current.showStats;
            else if (event.keyCode == Keyboard.X)
                Starling.context.dispose();
        }
        
        private function onButtonTriggered(event:Event):void
        {
            var button:Button = event.target as Button;
            playLevel(button.name);
        }
        
        private function onSceneClosing(event:Event):void
        {
            mCurrentLevel.removeFromParent(true);
            mCurrentLevel = null;
            mMainMenu.visible = true;
        }
        
        private function playLevel(name:String):void
        {
            if (mCurrentLevel) return;
            
            var levelClass:Class = getDefinitionByName(name) as Class;
            mCurrentLevel = new levelClass() as Level;
            mMainMenu.visible = false;
            addChild(mCurrentLevel);
        }
	}

}