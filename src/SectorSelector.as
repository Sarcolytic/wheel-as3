package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextFieldType;

	public class SectorSelector extends MovieClip {
		public function SectorSelector() {
			this.tf.restrict = "0-9";
			this.tf.addEventListener(Event.CHANGE, this.onChange);
		}

		private function onChange(event: Event): void {
			var str: String = this.tf.text;
			var value: Number = Number(this.tf.text);
			if (value < 1 || value > 12) {
				this.tf.text = str.substring(0, str.length - 1);
			}
		}

		public function getValue(): Number {
			return Number(this.tf.text);
		}

		public function setEnabled(value: Boolean): void {
			this.tf.type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			this.bg.alpha = value ? 1 : 0.5;
		}
	}
}
