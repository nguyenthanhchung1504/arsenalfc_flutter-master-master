
import 'package:arsenalfc_flutter/ui/home/tabs/news/news_controllder.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/news/news_provider.dart';
import 'package:get/get.dart';

class NewsBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewsProvider());
    Get.put(NewsController(newsProvider: Get.find()));
  }

}