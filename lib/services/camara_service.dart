import 'package:image_picker/image_picker.dart';

class CamaraService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> tomarFotografia() async {
    try {
      return await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 75,
      );
    } catch (e) {
      throw Exception('No se pudo abrir la cámara: $e');
    }
  }
}
