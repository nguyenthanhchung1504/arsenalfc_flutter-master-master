import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/changeprofile/change_profile_bindings.dart';
import 'package:arsenalfc_flutter/ui/changeprofile/change_profile_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/more/more_binding.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/more/more_screen.dart';
import 'package:arsenalfc_flutter/ui/search/searchnews/search_news_binding.dart';
import 'package:arsenalfc_flutter/ui/search/searchnews/search_news_screen.dart';
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_binding.dart';
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_screen.dart';
import 'package:arsenalfc_flutter/ui/signin/sign_in_binding.dart';
import 'package:arsenalfc_flutter/ui/signin/sign_in_screen.dart';
import 'package:arsenalfc_flutter/ui/signup/sign_up_screen.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../ui/detailnew/detail_new_binding.dart';
import '../ui/detailnew/detail_new_screen.dart';
import '../ui/detailplayer/detail_player_binding.dart';
import '../ui/detailplayer/detail_player_screen.dart';
import '../ui/detailvideo/detail_video_binding.dart';
import '../ui/detailvideo/detail_video_screen.dart';
import '../ui/home/home_screen.dart';

import '../ui/home/tabs/news/news_binding.dart';
import '../ui/home/tabs/news/news_screen.dart';
import '../ui/home/tabs/players/players_binding.dart';
import '../ui/home/tabs/players/players_screen.dart';
import '../ui/home/tabs/schedules/schedules_binding.dart';
import '../ui/home/tabs/schedules/schedules_screen.dart';
import '../ui/home/tabs/videos/videos_binding.dart';
import '../ui/home/tabs/videos/videos_screen.dart';
import '../ui/signup/sign_up_binding.dart';

routes() => [
  GetPage(name: AppConst.SIGN_IN, page: () =>  SignInScreen(),binding: SignInBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SIGN_UP, page: () => SignUpScreen(),binding: SignUpBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.MAIN, page: () => MainScreen(),bindings: [SignInBinding()]),
  GetPage(name: AppConst.HOME, page: () => HomeScreen(),bindings: [NewsBinding(),VideosBinding(),SchedulesBinding(),PlayerBindings(),MoreBindings()]),
  GetPage(name: AppConst.NEWS, page: () => NewsScreen(),binding: NewsBinding()),
  GetPage(name: AppConst.VIDEOS, page: () => VideosScreen(),binding: VideosBinding()),
  GetPage(name: AppConst.SCHEDULES, page: () => SchedulesScreen(),binding: SchedulesBinding()),
  GetPage(name: AppConst.PLAYERS, page: () => PlayerScreen(),binding: PlayerBindings()),
  GetPage(name: AppConst.MORE, page: () => MoreScreen(),binding: MoreBindings()),
  GetPage(name: AppConst.DETAIL_NEWS, page: () =>   DetailNewScreen(),binding: DetailNewBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.DETAIL_VIDEOS, page: () =>  DetailVideoScreen(),binding: DetailVideoBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.DETAIL_PLAYER, page: () =>  DetailPlayerScreen(),binding: DetailPlayerBindings(),transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SEARCH_NEW, page: () => SearchNewsScreen(),binding: SearchNewsBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SEARCH_VIDEO, page: () => SearchVideoScreen(),binding: SearchVideoBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.CHANGE_PROFILE, page: () => ChangeProfileScreen(),binding: ChangeProfileBindings(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
];