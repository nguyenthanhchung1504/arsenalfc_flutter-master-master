import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/search/searchnews/search_news_binding.dart';
import 'package:arsenalfc_flutter/ui/search/searchnews/search_news_screen.dart';
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_binding.dart';
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_screen.dart';
import 'package:arsenalfc_flutter/ui/signin/sign_in_binding.dart';
import 'package:arsenalfc_flutter/ui/signin/sign_in_screen.dart';
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

routes() => [
  GetPage(name: AppConst.SIGN_IN, page: () => const SignInScreen(),binding: SignInBinding()),
  GetPage(name: AppConst.MAIN, page: () => const MainScreen(),bindings: [NewsBinding(),VideosBinding(),SchedulesBinding(),PlayerBindings(),SignInBinding()]),
  GetPage(name: AppConst.HOME, page: () => HomeScreen()),
  GetPage(name: AppConst.NEWS, page: () => NewsScreen(),binding: NewsBinding()),
  GetPage(name: AppConst.VIDEOS, page: () => const VideosScreen(),binding: VideosBinding()),
  GetPage(name: AppConst.SCHEDULES, page: () => const SchedulesScreen(),binding: SchedulesBinding()),
  GetPage(name: AppConst.PLAYERS, page: () => const PlayerScreen(),binding: PlayerBindings()),
  GetPage(name: AppConst.DETAIL_NEWS, page: () =>  const DetailNewScreen(),binding: DetailNewBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.DETAIL_VIDEOS, page: () => const DetailVideoScreen(),binding: DetailVideoBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.DETAIL_PLAYER, page: () => const DetailPlayerScreen(),binding: DetailPlayerBindings(),transition: Transition.zoom,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SEARCH_NEW, page: () => SearchNewsScreen(),binding: SearchNewsBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
  GetPage(name: AppConst.SEARCH_VIDEO, page: () => SearchVideoScreen(),binding: SearchVideoBinding(),transition: Transition.rightToLeftWithFade,transitionDuration: const Duration(milliseconds: 500)),
];