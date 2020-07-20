package {
	import flash.events.Event;

	public class WheelStateEvent extends Event {
		public static const CHANGE: String = "onChange";

		public var state: Number;

		public function WheelStateEvent(
			type: String,
			state: Number,
			bubbles: Boolean = false,
			cancelable: Boolean = false
		) {
			super(type, bubbles, cancelable);

			this.state = state;
		}

		public override function clone(): Event {
			return new WheelStateEvent(type, state, bubbles, cancelable);
		}
	}
}
