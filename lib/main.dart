import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_training/config/firebase_options.dart';
import 'package:riverpod_training/routing/app_router.dart';
import 'package:riverpod_training/routing/router_enum.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(AppRoute.tasks.path);
  runApp(const ProviderScope(child: MyApp()));
}

//stlと打つと stlConsumerという候補が出てくるので、それを押すとConsumerWidgetの雛形ができる
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
