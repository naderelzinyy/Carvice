import 'package:carvice_frontend/languages/tr.dart';
import 'package:carvice_frontend/languages/en.dart';
import 'package:get/get.dart';


class Languages extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'tr_TR': tr,
  };

}