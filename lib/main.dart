import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prent/provider.dart';
import 'package:provider/provider.dart';
import 'package:prent/provider_service/product_service.dart';
import 'package:prent/screens/splash_screen.dart';

void main() => runApp(
      EasyLocalization(
        child: ChangeNotifierProvider(
          child: MyApp(),
          create: (BuildContext context) => Logic(),
        ),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return ChangeNotifierProvider(
      create: (context) => Category(),
      child: EasyLocalizationProvider(
        data: data,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'prent',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            //app-specific localization
            EasylocaLizationDelegate(
              locale: data.locale,
              path: 'resources/langs',
            ),
          ],
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'DZ')],
          locale: data.savedLocale,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
