import 'package:gooner_vietnam/data/mappers/fixture_legacy_mapper.dart';
import 'package:gooner_vietnam/domain/repositories/schedule_repository.dart';
import 'package:gooner_vietnam/model/fixtures/FixturesData.dart';
import 'package:gooner_vietnam/model/standing/Standings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SchedulesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SchedulesController({required this.scheduleRepository});

  final ScheduleRepository scheduleRepository;

  RxList<FixturesData> listFixture = RxList();
  RxList<FixturesData> listResult = RxList();
  RxList<Standings> listStandings = RxList();

  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    loadAll();
  }

  Future<void> loadAll() async {
    isLoading.value = true;
    errorMessage.value = '';
    listFixture.clear();
    listResult.clear();
    listStandings.clear();

    final fixturesUpcoming = await scheduleRepository.getUpcomingFixtures(
      limit: 50,
    );
    final fixturesResults = await scheduleRepository.getResults(limit: 50);
    final standings = await scheduleRepository.getStandings();

    String? err;
    fixturesUpcoming.fold(
      (items) {
        for (final f in items) {
          listFixture.add(FixtureLegacyMapper.toFixturesData(f));
        }
      },
      (f) => err ??= f.message,
    );

    fixturesResults.fold(
      (items) {
        for (final f in items) {
          listResult.add(FixtureLegacyMapper.toFixturesData(f));
        }
      },
      (f) => err ??= f.message,
    );

    standings.fold(
      (items) {
        for (final s in items) {
          listStandings.add(FixtureLegacyMapper.toLegacyStanding(s));
        }
      },
      (f) => err ??= f.message,
    );

    isLoading.value = false;
    if (err != null &&
        listFixture.isEmpty &&
        listResult.isEmpty &&
        listStandings.isEmpty) {
      errorMessage.value = err!;
      Fluttertoast.showToast(
        msg: err!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    }
    update();
  }

  bool isArsenal(String? name) => name == 'Arsenal';
}
