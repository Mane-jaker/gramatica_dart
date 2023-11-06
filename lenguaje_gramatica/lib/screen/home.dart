import 'package:flutter/material.dart';
import 'package:lenguaje_gramatica/logic/lenguage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isValid = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void validateCode() {
    String code = _textEditingController.text;
    // Realiza la validación, por ejemplo, aquí se verifica si el texto contiene la palabra "validar"
    setState(() {
      isValid = code.toLowerCase().contains('validar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: const TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Ingresa tu código...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  Lenguage().evaluar() ? 'Es correcto' : 'Es incorrecto',
                  style: const TextStyle(color: Colors.green, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón "Validar"
                  },
                  child: const Text('Validar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
