import 'package:buzz/provider/proviercolors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'appstaticdata/routes.dart';
import 'login_signup/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorNotifire(),
        ),
      ],
      child: GetMaterialApp(
        locale: const Locale('en', 'US'),
        translations: AppTranslations(),
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.initial,
        getPages: getPage,
        title: 'Buzz.',
        theme: ThemeData(
            useMaterial3: false,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            fontFamily: "Gilroy",
            dividerColor: Colors.transparent,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF0059E7),
            )),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'enter_mail': 'Enter your email',
        },
        'ur_PK': {
          'enter_mail': 'اپنا ای میل درج کریں۔',
        }
      };
}
