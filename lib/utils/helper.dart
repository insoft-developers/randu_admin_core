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

  String generateProductCode(String value) {
    value = value.isNotEmpty
        ? value.trim().split(' ').map((l) => l[0]).take(5).join()
        : '';

    // value = value.replaceAll('a', '');
    // value = value.replaceAll('i', '');
    // value = value.replaceAll('u', '');
    // value = value.replaceAll('e', '');
    // value = value.replaceAll('o', '');
    // value = value.replaceAll('A', '');
    // value = value.replaceAll('I', '');
    // value = value.replaceAll('U', '');
    // value = value.replaceAll('E', '');
    // value = value.replaceAll('O', '');
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

  static String formatAngka(String angka) {
    String price = angka;
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }

  static double roundNumber(double value, int places) {
    num val = pow(10.0, places);
    return ((value * val).round().toDouble() / val);
  }
}
