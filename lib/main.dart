import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saudi_guide/Cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:saudi_guide/Cubits/chat_list_cubit.dart';
import 'package:saudi_guide/Cubits/my_recomendation_repo/my_recomendation_cubit.dart';
import 'package:saudi_guide/Screens/splash_screen.dart';

import 'Cubits/ScanCubit/scan_land_mark_cubit.dart';
import 'Cubits/WeatherCubit/weather_forcast_cubit.dart';
import 'Cubits/translate_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScanLandMarkCubit(),
        ),
        BlocProvider(
          create: (context) => WeatherForecastCubit(),
        ),
        BlocProvider(
          create: (context) => MyRecommendationCubit(),
        ),
        BlocProvider(
          create: (context) => ChatBotCubit(),
        ),
        BlocProvider(
          create: (context) => ChatListCubit([]),
        ),
        BlocProvider(create: (context) => TranslateListCubit())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          theme: ThemeData(
              // useMaterial3: true
              ),
          home: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            splitScreenMode: true,
            builder: (context, child) => const SplashScreen(),
          )),
    );
  }
}
