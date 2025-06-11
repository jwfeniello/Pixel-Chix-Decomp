class com.pixelchix.pixeldesktop.AnimWalk extends com.pixelchix.pixeldesktop.AnimGeneric
{
   var destX;
   var paramsObj;
   var manager;
   var vect;
   var speed = 13;
   function AnimWalk()
   {
      super();
   }
   function onLoad()
   {
      super.onLoad();
      this.destX = this.paramsObj.destX;
      if(this.destX == "homePosition")
      {
         this.destX = Stage.width * 0.55;
      }
      if(this.destX == "stageRight")
      {
         this.destX = this._parent._parent.borderRight - 150;
      }
      if(this.destX < this.manager._x)
      {
         this.vect = - this.speed;
      }
      else
      {
         this.vect = this.speed;
         this.manager.setDirection("right");
      }
   }
   function monitorAnimation()
   {
      this.manager._x += this.vect;
      var _loc2_ = this.destX - this.manager._x;
      if(Math.abs(_loc2_) < this.speed)
      {
         this.manager._x = this.destX;
         this.signalAnimationDone();
      }
   }
}
