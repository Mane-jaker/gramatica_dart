// Definición de tipos de token
enum TokenType { INT, BOOL, IDENTIFICADOR, IGUAL, VALOR }

class Token {
  final TokenType tipo;
  final String lexema;

  Token(this.tipo, this.lexema);
}

class AnalizadorLexico {
  List<Token> analizar(String codigo) {
    // Expresiones regulares para reconocer patrones en el código
    final RegExp regexInt = RegExp(r'int');
    final RegExp regexBool = RegExp(r'bool');
    final RegExp regexIdentificador = RegExp(r'[a-zA-Z][a-zA-Z0-9_]*');
    final RegExp regexIgual = RegExp(r'=');
    final RegExp regexValor = RegExp(r'[-]?\d+|true|false');

    // Lista para almacenar tokens
    List<Token> tokens = [];

    // Divide el código en líneas
    final lineas = codigo.split('\n');

    // Itera sobre cada línea
    for (int i = 0; i < lineas.length; i++) {
      String linea = lineas[i];

      // Busca patrones en la línea y agrega tokens a la lista
      // Puedes adaptar esto según las necesidades de tu lenguaje
      RegExpMatch? match;
      int pos = 0;

      while (pos < linea.length) {
        if ((match = regexInt.matchAsPrefix(linea, pos) as RegExpMatch?) !=
            null) {
          tokens.add(Token(TokenType.INT, match!.group(0)!));
        } else if ((match =
                regexBool.matchAsPrefix(linea, pos) as RegExpMatch?) !=
            null) {
          tokens.add(Token(TokenType.BOOL, match!.group(0)!));
        } else if ((match =
                regexIdentificador.matchAsPrefix(linea, pos) as RegExpMatch?) !=
            null) {
          tokens.add(Token(TokenType.IDENTIFICADOR, match!.group(0)!));
        } else if ((match =
                regexIgual.matchAsPrefix(linea, pos) as RegExpMatch?) !=
            null) {
          tokens.add(Token(TokenType.IGUAL, match!.group(0)!));
        } else if ((match =
                regexValor.matchAsPrefix(linea, pos) as RegExpMatch?) !=
            null) {
          tokens.add(Token(TokenType.VALOR, match!.group(0)!));
        }

        // Avanza la posición según la longitud del último match
        pos += match?.end ?? 1;
      }
    }

    return tokens;
  }
}
