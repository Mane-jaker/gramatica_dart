class Lenguage {
  late RegExp regexL;
  late RegExp regexN;
  late RegExp regexP;
  late RegExp regexD;
  late RegExp regexC;
  late RegExp tv;
  late RegExp b;
  late RegExp co;
  late RegExp e;
  late RegExp u;

  Lenguage() {
    regexL = RegExp(r'^[a-z]$');
    regexC = RegExp(r'^[a-z]');
    regexN = RegExp(r'^-?\d+$');
    tv = RegExp(r'^(int|str|bool|char)$');
    b = RegExp(r'^(T|F)');
    co = RegExp(r'^(")');
    e = RegExp(r'^(=)');
    regexD = RegExp('(${regexC.pattern})+');
    regexP = RegExp(
        '(${regexL.pattern})|(?:[a-z])?'); // RegExp regex = RegExp(r'^[a-z]+$');
    u = RegExp('^(${regexD.pattern})+|(${regexN.pattern})+|(_)+');
  }

  bool evaluar() {
    bool isValid = u.hasMatch('');
    return isValid;
  }
}
