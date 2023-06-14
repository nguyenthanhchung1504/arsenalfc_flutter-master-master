
import 'package:arsenalfc_flutter/model/fixtures/FixturesData.dart';
import 'package:arsenalfc_flutter/model/standing/Standings.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SchedulesController extends GetxController with GetSingleTickerProviderStateMixin{
  ScheduleProvider scheduleProvider;

  SchedulesController({required this.scheduleProvider});

  RxList<FixturesData> listFixture = RxList();
  RxList<FixturesData> listResult = RxList();
  RxList<Standings> listStandings = RxList();

  late TabController tabController;

  @override
  void onReady() {
    super.onReady();
    getFixtures();
    getResult();
    getRanking();
  }


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }


  void getFixtures() async {
    await scheduleProvider.getFixtures().then((result){
      if(result.body?.response != null){
        result.body?.response?.sort((a,b){
          return (a.fixture?.date ?? "").compareTo(b.fixture?.date ?? "");
        });
        result.body?.response?.forEach((element) {
          if(element.fixture?.status?.long == "Not Started"){
            listFixture.add(element);
          }

        });
        update();
      }else{

      }
    });
  }

  bool isArsenal(String? name){
    return name == "Arsenal";
  }


  void getResult() async {
    await scheduleProvider.getFixtures().then((result){
      if(result.body?.response != null){
        result.body?.response?.sort((a,b){
          return (b.fixture?.date ?? "").compareTo(a.fixture?.date ?? "");
        });
        result.body?.response?.forEach((element) {

          if(element.fixture?.status?.long == "Match Finished"){
            listResult.add(element);
          }
        });
        update();
      }else{

      }
    });
  }

  void getRanking() async {
    await scheduleProvider.getRankClb().then((result){
      if(result.body?.response != null){
        result.body?.response?.forEach((element) {
            if(element.league?.standings != null){
              element.league?.standings?.forEach((standing) {
               List<dynamic> list = standing;
                list.forEach((element) {
                  Standings standings = Standings.fromJson(element);
                  listStandings.add(standings);
                });
                print('${listStandings.length}');
                update();
              });
            }

        });
        // update();
      }else{

      }
    });
  }



}