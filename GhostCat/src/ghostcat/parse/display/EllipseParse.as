package ghostcat.parse.display
{
	import flash.display.Graphics;
	
	import ghostcat.parse.graphics.GraphicsEllipse;
	import ghostcat.parse.graphics.IGraphicsFill;
	import ghostcat.parse.graphics.IGraphicsLineStyle;

	public class EllipseParse extends ShapeParse
	{
		public var ellipse:GraphicsEllipse;
		
		public function EllipseParse(ellipse:GraphicsEllipse, line:IGraphicsLineStyle=null, fill:IGraphicsFill=null,grid9:Grid9Parse=null)
		{
			super(null, line, fill, grid9);
			
			this.ellipse = ellipse;
		}
		
		protected override function parseBaseShape(target:Graphics) : void
		{
			super.parseBaseShape(target);
			
			if (ellipse)
				ellipse.parseGraphics(target);
		}
	}
}