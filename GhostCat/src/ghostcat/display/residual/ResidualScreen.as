package ghostcat.display.residual
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import ghostcat.display.bitmap.GBitmap;
	import ghostcat.util.Util;
	import ghostcat.util.display.MatrixUtil;

	/**
	 * 位图实现的残影效果
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class ResidualScreen extends GBitmap
	{
		/**
		 * 渐消滤镜
		 */
		protected var fadeFilter:ColorMatrixFilter;
		/**
		 * 模糊滤镜
		 */
		protected var blurFilter:BlurFilter;
		
		/**
		 * 位移速度 
		 */
		public var offest:Point;
		
		/**
		 * 附加的滤镜
		 */		
		public var effects:Array;
		
		/**
		 * 物品绘制时附加的颜色
		 */
		public var itemColorTransform:ColorTransform;
		
		/**
		 * 全屏附加的颜色
		 */
		public var colorTransform:ColorTransform;
		
		/**
		 * 需要应用的物品
		 */
		public var items:Array = [];
		
		/**
		 * 模糊速度
		 */
		public function get blurSpeed():Number
		{
			return blurFilter.blurX;
		}

		public function set blurSpeed(v:Number):void
		{
			blurFilter = new BlurFilter(v,v);
		}

		/**
		 * 渐隐速度（每次减少的透明度比例）
		 */
		public function get fadeSpeed():Number
		{
			return fadeFilter.matrix[18];
		}

		public function set fadeSpeed(v:Number):void
		{
			fadeFilter = new ColorMatrixFilter([1,0,0,0,0,
										0,1,0,0,0,
										0,0,1,0,0,
										0,0,0,v,0]);
		}

		public function ResidualScreen(width:Number,height:Number):void
		{
			super(new BitmapData(width,height,true,0));
		}
		
		/**
		 * 添加
		 * @param obj
		 * 
		 */
		public function addItem(obj:DisplayObject):void
		{
			items.push(obj);
		}
		
		/**
		 * 删除 
		 * @param obj
		 * 
		 */
		public function removeItem(obj:DisplayObject):void
		{
			Util.remove(items,obj);
		}
		
		protected override function updateDisplayList() : void
		{
			if (fadeFilter)
				bitmapData.applyFilter(bitmapData,bitmapData.rect,new Point(),fadeFilter);
			
			if (blurFilter)
				bitmapData.applyFilter(bitmapData,bitmapData.rect,new Point(),blurFilter);
		
			if (offest)
				bitmapData.scroll(offest.x,offest.y);
				
			if (colorTransform)
				bitmapData.colorTransform(bitmapData.rect,colorTransform);
			
			if (effects)
			{
				for each (var f:BitmapFilter in effects)
					bitmapData.applyFilter(bitmapData,bitmapData.rect,new Point(),f);
			}
			
			for each (var obj:DisplayObject in items)
				drawItem(obj);
		}
		
		/**
		 * 绘制物品
		 * @param obj
		 * 
		 */
		protected function drawItem(obj:*):void
		{
			var m:Matrix = MatrixUtil.getMatrixBetween(obj as DisplayObject,this,this.parent);
			
			bitmapData.draw(obj as DisplayObject,m,itemColorTransform);
		} 
	}
}