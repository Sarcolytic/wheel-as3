package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent

	public class Button extends MovieClip {
		public function Button() {
			this.buttonMode = true;
			this.mouseChildren = false;

			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
			this.addEventListener(MouseEvent.RELEASE_OUTSIDE, onUp);
		}

		public function setEnabled(value: Boolean): void {
			this.buttonMode = value;
			this.mouseEnabled = value;

			this.gotoAndStop(value ? "up" : "disabled");
		}

		private function onDown(event: MouseEvent): void {
			this.gotoAndStop("down");
		}

		private function onUp(event: MouseEvent): void {
			this.gotoAndStop("up");
		}
	}

}
