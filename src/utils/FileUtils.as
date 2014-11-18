package utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	/**
	 * 文件操作工具 
	 * @author songdu.greg
	 * 
	 */	
	public class FileUtils
	{
		/**
		 * 由文件名获取xml 
		 * @param fileName
		 * @return 
		 * 
		 */		
		public static function getXmlByFileName(fileName:String):XML
		{
			var gameDataXML:XML;
			var file:File = null;
			if( File.documentsDirectory.exists)
				file = File.documentsDirectory.resolvePath (fileName) ;
			
			if(file)
			{
				var fileStream:FileStream = new FileStream() ;
				if(file.exists)
				{
					fileStream.open (file,FileMode.READ) ;
					gameDataXML = XML (fileStream.readUTFBytes (fileStream.bytesAvailable)) ;
					fileStream.close() ; 
				}
			}
			return gameDataXML;
		}
	}
}