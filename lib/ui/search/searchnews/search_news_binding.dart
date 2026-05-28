import 'package:gooner_vietnam/ui/search/searchnews/search_news_controller.dart';
import 'package:gooner_vietnam/ui/search/searchnews/search_news_provider.dart';
import 'package:get/get.dart';

class SearchNewsBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchNewsProviders());
    Get.put(SearchNewsController(providers: Get.find()));
  }

}