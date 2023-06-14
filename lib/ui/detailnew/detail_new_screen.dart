
import 'package:admob_flutter/admob_flutter.dart';
import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../extension/extension.dart';
import 'detail_new_controller.dart';

class DetailNewScreen extends GetView<DetailController>{
  const DetailNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KeyString.KEY_DETAIL_NEW.tr,style: const TextStyle(fontFamily: "montserrat_black",fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(child: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black),onTap: (){
          Get.back();
        },),

      ),
      body: WebViewWidget(controller: controller.webViewController),
      bottomNavigationBar: AdmobBanner(
        adUnitId: StringUtils.getBannerAdUnitId(),
        adSize: AdmobBannerSize.BANNER,
        listener: (AdmobAdEvent event,
            Map<String, dynamic>? args) {

        },
        onBannerCreated:
            (AdmobBannerController controller) {
          // Dispose is called automatically for you when Flutter removes the banner from the widget tree.
          // Normally you don't need to worry about disposing this yourself, it's handled.
          // If you need direct access to dispose, this is your guy!
          // controller.dispose();
        },
      ),
    );
  }

}