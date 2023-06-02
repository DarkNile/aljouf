import 'package:get/get.dart';
import 'package:aljouf/utils/lang/ar.dart';
import 'package:aljouf/utils/lang/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en-gb': en,
        'ar': ar,
      };
}
