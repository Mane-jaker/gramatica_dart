import 'package:flutter/material.dart';
import 'package:lenguaje_gramatica/logic/lenguage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingController = TextEditingController();
  Map<int, bool>? lineValidationResults;
  bool _isButtonPressed = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void validateCode() {
    final String code = _textEditingController.text;
    setState(() {
      lineValidationResults = Lenguage().evaluar(code);
      _isButtonPressed = true;
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
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ejemplo',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'if(1<7)->\n  bool t = T\n<-else->\n  bool f = F\n<-\nfor(i = 0 ; i to 5)->\n  str hola\n<-\nvoid hola()->\n  int migue\n<-',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu código...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
                controller: _textEditingController,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_isButtonPressed)
                  Text(
                    lineValidationResults!.values.every((result) => result)
                        ? 'Es correcto'
                        : 'Es incorrecto',
                    style: TextStyle(
                        color: lineValidationResults!.values
                                .every((result) => result)
                            ? Colors.green
                            : Colors.red,
                        fontSize: 18),
                  ),
                if (_isButtonPressed && lineValidationResults != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Líneas inválidas: ${getInvalidLines(lineValidationResults!)}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: validateCode,
                  child: const Text('Validar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getInvalidLines(Map<int, bool>? results) {
    List<int> invalidLines = [];
    if (results != null) {
      for (int line = 1; line <= results.length; line++) {
        if (results[line] == false) {
          invalidLines.add(line + 1);
        }
      }
    }
    return invalidLines.join(', ');
  }
}
