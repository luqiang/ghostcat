package
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import ghostcat.community.SortYManager;
	import ghostcat.community.physics.PhysicsItem;
	import ghostcat.community.physics.PhysicsManager;
	import ghostcat.debug.FPS;
	import ghostcat.display.GBase;
	import ghostcat.display.bitmap.BitmapScreen;
	import ghostcat.display.bitmap.GBitmap;
	import ghostcat.events.TickEvent;
	import ghostcat.manager.RootManager;
	import ghostcat.parse.display.DrawParse;
	import ghostcat.ui.containers.GAlert;
	
	
	[SWF(width="400",height="400",frameRate="120")]
	[Frame(factoryClass="ghostcat.ui.RootLoader")]
	/**
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class SortExample2 extends GBase
	{
		public var s:BitmapScreen;
		public var c:SortYManager;
		public var p:PhysicsManager;
		public var debugTextField:TextField;
		
		protected override function init():void
		{
			RootManager.register(this);
			
			stage.addChild(new FPS());
			
			s = new BitmapScreen(400,400,false);
			s.mode = BitmapScreen.MODE_SHAPE;
			addChild(s);
			
			//创建100个物品
			for (var i:int = 0;i < 300;i++)
			{
				var m:GBitmap = new GBitmap(new DrawParse(new TestHuman()).createBitmapData())
				m.setPosition(Math.random() * stage.stageWidth,Math.random() * stage.stageHeight,true);
				m.enabledDelayUpdate = false;
				s.addObject(m);
			}
			
			//创建物理
			p = new PhysicsManager(physicsTickHandler);
			for (i = 0;i < 300;i++)
			{
				p.add(s.children[i]);
				p.setVelocity(s.children[i],new Point(Math.random()*500 - 250,Math.random()*500 - 250))
			}
		}
		
		private function physicsTickHandler(item:PhysicsItem,interval:int):void
		{
			//撞墙则反弹
			if (item.x < 0 && item.velocity.x < 0)
				item.velocity.x = -item.velocity.x;
		
			if (item.x > stage.stageWidth && item.velocity.x > 0)
				item.velocity.x = -item.velocity.x;
		
			if (item.y < 0 && item.velocity.y < 0)
				item.velocity.y = -item.velocity.y;
			
			if (item.y > stage.stageHeight && item.velocity.y > 0)
				item.velocity.y = -item.velocity.y;
		}
	}
}