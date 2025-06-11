class com.pixelchix.pixeldesktop.AnimGeneric extends MovieClip
{
   var manager;
   var addListener;
   var paramsObj;
   var broadcastMessage;
   var id;
   var autoPlay;
   var eventFired;
   var onEnterFrame;
   function AnimGeneric()
   {
      super();
      AsBroadcaster.initialize(this);
   }
   function onLoad()
   {
      this.cacheAsBitmap = true;
      if(this.manager)
      {
         this.addListener(this.manager);
      }
      if(this.paramsObj.listener)
      {
         this.addListener(this.paramsObj.listener);
      }
      this.broadcastMessage("onAnimationLoaded",this.id);
      if(this.autoPlay)
      {
         this.executeAnimation();
      }
      else
      {
         this.stop();
      }
   }
   function executeAnimation()
   {
      this.eventFired = false;
      this.onEnterFrame = this.monitorAnimation;
      this.gotoAndPlay(1);
   }
   function monitorAnimation()
   {
      if(this._currentframe >= this._totalframes && !this.eventFired)
      {
         this.signalAnimationDone();
      }
   }
   function signalAnimationDone()
   {
      this.broadcastMessage("onAnimationDone",this.id);
      this.eventFired = true;
      this.onEnterFrame = null;
      this.stop();
   }
}
