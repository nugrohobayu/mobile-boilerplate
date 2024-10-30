import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_boilerplate/application/constant/color_palette.dart';
import 'package:mobile_boilerplate/application/helper/size_config.dart';
import 'package:mobile_boilerplate/routes/route_list.dart';
import 'package:mobile_boilerplate/routes/route_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

/// Route configuration.
final GoRouter _router = GoRouter(
  observers: [CoreRouteObserver()],
  routes: listRoute,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig.initOnStartUp(context);
    
    return MaterialApp.router(
      title: 'Flutter Boilerplate',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              fontSize: SizeConfig.baseFontSize * 5.5,
              fontWeight: FontWeight.w500,
              color: ColorPalette.black,
            )),
      ),
    );
  }
}
