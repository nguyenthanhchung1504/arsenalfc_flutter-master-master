import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../extension/extension.dart';
import 'detail_new_controller.dart';

class DetailNewScreen extends GetView<DetailController> {
  const DetailNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              KeyString.KEY_DETAIL_NEW.tr,
              style: const TextStyle(
                  fontFamily: "montserrat_black",
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              child: const Icon(Icons.arrow_back_ios_outlined,
                  color: Colors.black),
              onTap: () {
                Get.back();
              },
            ),
          ),
          body: Obx(() =>  WebViewWidget(controller: controller.webViewController.value,)),
          bottomNavigationBar: Obx(() => SizedBox(
            height: 210,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.list?.value.length,
                itemBuilder: (BuildContext context,int index){
                  return  GestureDetector(
                    onTap: (){
                      controller.getDetailNew((controller.list?.value[index].id ?? 0).toString());
                      controller.getRecommendNews((controller.list?.value[index].id ?? 0).toString());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          index == 0 ? const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                              child: Text("Các bài viết liên quan",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: "montserrat_black"),),
                          ) :  const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            child: Text("",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,fontFamily: "montserrat_black"),),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 108,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  controller.list?.value.elementAt(index).thumbnail ??
                                      "",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/loading.gif",
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text(
                              controller.list?.value.elementAt(index).title ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "montserrat_black",
                                  color: HexColor.fromHex("0A1220")),
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              "${DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.list?.value.elementAt(index).createdDate!.split("T").first ??""))} - ${controller.list?.value.elementAt(index).views} lượt xem",
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: "montserrat_black",
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ))),
    );
  }
}
