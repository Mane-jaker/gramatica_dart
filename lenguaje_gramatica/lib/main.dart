import 'package:flutter/material.dart';
import 'package:lenguaje_gramatica/logic/pila.dart';
import 'package:lenguaje_gramatica/screen/home.dart';

void main() {
  runApp(const MyApp());

  String codigo = '''
    int variable1 = 42
    bool esVerdadero = true
    int otraVariable = -123
  ''';

  AnalizadorLexico lexico = AnalizadorLexico();
  List<Token> tokens = lexico.analizar(codigo);

  // Imprime la lista de tokens
  for (Token token in tokens) {
    print('${token.tipo}: ${token.lexema}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 183, 173)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
