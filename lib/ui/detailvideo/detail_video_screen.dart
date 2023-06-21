
import 'package:arsenalfc_flutter/extension/extension.dart';
import 'package:arsenalfc_flutter/utils/colors.dart';
import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:pod_player/pod_player.dart';

import 'detail_video_controller.dart';

class DetailVideoScreen extends GetView<DetailVideoController> {
  const DetailVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          KeyString.KEY_DETAIL_VIDEO.tr,
          style: const TextStyle(
              fontFamily: "montserrat_black",
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onTap: () {
            controller.podController.pause();
            Get.back();
          },
        ),
      ),
      body: Obx(() => Column(
            children: [
              PodVideoPlayer(controller: controller.podController),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    controller.entity.value.title ?? "",
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "montserrat_black",
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Text(
                  "${controller.entity.value.uploadDate?.isNotEmpty == true ? StringDate.toDate(controller.entity.value.uploadDate ?? "", "dd/MM/yyyy") : ""} - ${controller.entity.value.views} lượt xem",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "montserrat_black",
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                ),
              ),
              Container(
                height: 1,
                color: const Color(AppColors.GRAY_LIGHT),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: Text(
                  KeyString.KEY_SUGGEST.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "montserrat_black",
                      fontWeight: FontWeight.w700),
                ),
              ),
              Flexible(
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            controller.getDetailVideo(
                                (controller.list.value.elementAt(index).id ??
                                        "0")
                                    .toString());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: (MediaQuery.of(context).size.width /
                                            2) -
                                        45,
                                    height: 108,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.list
                                                .elementAt(index)
                                                .thumbnail ??
                                            "",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          "assets/images/loading.gif",
                                          fit: BoxFit.cover,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )),
                                SizedBox(
                                  child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    direction: Axis.vertical,
                                    children: [
                                      Container(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) -
                                            ((MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2)),
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Text(
                                          controller.list
                                                  .elementAt(index)
                                                  .title ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "montserrat_black",
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  HexColor.fromHex("0A1220")),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) -
                                            ((MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2)),
                                        child: Text(
                                          "${DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.list.elementAt(index).createdDate!.split("T").first))} - ${controller.list.elementAt(index).views} lượt xem",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: "montserrat_black",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                  height: 108,
                                )
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          )),
        bottomNavigationBar: SizedBox(
          width: AdSize.banner.width.toDouble(),
          height: AdSize.banner.height.toDouble(),
          child: AdWidget(ad: BannerAd(
            adUnitId: StringUtils.getBannerAdUnitId(),
            request: const AdRequest(),
            size: AdSize.banner,
            listener: BannerAdListener(
              // Called when an ad is successfully received.
              onAdLoaded: (ad) {

              },
              // Called when an ad request failed.
              onAdFailedToLoad: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when an ad opens an overlay that covers the screen.
              onAdOpened: (Ad ad) {},
              // Called when an ad removes an overlay that covers the screen.
              onAdClosed: (Ad ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (Ad ad) {},
            ),
          )..load()),
        )
    );
  }
}
