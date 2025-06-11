class com.pixelchix.utils.Delegate
{
   function Delegate()
   {
   }
   static function create(obj, func, args)
   {
      var _loc3_ = function()
      {
         var _loc3_ = arguments.callee.target;
         var _loc4_ = arguments.callee.func;
         var _loc2_ = arguments.concat(arguments.callee.args);
         return _loc4_.apply(_loc3_,_loc2_);
      };
      if(args == undefined || args == null)
      {
         args = [];
      }
      _loc3_.target = obj;
      _loc3_.func = func;
      _loc3_.args = !(args instanceof Array) ? [args] : args;
      return _loc3_;
   }
}
