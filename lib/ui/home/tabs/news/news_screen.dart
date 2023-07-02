import 'package:arsenalfc_flutter/extension/extension.dart';
import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/news/news_controllder.dart';
import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewsScreen extends GetView<NewsController> {
  Future<void> _pullRefresh() async {
    controller.getNewsPaging(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: Text(
                                    KeyString.KEY_NEWS.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                        fontFamily: "montserrat_black",
                                        color: Colors.black),
                                  ),
                                ),
                                Positioned(
                                    child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppConst.SEARCH_NEW);
                                    },
                                    child: const Icon(Icons.search),
                                  ),
                                )),
                              ],
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            child: Text(
                              KeyString.KEY_LATEST.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "montserrat_black",
                                  fontSize: 14,
                                  color: HexColor.fromHex("#0A1220")),
                              textAlign: TextAlign.left,
                            )),
                        const HeaderView(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const NewsListView(),
                        ),
                        Obx(() => Visibility(
                          visible: controller.isLoadDing.value,
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const CircularProgressIndicator()),
                        ))
                      ],
                    ),
                  )))),
    );
  }
}

class HeaderView extends GetView<NewsController> {
  const HeaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () {
            Get.toNamed(AppConst.DETAIL_NEWS,
                arguments: [controller.data.value]);
          },
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            width: MediaQuery.of(context).size.width,
            height: 271,
            child: Stack(
              children: [
                Positioned(child: buildImageHeader()),

                Positioned(
                    child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                        gradient: LinearGradient(
                            colors: [Colors.black54, Colors.black12])),
                  ),
                )),
                //
                Positioned(
                    child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 42),
                    child: Text(
                      controller.data.value.title ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "montserrat_black"),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                )),

                Positioned(
                    child: Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 25),
                    child: Text(
                      "${DateFormat("dd/MM/yyyy").format(DateTime.parse((controller.data.value.createdDate ?? "2022-11-01T100:00:00").split("T").first))} - ${controller.data.value.views ?? 0} lượt xem",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          fontFamily: "montserrat_black"),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Widget buildImageHeader() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
            imageUrl: controller.data.value.thumbnail ?? "",
            imageBuilder: (context, imageProvider) => Container(
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
                  width: Get.width,
                ),
            errorWidget: (context, url, error) => const Icon(Icons.error)));
  }
}

class NewsListView extends GetView<NewsController> {
  const NewsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: controller.list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppConst.DETAIL_NEWS,
                  arguments: [controller.list.elementAt(index)]);
            },
            child: Container(
                margin: index.isEven
                    ? const EdgeInsets.only(left: 16, right: 8)
                    : const EdgeInsets.only(left: 8, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 108,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl:
                                  controller.list.elementAt(index).thumbnail ??
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
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(
                          controller.list.elementAt(index).title ?? "",
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
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "${DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.list.elementAt(index).createdDate!.split("T").first))} - ${controller.list.elementAt(index).views} lượt xem",
                          style: const TextStyle(
                              fontSize: 10,
                              fontFamily: "montserrat_black",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        }));
  }
}
