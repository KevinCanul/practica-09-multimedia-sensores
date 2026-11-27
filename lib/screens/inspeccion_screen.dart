import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../models/inspeccion.dart';
import '../services/camara_service.dart';
import '../services/sensores_service.dart';

class InspeccionScreen extends StatefulWidget {
  const InspeccionScreen({super.key});

  @override
  State<InspeccionScreen> createState() => _InspeccionScreenState();
}

class _InspeccionScreenState extends State<InspeccionScreen> {
  final CamaraService _camaraService = CamaraService();
  final SensoresService _sensoresService = SensoresService();

  StreamSubscription<AccelerometerEvent>? _acelerometroSubscription;
  StreamSubscription<GyroscopeEvent>? _giroscopioSubscription;

  double acelerometroX = 0;
  double acelerometroY = 0;
  double acelerometroZ = 0;

  double giroscopioX = 0;
  double giroscopioY = 0;
  double giroscopioZ = 0;

  bool _capturando = false;
  Inspeccion? inspeccion;

  @override
  void initState() {
    super.initState();
    _iniciarSensores();
  }

  void _iniciarSensores() {
    _acelerometroSubscription = _sensoresService.acelerometro.listen((event) {
      if (!mounted) return;

      setState(() {
        acelerometroX = event.x;
        acelerometroY = event.y;
        acelerometroZ = event.z;
      });
    }, onError: (_) => _mostrarError('No se pudo leer el acelerómetro.'));

    _giroscopioSubscription = _sensoresService.giroscopio.listen((event) {
      if (!mounted) return;

      setState(() {
        giroscopioX = event.x;
        giroscopioY = event.y;
        giroscopioZ = event.z;
      });
    }, onError: (_) => _mostrarError('No se pudo leer el giroscopio.'));
  }

  Future<void> _tomarFotografia() async {
    if (_capturando) return;

    setState(() {
      _capturando = true;
    });

    try {
      final XFile? fotografia = await _camaraService.tomarFotografia();

      if (!mounted) return;

      if (fotografia == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Captura cancelada. No se guardó evidencia.'),
          ),
        );
        return;
      }

      setState(() {
        inspeccion = Inspeccion(
          rutaFotografia: fotografia.path,
          fechaHora: DateTime.now(),
          acelerometroX: acelerometroX,
          acelerometroY: acelerometroY,
          acelerometroZ: acelerometroZ,
          giroscopioX: giroscopioX,
          giroscopioY: giroscopioY,
          giroscopioZ: giroscopioZ,
        );
      });
    } catch (e) {
      if (!mounted) return;

      _mostrarError('Error al capturar fotografía: $e');
    } finally {
      if (mounted) {
        setState(() {
          _capturando = false;
        });
      }
    }
  }

  void _mostrarError(String mensaje) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    final anio = fecha.year;
    final hora = fecha.hour.toString().padLeft(2, '0');
    final minuto = fecha.minute.toString().padLeft(2, '0');

    return '$dia/$mes/$anio - $hora:$minuto';
  }

  Widget _crearDato(String nombre, double valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(nombre),
          Text(
            valor.toStringAsFixed(2),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _crearSeccionSensor(
    String titulo,
    IconData icono,
    double x,
    double y,
    double z,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icono, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            _crearDato('Eje X', x),
            _crearDato('Eje Y', y),
            _crearDato('Eje Z', z),
          ],
        ),
      ),
    );
  }

  Widget _crearTarjetaEvidencia() {
    final registro = inspeccion!;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.assignment_turned_in, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Evidencia registrada',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(registro.rutaFotografia),
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: Text('No se pudo mostrar la fotografía'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Fecha y hora de captura',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_formatearFecha(registro.fechaHora)),
            const Divider(height: 24),
            _crearSeccionSensor(
              'Acelerómetro registrado',
              Icons.screen_rotation,
              registro.acelerometroX,
              registro.acelerometroY,
              registro.acelerometroZ,
            ),
            _crearSeccionSensor(
              'Giroscopio registrado',
              Icons.threesixty,
              registro.giroscopioX,
              registro.giroscopioY,
              registro.giroscopioZ,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _acelerometroSubscription?.cancel();
    _giroscopioSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitácora de inspección'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Registro de evidencia técnica',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Captura una fotografía y registra los valores '
            'actuales de los sensores de movimiento.',
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: _capturando ? null : _tomarFotografia,
              icon: const Icon(Icons.camera_alt),
              label: Text(
                _capturando ? 'Abriendo cámara...' : 'Tomar fotografía',
              ),
            ),
          ),
          const SizedBox(height: 20),
          _crearSeccionSensor(
            'Acelerómetro en tiempo real',
            Icons.screen_rotation,
            acelerometroX,
            acelerometroY,
            acelerometroZ,
          ),
          _crearSeccionSensor(
            'Giroscopio en tiempo real',
            Icons.threesixty,
            giroscopioX,
            giroscopioY,
            giroscopioZ,
          ),
          const SizedBox(height: 16),
          if (inspeccion != null) ...[
            _crearTarjetaEvidencia(),
          ] else
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.photo_camera_outlined, size: 42),
                    SizedBox(height: 10),
                    Text(
                      'Todavía no hay evidencia',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Toma una fotografía para generar '
                      'tu primera inspección.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
