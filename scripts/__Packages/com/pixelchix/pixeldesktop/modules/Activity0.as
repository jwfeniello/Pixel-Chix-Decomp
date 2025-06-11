class com.pixelchix.pixeldesktop.modules.Activity0 extends MovieClip
{
   var char_mc;
   var manager;
   function Activity0()
   {
      super();
   }
   function startModule(clip, manager)
   {
      this.cacheAsBitmap = true;
      this.char_mc = clip;
      this.manager = manager;
      this.doModule();
   }
   function kill()
   {
      for(var _loc3_ in _root)
      {
         if(_root[_loc3_] != this.char_mc)
         {
            _root[_loc3_].removeMovieClip();
         }
      }
   }
   function doModule()
   {
      var _loc2_ = Stage.width;
      this.char_mc.playAnimation("walk",{destX:_loc2_ + 50});
      this.char_mc.addAnimation("guitarWalk",{destX:_loc2_ * 0.6});
      this.char_mc.addAnimation("guitarPlay");
      this.char_mc.addAnimation("guitarWalk",{destX:_loc2_ + 50});
      this.char_mc.addAnimation("walk",{destX:_loc2_ * 0.6});
   }
}
