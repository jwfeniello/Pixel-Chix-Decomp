class com.pixelchix.pixeldesktop.modules.fetch.Dog extends MovieClip
{
   var anim_mc;
   var onEnterFrame;
   var direction;
   var manager;
   var retrieving;
   function Dog()
   {
      super();
      this.cacheAsBitmap = true;
      this._xscale = 150;
      this._yscale = 150;
      this.anim_mc = this.anim_mc;
      this.loadAnimation("fetchRun");
      this.onEnterFrame = function()
      {
         if(this._x >= _root.char_mc._x - 58)
         {
            this._x -= 15;
         }
         else
         {
            this.loadAnimation("fetchSitMouthOpen");
            delete this.onEnterFrame;
         }
      };
   }
   function fetchBone(dir)
   {
      this.loadAnimation("fetchRun");
      this.direction = dir;
      this.onEnterFrame = function()
      {
         if(this._x * dir > this.manager.bone._x * dir)
         {
            this._x -= 10 * dir;
         }
         else if(this.manager.bone._y >= this._y)
         {
            this.manager.bone.removeMovieClip();
            this.returnBone();
         }
      };
   }
   function returnBone()
   {
      this.loadAnimation("fetchRunWithBone");
      this.onEnterFrame = function()
      {
         if(this._x * this.direction < this.manager.char_mc._x * this.direction - 40)
         {
            this._x += 15 * this.direction;
         }
         else
         {
            this.loadAnimation("fetchSitBone");
            this.retrieving = false;
            delete this.onEnterFrame;
         }
      };
   }
   function loadAnimation(anim)
   {
      trace("load " + anim);
      this.anim_mc = this.attachMovie(anim,anim,1);
   }
}
