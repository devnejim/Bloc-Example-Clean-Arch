import 'package:bloc_app_example/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:bloc_app_example/features/posts/presentation/screens/posts_screen.dart';
import 'package:bloc_app_example/features/posts/presentation/widgets/posts_screen/add_post_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: unused_import
import 'package:mocktail/mocktail.dart';
// ignore: unused_import
import 'package:bloc_app_example/dependencies_injector.dart' as sl;

class PostsScreenRobot {
  PostsScreenRobot(this.tester);
  final WidgetTester tester;

  Future<void> waitFor(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  Future<void> pumpPostsScreen() async {
    await tester.pumpWidget(
      BlocProvider(
        create: (context) => sl.getIt<PostsBloc>(),
        child: const MaterialApp(
          home: PostsScreen(),
        ),
      ),
    );
  }

  void expectTitleFound(String screenTitle) {
    final titleFinder = find.text(screenTitle);
    expect(titleFinder, findsOneWidget);
  }

  void expectOneFABFound() {
    final fabFinder = find.byType(FloatingActionButton);
    expect(fabFinder, findsOneWidget);
  }

  Future<void> openAddPostDialog() async {
    final fabFinder = find.byType(FloatingActionButton);
    await tester.tap(fabFinder);
    await tester.pump();
  }

  void expectDialogIsOpened() {
    expect(find.byType(TextField), findsNWidgets(2));
  }

  Future<void> tapDialogCancel() async {
    final cancelButton = find.byKey(kPopPostDialogKey);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  Future<void> tapDialogAdd() async {
    final addButton = find.byKey(kConfirmPostDialogKey);
    await tester.tap(addButton);
    await tester.pumpAndSettle();
  }

  void expectDialogDismissed() {
    expect(find.byType(TextField), findsNothing);
  }

  Future<void> enterTitleTextFieldText(String title) async {
    final titleTextField = find.byKey(kTitleTextFieldKey);
    await tester.enterText(titleTextField, title);
  }

  Future<void> enterBodyTextFieldText(String body) async {
    final titleTextField = find.byKey(kBodyTextFieldKey);
    await tester.enterText(titleTextField, body);
  }
}
