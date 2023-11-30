class Lenguage {
  late RegExp regexInt;
  late RegExp regexBool;
  late RegExp regexStr;
  late RegExp regexChar;
  late RegExp regexVar;
  late RegExp regexIf;
  late RegExp regexElse;
  late RegExp regexEnd;
  late RegExp regexFor;
  late RegExp regexFunction;

  Lenguage() {
    regexInt = RegExp(r'int\s+[a-z][a-z0-9_]*\s*(=\s*-?\d+)?');
    regexBool = RegExp(r'bool\s+[a-z][a-z0-9_]*\s*(=\s*(T|F))?');
    regexStr = RegExp(r'str\s+[a-z][a-z0-9_]*\s*(=\s*"([a-z]+)")?');
    regexChar = RegExp(r'char\s+[a-z][a-z0-9_]*\s*(=\s*"([a-z])")?');

    regexVar = RegExp(
        '(${regexBool.pattern})|(${regexStr.pattern})|(${regexChar.pattern})|(${regexInt.pattern})');

    regexIf = RegExp(
        r'if\(((([a-z][a-z0-9_]*)|(-?\d+))\s*((<|>)|==|!=)\s*(([a-z][a-z0-9_]*)|(-?\d+)))|((([a-z][a-z0-9_]*)|("([a-z]+)")|(T|F))\s*(==|!=)\s*(([a-z][a-z0-9_]*)|("([a-z]+)")|(T|F)))\)->');
    regexElse = RegExp(r'<-(else->)?');
    regexFor = RegExp(r'for\((\w+) = (-?\d+) ; \1 to (-?\d+)\)->');
    regexFunction = RegExp(
        r'(int|bool|str|char|void)\s+[a-z][a-z0-9_]*\s*\((?:\s*(${regexVar.pattern})\s*(?:,\s*${regexVar.pattern})*\s*)?\)->');
    regexEnd = RegExp(r'<-');
  }

  Map<int, bool> evaluar(String code) {
    final lines = code.split('\n');
    final result = <int, bool>{};
    int ifBlocks = 0;
    int forBlocks = 0;
    int functionBlocks = 0;

    for (int i = 0; i < lines.length; i++) {
      final matchVar = regexVar.firstMatch(lines[i]);
      final matchIf = regexIf.firstMatch(lines[i]);
      final matchElse = regexElse.firstMatch(lines[i]);
      final matchEnd = regexEnd.firstMatch(lines[i]);
      final matchFor = regexFor.firstMatch(lines[i]);
      final matchFunction = regexFunction.firstMatch(lines[i]);

      if (matchVar != null) {
        result[i] = true; // Declaración de variables
      } else if (matchIf != null) {
        ifBlocks++;
        if (ifBlocks == 0) {
          result[i] = true;
        }
      } else if (matchElse != null) {
        if (ifBlocks > 0 || forBlocks > 0 || functionBlocks > 0) {
          result[i] = true;
        } else {
          print('Error en la línea ${i + 1}: Falta If, For o Function');
          result[i] = false;
        }
      } else if (matchEnd != null) {
        if (ifBlocks > 0 || forBlocks > 0 || functionBlocks > 0) {
          // Similar al manejo de bloques de If y For
          if (ifBlocks > 0) {
            ifBlocks--;
          } else if (forBlocks > 0) {
            forBlocks--;
          } else {
            functionBlocks--;
          }
          result[i] = true; // Fin de bloque
        } else {
          print('Error en la línea ${i + 1}: Falta If, For o Function');
          result[i] = false;
        }
      } else if (matchFor != null) {
        forBlocks++;
        if (forBlocks == 0) {
          result[i] = true;
        }
      } else if (matchFunction != null) {
        functionBlocks++;
        if (functionBlocks == 0) {
          result[i] = true;
        }
      } else {
        result[i] = false; // Error en la línea
      }
    }

    // Verifica si hay bloques de For, If o Function sin cerrar al final del código
    if ((forBlocks > 0 || ifBlocks > 0 || functionBlocks > 0) &&
        !code.endsWith('<-')) {
      print(
          'Error: Hay bloques de For, If o Function sin cerrar al final del código.');
      return result
          .map((key, value) => MapEntry(key, value && key != lines.length - 1));
    }

    return result;
  }
}
