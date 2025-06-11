class com.pixelchix.pixeldesktop.modules.Activity1 extends MovieClip
{
   var char_mc;
   var manager;
   var retrieving;
   var beenFetched;
   var dog;
   var mouseListener;
   var bone;
   var switched;
   var direction;
   var killed = false;
   function Activity1()
   {
      super();
   }
   function startModule(clip, manager)
   {
      this.cacheAsBitmap = true;
      this.killed = false;
      mx.transitions.OnEnterFrameBeacon.init();
      MovieClip.addListener(this);
      this.char_mc = clip;
      this.manager = manager;
      mdm.Exception.DebugWindow.trace("this.manager = " + this.manager);
      _root.hitArea_mc.gotoAndStop(2);
      _root.hitArea_mc._width = mdm.System.screenWidth;
      this.doModule();
   }
   function doModule()
   {
      mdm.Exception.DebugWindow.trace("startingFetch");
      this.retrieving = false;
      this.beenFetched = false;
      this.dog = this.manager.attachMovie("dog_mc","dog_mc",this.manager.getNextHighestDepth());
      this.dog._x = Stage.width + 50;
      this.dog._y = this.char_mc._y;
      this.dog.retrieving = this.retrieving;
      this.dog.manager = this.manager;
      var referrer = this;
      this.mouseListener = new Object();
      this.mouseListener.onMouseDown = function()
      {
         trace("The Mouse has been pressed");
         if(!referrer.dog.retrieving)
         {
            referrer.throwBone(referrer.char_mc._x,referrer.char_mc._y,_root._xmouse);
            referrer.retrieving = true;
            referrer.dog.retrieving = referrer.retrieving;
         }
      };
      Mouse.addListener(this.mouseListener);
   }
   function kill()
   {
      this.killed = true;
      if(this.char_mc._xscale < 0)
      {
         this.char_mc._xscale *= -1;
      }
      Mouse.removeListener(this.mouseListener);
      for(var _loc3_ in _root)
      {
         if(_root[_loc3_] != this.char_mc)
         {
            _root[_loc3_].removeMovieClip();
         }
      }
      this.bone.removeMovieClip();
      this.dog.removeMovieClip();
      _root.hitArea_mc.gotoAndStop(1);
      MovieClip.removeListener(this);
   }
   function throwBone(originX, originY, xMouse)
   {
      trace("dog._xscale = " + this.dog._xscale);
      if(!this.beenFetched && !this.killed)
      {
         this.switched = false;
         this.char_mc.playAnimation("fetchTurnAndThrow");
         this.char_mc.addAnimation("idle0");
         var _loc4_ = new Object({x:originX,y:originY,xmouse:xMouse});
         this.direction = xMouse - originX >= 0 ? -1 : 1;
         if(xMouse - originX > 0 && this.char_mc._xscale > 0 || xMouse - originX < 0 && this.char_mc._xscale < 0)
         {
            this.dog._xscale *= -1;
            this.switched = true;
            this.turnMCs();
         }
         com.pixelchix.utils.DelayDelegate.create(750,this,this.createBone,_loc4_);
         this.beenFetched = true;
      }
      else if(!this.killed)
      {
         this.char_mc.playAnimation("fetchTakeFromDog");
         this.char_mc.addAnimation("idle0");
         this.beenFetched = false;
         com.pixelchix.utils.DelayDelegate.create(1200,this,this.throwBone,originX,originY,xMouse);
         this.direction = xMouse - originX >= 0 ? -1 : 1;
         this.dog.loadAnimation("fetchSitMouthOpen");
      }
   }
   function createBone(origin)
   {
      var _loc4_ = origin.xmouse - origin.x;
      var _loc2_ = this.manager.attachMovie("bone","bone",this.manager.getNextHighestDepth());
      this.bone = _loc2_;
      this.bone.manager = this.manager;
      _loc2_._x = origin.x;
      _loc2_._y = origin.y;
      _loc2_.vx = _loc4_ / 12;
      _loc2_.vy = -23;
      this.dog.fetchBone(this.direction);
      if(this.switched)
      {
         this.dog._xscale *= -1;
      }
   }
   function turnMCs()
   {
      this.dog._xscale *= -1;
      this.char_mc._xscale *= -1;
      this.bone._xscale *= -1;
   }
}
