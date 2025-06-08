import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:recipe_prokit/screens/RCSplashScreen.dart';
import 'package:recipe_prokit/store/AppStore.dart';
import 'package:recipe_prokit/utils/AppTheme.dart';
import 'package:recipe_prokit/utils/RCConstants.dart';
import 'package:recipe_prokit/utils/RCDataGenerator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://wmqshrhxjezmhkwnphrg.supabase.co', // Supabase projenizin URL'sini buraya ekleyin
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndtcXNocmh4amV6bWhrd25waHJnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY3MjY1MjAsImV4cCI6MjAzMjMwMjUyMH0.Etiy-l3TshmRsTdlkTcGqrS8Az8HIGiQ7Fri0Vnybgk', // Supabase projenizin anon anahtarını buraya ekleyin
  );

  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sneaker Shopping${!isMobile ? ' ${platformName()}' : ''}',
        home: RCSplashScreen(),
        theme: !appStore.isDarkModeOn
            ? AppThemeData.lightTheme
            : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
