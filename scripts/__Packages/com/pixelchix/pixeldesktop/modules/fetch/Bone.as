class com.pixelchix.pixeldesktop.modules.fetch.Bone extends MovieClip
{
   var Fg;
   var Ff;
   var onEnterFrame;
   var vy;
   var vx;
   var manager;
   function Bone()
   {
      super();
      this._xscale = _root.char_mc.anim_mc._xscale;
      this._yscale = _root.char_mc.anim_mc._yscale;
      this.cacheAsBitmap = true;
      this.Fg = 4;
      this.Ff = 0.98;
      this.onEnterFrame = function()
      {
         if(this._y <= _root.char_mc._y + 10)
         {
            this.vy += this.Fg;
            this.vx *= this.Ff;
            this.vy *= this.Ff;
            this._x += this.vx;
            this._y += this.vy;
         }
         else
         {
            this.gotoAndStop(1);
            this._y = this.manager.char_mc._y + 53 - this._height / 2;
            delete this.onEnterFrame;
         }
      };
   }
   function boneFound()
   {
      delete this.onEnterFrame;
   }
}
