class com.pixelchix.utils.DelayDelegate
{
   function DelayDelegate()
   {
   }
   static function create(delay, obj, func)
   {
      var _loc3_ = undefined;
      var _loc2_ = function()
      {
         var _loc2_ = arguments.callee.pID;
         var _loc4_ = arguments.callee.target;
         var _loc5_ = arguments.callee.func;
         var _loc3_ = arguments.concat(arguments.callee.args);
         clearInterval(_loc2_);
         return _loc5_.apply(_loc4_,_loc3_);
      };
      if(arguments.length > 3)
      {
         _loc3_ = arguments.slice(3);
      }
      else
      {
         _loc3_ = [];
      }
      _loc2_.target = obj;
      _loc2_.func = func;
      _loc2_.args = _loc3_;
      _loc2_.pID = setInterval(_loc2_,delay);
      return _loc2_;
   }
}
