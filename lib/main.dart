import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app/constant.dart';
import 'package:movies_app/cubits/add_favourite_cubit/add_favourite_cubit.dart';
import 'package:movies_app/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:movies_app/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('favBox');
  // await box.clear();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddFavCubit()),
        BlocProvider(create: (context) => FavCubit()),
      ],
      child: 
      // SafeArea(
        // child:
         MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: kPrimaryColor,
          ),
          home: SplashScreen(),
        ),
      // ),
    );
  }
}
