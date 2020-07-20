package utils {
	public class Random {
		public static function getAngle(min: Number, max: Number): Number {
			return getInt(min, max);
		}

		public static function getInt(min: Number, max: Number): Number {
			min = Math.ceil(min);
			max = Math.floor(max);
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}

		public function Random() {

		}
	}
}
