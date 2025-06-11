class com.pixelchix.pixeldesktop.PixelDesktop extends com.pixelchix.application.Application
{
   var char_mc;
   var global_sound;
   var dataVars;
   var module;
   var newestVersionVars;
   var onEnterFrame;
   var borderRight;
   var easing = mx.transitions.easing.Regular.easeOut;
   var duration = 10;
   var isMuted = false;
   function PixelDesktop()
   {
      super();
      com.pixelchix.pixeldesktop.modules.Intro0;
      com.pixelchix.pixeldesktop.modules.Activity0;
      com.pixelchix.pixeldesktop.modules.Activity1;
      com.pixelchix.pixeldesktop.modules.Activity2;
      this.init();
   }
   function playAnimation()
   {
      this.char_mc.playAnimation.apply(this.char_mc,arguments);
   }
   function addAnimation()
   {
      this.char_mc.addAnimation.apply(this.char_mc,arguments);
   }
   function doExit()
   {
      this.char_mc.doExit.apply(this.char_mc,arguments);
   }
   function changeClothes()
   {
      this.char_mc.changeClothes.apply(this.char_mc,arguments);
   }
   function toggleSound(mute)
   {
      trace("toggleSound");
      if(mute == this.isMuted)
      {
         return undefined;
      }
      if(this.isMuted)
      {
         trace("*** unmuting");
         this.isMuted = false;
         this.global_sound.setVolume(100);
      }
      else
      {
         trace("*** muting");
         this.isMuted = true;
         this.global_sound.setVolume(0);
      }
   }
   function showMessage(msg)
   {
      mdm.Dialogs.prompt("hello from MainForm");
   }
   function getDataValue(path)
   {
      return this.dataVars.getNodeValue(path);
   }
   function loadModule(moduleName)
   {
      this.unloadModule();
      this.module = new _global.com.pixelchix.pixeldesktop.modules[moduleName]();
      this.module.startModule(this.char_mc,this);
   }
   function unloadModule()
   {
      this.module.kill();
      this.module = undefined;
   }
   function init()
   {
      _global.mdm.initevents();
      this.solvePosition();
      this.global_sound = new Sound();
      this.dataVars = new com.pixelchix.utils.collections.XMLCollection();
      this.dataVars.onLoad = com.pixelchix.utils.Delegate.create(this,this.dataLoaded);
      this.dataVars.load("data/pixelDesktop.xml");
   }
   function dataLoaded()
   {
      this.loadModule("Intro0");
      this.checkVersion();
   }
   function checkVersion()
   {
      var _loc2_ = this.dataVars.getNodeValue("content/versionXMLURL");
      this.newestVersionVars = new com.pixelchix.utils.collections.XMLCollection();
      this.newestVersionVars.onLoad = com.pixelchix.utils.Delegate.create(this,this.versionLoaded);
      this.newestVersionVars.load(_loc2_);
   }
   function versionLoaded(success)
   {
      if(success)
      {
         var _loc2_ = this.dataVars.getNodeValue("content/version");
         var _loc3_ = this.newestVersionVars.getNodeValue("content/version");
         if(_loc2_ < _loc3_)
         {
            mdm.Forms.popUp.show();
         }
      }
   }
   function solvePosition()
   {
      mdm.System.showTaskBar();
      var os;
      var _loc5_ = undefined;
      var _loc7_ = undefined;
      var _loc6_ = undefined;
      os = mdm.System.winVerString;
      var _loc4_ = mdm.System.screenWidth;
      var _loc3_ = mdm.System.screenHeight;
      this.onEnterFrame = function()
      {
         if(_level0.borderBottom != undefined && os != undefined)
         {
            delete this.onEnterFrame;
            this.borderRight = 1024 + (mdm.System.screenWidth - 1024) / 2;
            var _loc2_ = undefined;
            _loc2_ = mdm.Forms.MainForm;
            _loc2_.width = mdm.System.screenWidth;
            _loc2_.x = 0;
            return undefined;
         }
      };
   }
}
