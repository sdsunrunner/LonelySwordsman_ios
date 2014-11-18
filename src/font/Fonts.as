/**
 *
 * Hungry Hero Game
 * http://www.hungryherogame.com
 * 
 * Copyright (c) 2012 Hemanth Sharma (www.hsharma.com). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
 *  
 */

package   font
{
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;

	/**
	 * This class embeds the bitmap fonts used in the game. 
	 * 
	 * @author hsharma
	 * 
	 */
	public class Fonts
	{
		/**
		 * Font for score value. 
		 */		
		[Embed(source="fontScoreLabel.png")]
//		[Embed(source="fontRegular.png")]
		public static const Font_ScoreValue:Class;
		
		[Embed(source="fontScoreLabel.fnt", mimeType="application/octet-stream")]
//		[Embed(source="fontRegular.fnt", mimeType="application/octet-stream")]
		public static const XML_ScoreValue:Class;
		
		/**
		 * Font objects.
		 */		
		private static var ScoreValue:BitmapFont;
		
		/**
		 * Returns the BitmapFont (texture + xml) instance's fontName property (there is only oneinstance per app).
		 * @return String 
		 */
		public static function getFont(_fontStyle:String):Font
		{
			if (Fonts[_fontStyle] == undefined)
			{
				var texture:Texture = Texture.fromBitmap(new Fonts["Font_" + _fontStyle]());
				var xml:XML = XML(new Fonts["XML_" + _fontStyle]());
				Fonts[_fontStyle] = new BitmapFont(texture, xml);
				TextField.registerBitmapFont(Fonts[_fontStyle]);
			}
			
			return new Font(Fonts[_fontStyle].name, Fonts[_fontStyle].size);
		}
	}
}
