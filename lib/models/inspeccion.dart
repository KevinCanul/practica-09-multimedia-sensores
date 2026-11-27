class Inspeccion {
  final String rutaFotografia;
  final DateTime fechaHora;
  final double acelerometroX;
  final double acelerometroY;
  final double acelerometroZ;
  final double giroscopioX;
  final double giroscopioY;
  final double giroscopioZ;

  const Inspeccion({
    required this.rutaFotografia,
    required this.fechaHora,
    required this.acelerometroX,
    required this.acelerometroY,
    required this.acelerometroZ,
    required this.giroscopioX,
    required this.giroscopioY,
    required this.giroscopioZ,
  });
}
