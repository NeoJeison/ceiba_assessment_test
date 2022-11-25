import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ceiba_assessment_test/core/router/router.dart';
import 'package:ceiba_assessment_test/dependency_injection.dart' as di;
import 'package:ceiba_assessment_test/core/utils/constants/styles.dart';
import 'package:ceiba_assessment_test/features/list_users/presentation/cubits/users_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return BlocProvider(
      create: (context) => di.getIt<UsersListCubit>()..getUsers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        title: 'Prueba de ingreso',
        theme: ThemeData(
          primarySwatch: MaterialColor(cGreen.value, cGreenSwatch),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            backgroundColor: cDarkGreen,
          ),
          canvasColor: Colors.white
        ),

        routes: appRouter.routes
      )
    );
  }
}
