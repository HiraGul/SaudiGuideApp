import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saudi_guide/Cubits/ORCCubit/ocrcubit_cubit.dart';
import 'package:saudi_guide/Cubits/change_index_cubit.dart';
import 'package:saudi_guide/Cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:saudi_guide/Cubits/chat_list_cubit.dart';
import 'package:saudi_guide/Cubits/my_recomendation_repo/my_recomendation_cubit.dart';
import 'package:saudi_guide/Cubits/stable_disfussion_repo/text_to_image_cubit.dart';
import 'package:saudi_guide/Screens/splash_screen.dart';

import 'Cubits/ScanCubit/scan_land_mark_cubit.dart';
import 'Cubits/WeatherCubit/weather_forcast_cubit.dart';
import 'Cubits/translate_list_cubit.dart';
import 'Screens/bottom_navigation_screen/bottom_navigtion_screen.dart';
import 'Utils/shared_prefs.dart';

dynamic userName;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPrefs.init();
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
          create: (context) => OcrcubitCubit(),
        ),
        BlocProvider(
          create: (context) => ChatListCubit([]),
        ),
        BlocProvider(create: (context) => TranslateListCubit()),
        BlocProvider(create: (context) => TextToImageCubit()),
        BlocProvider(create: (context) => ChangeIndexCubit())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          theme: ThemeData(),
          home: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            splitScreenMode: true,
            builder: (context, child) => MySharedPrefs.getIsLoggedIn() == null
                ? const SplashScreen()
                : const BottomNavigationScreen(),
          )),
    );
  }
}
