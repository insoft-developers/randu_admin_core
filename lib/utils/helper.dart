import 'dart:math';

class Helper {
  String generateCode(String value) {
    value = value.replaceAll('a', '');
    value = value.replaceAll('i', '');
    value = value.replaceAll('u', '');
    value = value.replaceAll('e', '');
    value = value.replaceAll('o', '');
    value = value.replaceAll('A', '');
    value = value.replaceAll('I', '');
    value = value.replaceAll('U', '');
    value = value.replaceAll('E', '');
    value = value.replaceAll('O', '');
    value = value.replaceAll(' ', '');

    value = value.toUpperCase() + '-';

    var rng = new Random();
    var code = rng.nextInt(9000) + 1000;

    String f = value + code.toString() + generateRandomString(2);
    print(value);
    if (value == '-') {
      return '';
    } else {
      return f;
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
