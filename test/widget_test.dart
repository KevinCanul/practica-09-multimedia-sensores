import 'package:flutter_test/flutter_test.dart';
import 'package:practica_09_camara_sensores/main.dart';

void main() {
  testWidgets('La aplicación inicia correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const Practica09App());

    expect(find.text('Bitácora de inspección'), findsOneWidget);
    expect(find.text('Tomar fotografía'), findsOneWidget);
  });
}
