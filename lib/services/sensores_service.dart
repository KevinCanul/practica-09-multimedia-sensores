import 'package:sensors_plus/sensors_plus.dart';

class SensoresService {
  Stream<AccelerometerEvent> get acelerometro => accelerometerEventStream();

  Stream<GyroscopeEvent> get giroscopio => gyroscopeEventStream();
}
