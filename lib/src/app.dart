import 'package:atelieoliveira/src/data/database/shared_preferences_impl.dart';
import 'package:atelieoliveira/src/data/database/shared_preferences_interface.dart';
import 'package:atelieoliveira/src/data/repository/repository.dart';
import 'package:atelieoliveira/src/data/service/service.dart';
import 'package:atelieoliveira/src/feature/home/home_view.dart';
import 'package:atelieoliveira/src/feature/magazine_detail/magazine_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Service service = Service();
    final IsharedPreferencs sharedPrefs = SharedPreferencesImpl();
    final Repository repo = Repository(service: service, sharedPrefs: sharedPrefs);

    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case MagazineDetailView.routeName:
                return MagazineDetailView(repository: repo,);

              case HomeView.routeName:
              default:
                return HomeView(
                  repository: repo,
                );
            }
          },
        );
      },
    );
  }
}
