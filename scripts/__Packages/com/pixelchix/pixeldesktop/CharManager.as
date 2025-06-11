class com.pixelchix.pixeldesktop.CharManager extends MovieClip
{
   var manager;
   var anim_mc;
   var animStack;
   var poof_mc;
   var hitArea_mc;
   var keyListener;
   var onMouseMove;
   var intervalId;
   var time;
   var begin;
   var change;
   var falling = false;
   var dragging = false;
   var dragDisabled = false;
   var idleCount = 0;
   var changedClothes = false;
   var scale = 150;
   var exiting = 0;
   var easing = mx.transitions.easing.Regular.easeInOut;
   var duration = 20;
   function CharManager()
   {
      super();
      this.manager = this._parent;
   }
   function disableDrag(disable)
   {
      this.dragDisabled = disable;
   }
   function setPosition(x, y)
   {
      if(x != undefined)
      {
         this._x = x;
      }
      if(y != undefined)
      {
         this._y = y;
      }
   }
   function setDirection(dir)
   {
      if(dir == "right")
      {
         this.anim_mc._xscale = - this.scale;
      }
      else
      {
         this.anim_mc._xscale = this.scale;
      }
   }
   function doExit()
   {
      var _loc3_ = random(this.manager.getDataValue("content/animData/exitTotal"));
      var _loc2_ = "exit" + _loc3_;
      this.manager.unloadModule();
      this.exiting = 2;
      this.playAnimation(_loc2_);
      this.addAnimation("walk",{destX:Stage.width + 100});
      mdm.Exception.DebugWindow.trace("doExit");
   }
   function addAnimation(animId, animObj)
   {
      this.animStack.push({key:animId,value:animObj});
   }
   function playAnimation(animId, animObj)
   {
      this.clearAnimations();
      this.idleCount = 0;
      if(this._x > this.manager.borderRight)
      {
         this.animStack.push({key:"walk",value:{destX:"stageRight"}});
      }
      this.animStack.push({key:animId,value:animObj});
      this.loadNextAnim();
   }
   function clearAnimations()
   {
      this.animStack = new Array();
   }
   function changeClothes(changed)
   {
      this.changedClothes = changed;
   }
   function loadNextAnim()
   {
      if(this.animStack.length < 1)
      {
         if(++this.idleCount > 10)
         {
            this.doExit();
            return undefined;
         }
         this.addIdleAnim();
      }
      var _loc2_ = this.animStack.shift();
      var _loc4_ = _loc2_.key;
      var _loc3_ = _loc2_.value;
      var _loc5_ = {manager:this,autoPlay:true,id:_loc4_,paramsObj:_loc3_};
      trace("loadNextAnim: " + _loc2_.key);
      if(this.changedClothes)
      {
         this.playPoof();
         this.changeClothes(false);
      }
      this.anim_mc = this.attachMovie(_loc4_,"anim_mc",1,_loc5_);
      this.anim_mc._xscale = this.anim_mc._yscale = this.scale;
   }
   function playPoof()
   {
      this.poof_mc = this.attachMovie("poof","poof_mc",2);
   }
   function addIdleAnim()
   {
      var _loc4_ = this.manager.getDataValue("content/animData/idleTotal");
      var _loc3_ = random(_loc4_);
      var _loc2_ = "idle" + _loc3_;
      this.animStack.push({key:_loc2_});
   }
   function onAnimationDone()
   {
      if(this.exiting-- == 1)
      {
         this.clearAnimations();
         mdm.Exception.DebugWindow.trace("onAnimationDone");
         this.hitArea_mc = this.manager.attachMovie("hitArea","hitArea_mc",101);
         this.hitArea_mc._width = mdm.System.screenWidth;
         this.keyListener.onKeyDown = com.pixelchix.utils.Delegate.create(this,this.startAgain);
         Key.addListener(this.keyListener);
         this.onMouseMove = com.pixelchix.utils.Delegate.create(this,this.startAgain);
      }
      else
      {
         this.loadNextAnim();
      }
   }
   function startAgain()
   {
      this.onMouseMove = undefined;
      Key.removeListener(this.keyListener);
      this.hitArea_mc.removeMovieClip;
      mdm.Exception.DebugWindow.trace("startAgain");
      this._x = this.manager.borderRight;
      this.playAnimation("walk",{destX:"homePosition"});
   }
   function onPress()
   {
      if(this.dragDisabled)
      {
         return undefined;
      }
      clearInterval(this.intervalId);
      this.playAnimation("dragging");
      this.manager.unloadModule();
      mdm.Forms.MainForm.startDrag();
      this.dragging = true;
   }
   function onRelease()
   {
      if(this.dragDisabled)
      {
         return undefined;
      }
      mdm.Forms.MainForm.stopDrag();
      this.dragging = false;
      this.falling = true;
      this.time = 0;
      this.begin = mdm.Forms.MainForm.y;
      this.change = this.manager.borderBottom - this.begin;
      this.intervalId = setInterval(this,"fallingUpdate",50);
      this.playAnimation("falling");
   }
   function fallingUpdate()
   {
      if(++this.time < this.duration)
      {
         mdm.Forms.MainForm.y = Math.floor(mx.transitions.easing.Regular.easeInOut(this.time,this.begin,this.change,this.duration));
      }
      else
      {
         this.playPoof();
         this.falling = false;
         this.poof_mc._y += 50;
         mdm.Forms.MainForm.hide();
         this._x += mdm.Forms.MainForm.x;
         mdm.Forms.MainForm.x = 0;
         mdm.Forms.MainForm.y = this.manager.borderBottom;
         var _loc2_ = com.pixelchix.utils.DelayDelegate.create(10,this,this.showHer);
         this.playAnimation("idle0");
         clearInterval(this.intervalId);
      }
   }
   function showHer()
   {
      mdm.Forms.MainForm.show();
   }
}
