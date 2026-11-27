# Práctica 9: Cámara multimedia y sensores de movimiento

## 1. Objetivo

Integrar la captura de imágenes y la lectura de sensores del dispositivo móvil mediante Flutter, utilizando las capacidades nativas del hardware para desarrollar una bitácora de inspección.

## 2. Descripción del proyecto

La aplicación permite registrar evidencias técnicas mediante una fotografía y consultar los valores actuales del acelerómetro y giroscopio del dispositivo.

La información capturada se presenta en una tarjeta de evidencia.

## 3. Funcionalidades implementadas

- Captura de fotografías utilizando la cámara del dispositivo.
- Visualización de fotografías dentro de la aplicación.
- Lectura del acelerómetro en los ejes X, Y y Z.
- Lectura del giroscopio en los ejes X, Y y Z.
- Actualización de los valores de los sensores en tiempo real.
- Registro de fecha y hora de captura.
- Generación de una tarjeta de evidencia técnica.
- Manejo de cancelación de la cámara.
- Manejo de errores durante la captura.

## 4. Tecnologías utilizadas

- Flutter.
- Dart.
- Android 16.
- image_picker.
- sensors_plus.
- Git y GitHub.

## 5. Requisitos

- Flutter SDK instalado.
- Dart SDK.
- Git.
- Dispositivo Android físico con cámara y sensores de movimiento.
- Depuración USB habilitada para ejecutar desde la computadora.

## 6. Instalación

Clonar el repositorio:

```bash
git clone https://github.com/KevinCanul/practica-09-multimedia-sensores.git
```

Entrar al proyecto:

```bash
cd practica_09_camara_sensores
```

Instalar dependencias:

```bash
flutter pub get
```

## 7. Ejecución

Conectar un dispositivo Android mediante USB y ejecutar:

```bash
flutter devices
```

Iniciar la aplicación:

```bash
flutter run
```

## 8. Estructura del proyecto

```text
lib/
├── main.dart
├── models/
│   └── inspeccion.dart
├── screens/
│   └── inspeccion_screen.dart
└── services/
    ├── camara_service.dart
    └── sensores_service.dart

docs/
└── evidencias/
    └── practica-09/

test/
```

## 9. Pruebas realizadas

| Prueba | Resultado |
|---|---|
| Análisis estático con flutter analyze | Sin errores |
| Pruebas con flutter test | Aprobadas |
| Ejecución en Android físico | Correcta |
| Captura de fotografías | Correcta |
| Lectura del acelerómetro | Implementada |
| Lectura del giroscopio | Implementada |
| Visualización de evidencia | Correcta |

## 10. Evidencias

Las capturas de pantalla del funcionamiento de la aplicación se encuentran en:

```text
docs/evidencias/practica-09/
```

## 11. Participante

- Usuario de GitHub: KevinCanul

## 12. Repositorio

https://github.com/KevinCanul/practica-09-multimedia-sensores

## 13. Rama de trabajo

```text
practica-09-multimedia-sensores
```

La entrega se realizará mediante una Pull Request dirigida a la rama `develop`.