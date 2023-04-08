import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fridge_it/firebase_options.dart';
import 'package:fridge_it/services/firebase_message.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/widgets/splash.dart';
import 'package:get/get.dart';


final FMessaging messaging = FMessaging();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(
      (message) => _firebaseMessagingBackgroundHandler(message));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        //useMaterial3: true,
        fontFamily: 'Poppins', 
      ),
      home: const SplashScreen(),

    );
  }
}
