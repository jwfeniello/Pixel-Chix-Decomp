class com.pixelchix.pixeldesktop.modules.Activity2 extends MovieClip
{
   var char_mc;
   var manager;
   var rock_mc;
   var onEnterFrame;
   var minX = -50;
   var maxX = Stage.width + 50;
   var speed = 15;
   var maxSpeed = 30;
   var vector = - com.pixelchix.pixeldesktop.modules.Activity2.prototype.speed;
   var jumping = false;
   function Activity2()
   {
      super();
   }
   function startModule(clip, manager)
   {
      this.cacheAsBitmap = true;
      mx.transitions.OnEnterFrameBeacon.init();
      MovieClip.addListener(this);
      this.char_mc = clip;
      this.manager = manager;
      this.rock_mc = manager.attachMovie("rock","rock_mc",100);
      this.rock_mc._y = Stage.height - 6;
      this.rock_mc._x = 100 + random(Stage.width - 200);
      _root.hitArea_mc.gotoAndStop(2);
      _root.hitArea_mc._width = mdm.System.screenWidth;
      this.doModule();
      this.minX = -50;
   }
   function kill()
   {
      this.rock_mc.removeMovieClip();
      _root.hitArea_mc.gotoAndStop(1);
      for(var _loc3_ in _root)
      {
         if(_root[_loc3_] != this.char_mc)
         {
            _root[_loc3_].removeMovieClip();
         }
      }
      MovieClip.removeListener(this);
   }
   function doModule()
   {
      var _loc2_ = Stage.width;
      this.char_mc.playAnimation("walk",{destX:_loc2_ + 50});
      this.char_mc.addAnimation("rollerblade",{listener:this});
   }
   function onAnimationLoaded(id)
   {
      trace("***onAnimationLoaded: " + id + " : " + this.vector);
      if(this.vector > 0)
      {
         this.char_mc.setDirection("right");
      }
      if(id == "rollerblade")
      {
         this.onEnterFrame = this.rollerBlade;
         this.manager.onMouseUp = this.jump;
         this.jumping = false;
      }
      else if(id == "rollerbladeAngry")
      {
         this.onEnterFrame = undefined;
      }
   }
   function rollerBlade()
   {
      var _loc2_ = this.char_mc._x + this.vector;
      if(this.vector > 0)
      {
         this.char_mc.setDirection("right");
      }
      if(_loc2_ < this.minX)
      {
         _loc2_ = this.minX;
         this.char_mc.setDirection("right");
         this.vector = this.speed;
         this.speed = Math.min(this.maxSpeed,this.speed + 1);
      }
      if(_loc2_ > this.maxX)
      {
         _loc2_ = this.maxX;
         this.char_mc.setDirection("left");
         this.vector = - this.speed;
         this.speed = Math.min(this.maxSpeed,this.speed + 1);
      }
      this.char_mc.setPosition(_loc2_);
      if(this.char_mc.hitTest(this.rock_mc._x,this.rock_mc._y,true))
      {
         if(!this.jumping)
         {
            this.char_mc.playAnimation("rollerbladeTrip",{listener:this});
            this.char_mc.addAnimation("rollerbladeAngry",{listener:this});
            this.char_mc.addAnimation("rollerblade",{listener:this});
            this.speed = 15;
            this.manager.onMouseUp = undefined;
            if(this.vector > 0)
            {
               this.char_mc.setDirection("right");
            }
         }
      }
   }
   function jump()
   {
      var _loc3_ = random(4);
      var _loc2_ = "rollerbladeJump" + (_loc3_ != 3 ? 0 : 1);
      this.char_mc.playAnimation(_loc2_,{listener:this});
      if(this.vector > 0)
      {
         this.char_mc.setDirection("right");
      }
      this.char_mc.addAnimation("rollerblade",{listener:this});
      this.jumping = true;
      this.manager.onMouseUp = undefined;
   }
}
