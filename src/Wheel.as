package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import utils.Random;
	import WheelStateEvent;
	import WheelStates;

	public class Wheel extends MovieClip {
		private static const TOTAL_WHEEL_SECTORS: Number = 12;

		private var maxSpeed: Number;
		private var accelerationTime: Number;

		private var isAcceleration: Boolean;
		private var isDeceleration: Boolean;
		private var acceleration: Number;
		private var speed: Number;
		private var startedSpeed: Number;
		private var time: Number;
		private var inactiveTimer: uint;
		private var stopSector: Number;

		public function Wheel() {
			this.maxSpeed = 360 / this.stage.frameRate;
			this.accelerationTime = 2 * this.stage.frameRate;
			this.speed = 360 / (5 * this.stage.frameRate);
			this.time = 0;

			this.addEventListener(Event.ENTER_FRAME, this.rotate);
		}

		public function startRotation(stopSector: Number): void {
			this.stopSector = stopSector;

			this.isAcceleration = true;
			this.startedSpeed = this.speed;
			this.acceleration = this.calcAcceleration(this.startedSpeed);
			this.time = 0;

			this.changeState(WheelStates.ACCELERATION);
		}

		public function stopRotation(): void {
			this.isDeceleration = true;
			this.startedSpeed = this.speed;
			this.acceleration = this.calcDeceleration(this.startedSpeed);
			this.time = 0;

			clearTimeout(this.inactiveTimer);

			this.changeState(WheelStates.DECELERATION);
		}

		private function rotate(event: Event): void {
			if (this.isAcceleration) {
				this.accelerate();
			} else if (this.isDeceleration) {
				this.decelerate();
			}

			this.rotation += this.speed;
		}

		private function getNewSpeed(): Number {
			this.time += 1;
			return this.startedSpeed + this.acceleration * this.time;
		}

		private function calcAcceleration(currentSpeed: Number): Number {
			return (this.maxSpeed - currentSpeed) / this.accelerationTime;
		}

		private function accelerate(): void {
			this.speed = this.speed = this.getNewSpeed();
			if (this.speed >= this.maxSpeed) {
				this.speed = this.maxSpeed;
				this.isAcceleration = false;

				this.startInactiveTimer();

				this.changeState(WheelStates.ROTATION);
			}
		}

		private function decelerate(): void {
			this.speed = this.getNewSpeed();
			if (this.speed < 0) {
				this.speed = 0;
				this.isDeceleration = false;

				this.changeState(WheelStates.IDLE);
			}
		}

		private function calcDeceleration(currentSpeed: Number): Number {
			return -(currentSpeed * currentSpeed) / (this.getDistance() * 2);
		}

		private function getEndingAngle(): Number {
			const angleSweepPerSector = 360 / Wheel.TOTAL_WHEEL_SECTORS;
			const endingAngle = 360 - angleSweepPerSector * this.stopSector;

			return endingAngle + Random.getAngle(10, 30);
		}

		private function getDistance(): Number {
			return 360 * 2 - this.getCurrentAngle() + this.getEndingAngle();
		}

		/**
		 * returns normalized value from 0deg to 360deg
		 */
		private function getCurrentAngle(): Number {
			return this.rotation % 360;
		}

		private function startInactiveTimer(): void {
			this.inactiveTimer = setTimeout(this.stopRotation, 10000);
		}

		private function changeState(newState: Number): void {
			this.dispatchEvent(new WheelStateEvent(WheelStateEvent.CHANGE, newState));
		}
	}
}
