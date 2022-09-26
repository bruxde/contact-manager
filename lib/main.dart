import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/presentation/routes/router.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/contact-list-page/contact_list_page.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => di.sl<ContactBloc>())],
      child: MyMaterialAppRouter(
        appRouter: _appRouter,
      ),
    );
  }
}

class MyMaterialAppRouter extends StatelessWidget {
  final AppRouter appRouter;

  const MyMaterialAppRouter({Key? key, required this.appRouter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
    );
  }
}
