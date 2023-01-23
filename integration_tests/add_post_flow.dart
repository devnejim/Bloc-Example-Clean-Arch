import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bloc_app_example/dependencies_injector.dart' as sl;

import '../test/robots/posts_screen_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late PostsScreenRobot r;
  const screenTitle = 'All Posts Screen';
  const postTitle = 'post title goes here';
  const postBody = 'post body goes here';

  testWidgets('render posts screen and add post workflow', (tester) async {
    r = PostsScreenRobot(tester);
    await tester.runAsync(() async {
      await sl.ServiceLocator.init();
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
