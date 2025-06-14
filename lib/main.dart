import 'package:chat_app/cubit/authcubit.dart';
import 'package:chat_app/cubit/authstate.dart';
import 'package:chat_app/repositries/routes.dart';
import 'package:chat_app/repositries/servicelocator.dart';
import 'package:chat_app/screens/homescreen.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/theme/mytheme.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async{ 
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await servicelocator();
  runApp(
   MyApp(), // Wrap your app
  
);}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      navigatorKey: getit<Approute>().navigatorkey,
      theme: AppTheme.lightTheme,
      //darkTheme: ThemeData.light(),
     
      home:  BlocBuilder<Authcubit, Authstate>(
          bloc: getit<Authcubit>(),
          builder: (context, state) {
            if (state.status == AuthStatus.initial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (state.status == AuthStatus.authenticated) {
              return const Homescreen();
            }
            return const LoginPage();
          },
        ),
    );
  }
}



