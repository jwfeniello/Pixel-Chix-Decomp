class com.pixelchix.utils.collections.XMLCollection
{
   var data_xml;
   var onLoad;
   function XMLCollection()
   {
   }
   function load(file)
   {
      this.data_xml = new XML();
      this.data_xml.ignoreWhite = true;
      this.data_xml.onLoad = this.onLoad;
      this.data_xml.load(file);
   }
   function getNodeValue(path)
   {
      return mx.xpath.XPathAPI.selectSingleNode(this.data_xml.firstChild,path).firstChild.nodeValue;
   }
   function getNode(path)
   {
      return mx.xpath.XPathAPI.selectSingleNode(this.data_xml.firstChild,path);
   }
}
