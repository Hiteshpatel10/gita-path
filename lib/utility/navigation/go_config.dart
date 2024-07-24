import 'package:chapter/auth_module/views/sign_in_view.dart';
import 'package:chapter/chapter_module/views/chapter_detail_view.dart';
import 'package:chapter/chapter_module/views/chapters_view.dart';
import 'package:chapter/main.dart';
import 'package:chapter/utility/navigation/app_routes.dart';
import 'package:chapter/verse_module/views/verse_view.dart';
import 'package:go_router/go_router.dart';


final goConfig = GoRouter(
  initialLocation: prefs.getBool('signIn') == true? AppRoutes.chapters : AppRoutes.signIn,
  routes: [
    GoRoute(
      path: AppRoutes.signIn,
      name: AppRoutes.signIn,
      builder: (context, state) {
        return const SignInView();
      },
    ),
    GoRoute(
      path: AppRoutes.chapters,
      name: AppRoutes.chapters,
      builder: (context, state) {
        return const ChaptersView();
      },
    ),
    GoRoute(
      path: AppRoutes.chapterDetail,
      name: AppRoutes.chapterDetail,
      builder: (context, state) {
        final arguments = state.extra as Map<String, dynamic>;
        final chapterNo = arguments["chapter_no"] as int;

        return ChapterDetailView(chapterNo: chapterNo);
      },
    ),
    GoRoute(
      path: AppRoutes.verse,
      name: AppRoutes.verse,
      builder: (context, state) {
        final arguments = state.extra as Map<String, dynamic>;

        print("------------- $arguments");
        final verseNo = arguments["verse_no"] as int;
        final chapterNo = arguments["chapter_no"] as int;
        return VerseView(chapterNo: chapterNo, verseNo: verseNo);
      },
    )
  ],
);
