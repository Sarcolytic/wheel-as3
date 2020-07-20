package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import WheelStateEvent;
	import WheelStates;
	import utils.Random;

	public class Game extends MovieClip {
		public function Game() {
			this.wheel.addEventListener(WheelStateEvent.CHANGE, this.onWheelChangeState);

			this.startButton.addEventListener(MouseEvent.CLICK, this.onStartButtonClicked);

			this.stopButton.addEventListener(MouseEvent.CLICK, this.onStopButtonClicked);
			this.stopButton.setEnabled(false);
		}

		private function onStartButtonClicked(event: MouseEvent): void {
			var stopSector: Number = this.sectorSelector.getValue();
			if (stopSector == 0) {
				stopSector = Random.getInt(1, 12);
			}

			this.wheel.startRotation(stopSector);
		}

		private function onStopButtonClicked(event: MouseEvent): void {
			this.wheel.stopRotation();
		}

		private function onWheelChangeState(event: WheelStateEvent): void {
			switch (event.state) {
				case WheelStates.IDLE:
					this.startButton.setEnabled(true);
					this.sectorSelector.setEnabled(true);
					break;
				case WheelStates.ACCELERATION:
					this.startButton.setEnabled(false);
					this.sectorSelector.setEnabled(false);
					break;
				case WheelStates.ROTATION:
					this.stopButton.setEnabled(true);
					break;
				case WheelStates.DECELERATION:
					this.stopButton.setEnabled(false);
					break;
			}
		}
	}
}
