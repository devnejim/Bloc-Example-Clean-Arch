import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_app_example/dependencies_injector.dart' as sl;

import '../../../../robots/posts_screen_robot.dart';

void main() async {
  late PostsScreenRobot r;
  await sl.ServiceLocator.init();
  const screenTitle = 'All Posts Screen';
  const postTitle = 'post title goes here';
  const postBody = 'post body goes here';
  testWidgets(
      '''pump posts screen and
         open add post dialog
         with performing cancel action
      ''',
      (tester) async {
    r = PostsScreenRobot(tester);
    await tester.runAsync(() async {
      await r.pumpPostsScreen();
      r.expectTitleFound(screenTitle);
    });
    r.expectOneFABFound();
    await r.openAddPostDialog();
    r.expectDialogIsOpened();
    await r.tapDialogCancel();
    r.expectDialogDismissed();
  });

  testWidgets(
      '''pump posts screen and
         open add post dialog
         fill the textFields
         perform add action
      ''',
      (tester) async {
    r = PostsScreenRobot(tester);
    await tester.runAsync(() async {
      await r.pumpPostsScreen();
      r.expectTitleFound(screenTitle);
    });
    r.expectOneFABFound();
    await r.openAddPostDialog();
    r.expectDialogIsOpened();
    await r.enterTitleTextFieldText(postTitle);
    await r.enterBodyTextFieldText(postBody);
    await r.tapDialogAdd();
    r.expectDialogDismissed();
  });
}
