function initTaskbar()
{
   taskbar.width = undefined;
   taskbar.height = undefined;
   taskbar.top = undefined;
   taskbar.left = undefined;
   taskbar.right = undefined;
   taskbar.bottom = undefined;
   taskbar.position = undefined;
   taskbar.visible = undefined;
   taskbar.initiallized = false;
   taskbar.handler = undefined;
   _root.__taskbarData = undefined;
   _root.watch("__taskbarData",taskbarDataChanged);
}
function resetTaskbar()
{
   _root.__taskbarData = undefined;
   _root.unwatch("__taskbarData",taskbarDataChanged);
   taskbar.initialized = false;
   taskbar.handler = undefined;
}
function taskbarDataChanged(prop, oldVal, newVal)
{
   if(prop != "__taskbarData")
   {
      return undefined;
   }
   var _loc2_ = newVal.split("|");
   if(_loc2_.length != 6)
   {
      return undefined;
   }
   var _loc1_ = taskbar;
   _loc1_.width = parseInt(_loc2_[0]);
   _loc1_.height = parseInt(_loc2_[1]);
   _loc1_.top = parseInt(_loc2_[2]);
   _loc1_.left = parseInt(_loc2_[3]);
   _loc1_.right = parseInt(_loc2_[4]);
   _loc1_.bottom = parseInt(_loc2_[5]);
   if(isNaN(_loc1_.width))
   {
      return undefined;
   }
   if(isNaN(_loc1_.height))
   {
      return undefined;
   }
   if(isNaN(_loc1_.top))
   {
      return undefined;
   }
   if(isNaN(_loc1_.left))
   {
      return undefined;
   }
   if(isNaN(_loc1_.right))
   {
      return undefined;
   }
   if(isNaN(_loc1_.bottom))
   {
      return undefined;
   }
   _loc1_.position = getPosition();
   _loc1_.visible = isVisible();
   _loc1_.initialized = true;
   _loc1_.handler();
}
function getPosition()
{
   var _loc1_ = taskbar;
   if(_loc1_.top != 0)
   {
      return BOTTOM;
   }
   if(_loc1_.top == 0 && _loc1_.left == 0 && _loc1_.right == 0 && _loc1_.bottom == 0)
   {
      return LEFT;
   }
   if(_loc1_.left > 0)
   {
      return RIGHT;
   }
   if(_loc1_.right < _loc1_.bottom)
   {
      return LEFT;
   }
   return TOP;
}
function isVisible()
{
   var _loc1_ = taskbar;
   var _loc2_ = undefined;
   switch(_loc1_.position)
   {
      case LEFT:
         _loc2_ = _loc1_.right != _loc1_.width ? false : true;
      case TOP:
         _loc2_ = _loc1_.height != _loc1_.bottom ? false : true;
      case RIGHT:
         var _loc3_ = System.capabilities.screenResolutionX;
         _loc2_ = _loc1_.right <= _loc3_ ? true : false;
      case BOTTOM:
         var _loc4_ = System.capabilities.screenResolutionY;
         _loc2_ = _loc1_.bottom <= _loc4_ ? true : false;
   }
   if(_loc2_ == undefined)
   {
      return false;
   }
   return _loc2_;
}
function getTaskbarData()
{
   _root.__taskbarData = undefined;
   _root.watch("__taskbarData",taskbarDataChanged);
   fscommand("taskbar.GetTaskbar","__taskbarData");
}
function checkTaskbarState(callback)
{
   if(taskbar.initialized != true)
   {
      taskbar.handler = callback;
      getTaskbarData();
      return false;
   }
   resetTaskbar();
   updateFormY();
   return true;
}
function updateData()
{
   if(checkTaskbarState(updateData) == false)
   {
      return undefined;
   }
}
function updateFormY()
{
   borderBottom = Math.round(taskbar.top - this.stageHeight_mc._height);
   if(mdm.Forms.MainForm.y != borderBottom && !char_mc.dragging && !char_mc.falling)
   {
      mdm.Forms.MainForm.y = borderBottom;
   }
}
mdminit();
var myLC = new LocalConnection();
var amIFirst = myLC.connect(mdm.Application.filename);
if(amIFirst)
{
   mdm.Forms.MainForm.restore();
   mdm.Forms.MainForm.setFocus();
   mdm.Forms.MainForm.visible = true;
   mdm.Forms.menu.visible = true;
}
else
{
   mdm.Application.exit();
}
var taskbarData_txt;
var updateTime = 3000;
var updateInterval;
var borderBottom;
var taskbar = new Object();
var TOP = 38;
var LEFT = 37;
var RIGHT = 39;
var BOTTOM = 40;
updateData();
updateInterval = setInterval(updateData,updateTime);
this.__proto__ = com.pixelchix.pixeldesktop.PixelDesktop.prototype;
_global.com.pixelchix.pixeldesktop.PixelDesktop.apply(this,[]);
stop();
