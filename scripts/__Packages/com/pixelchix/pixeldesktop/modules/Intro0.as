class com.pixelchix.pixeldesktop.modules.Intro0 extends MovieClip
{
   var char_mc;
   var manager;
   function Intro0()
   {
      super();
      trace("****: intro constructor");
   }
   function startModule(clip, manager)
   {
      this.char_mc = clip;
      this.manager = manager;
      this.doModule();
   }
   function doModule()
   {
      this.char_mc.playAnimation("walk",{destX:"homePosition"});
      var _loc2_ = random(2);
      this.char_mc.addAnimation("welcome" + _loc2_);
   }
}
