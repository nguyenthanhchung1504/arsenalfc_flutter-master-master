import 'dart:io';

// import 'package:admob_flutter/admob_flutter.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';


import '../../../../model/detailnews/DataNewDetail.dart';
import '../../../../model/news/data_news.dart';
import 'detail_new_provider.dart';


class DetailController extends GetxController {
  final DetailProvider provider;


  DetailController({required this.provider});

  RxList<Data> listArgument = RxList();
  RxList<DataNewDetail>? listDetail = RxList();


  late WebViewController webViewController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var argument = Get.arguments as List<dynamic>;
    if (argument.isNotEmpty) {
      argument.forEach((element) {
        if (element is Data) {
          listArgument.value.add(element);
        }
      });
    }
    webViewController = WebViewController();
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    provider.getDetailNews((listArgument.value.firstOrNull?.id ?? 0).toString())
        .then((value) {
      if (value.body?.resultCode == 1) {
        if (value.body?.data?.isNotEmpty == true) {
          value.body?.data?.forEach((data) {
            listDetail?.value.add(data);
          });
          var html = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"><style>img{max-width: 100%; width:auto; height: auto;}</style></head>
      <body style='"margin: 0; padding: 0;'>
        <div>
          ${listDetail?.value.firstOrNull?.content ?? ""}
        </div>
      </body>
    </html>""";
          webViewController.loadHtmlString(html);
          update();
        }
      }
    });
  }

}