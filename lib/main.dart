import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata_app/features/reminder/model/time_of_day.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'common/route_manager.dart';
import 'features/reminder/model/reminder_model.dart';
import 'package:timezone/data/latest.dart' as tz;

late Box sessionBox;
late Box branchBox;
final boxA = Provider((ref) => []);
final boxB = Provider<List<ReminderModel>>((ref) => []);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    )
  );

  tz.initializeTimeZones();
  await Hive.initFlutter();
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(ReminderModelAdapter());
  final reminderBox = await Hive.openBox<ReminderModel>('ReminderBox');
  sessionBox = await Hive.openBox('loginSession');
  branchBox = await Hive.openBox('branchInfo');
  final userBox = await Hive.openBox('userLoginData');
  runApp(
     ProviderScope(
      overrides: [
        boxA.overrideWithValue(userBox.values.toList()),
        boxB.overrideWithValue(reminderBox.values.toList())
      ],
      child: const KhataApp(),
    ),
  );
}

class KhataApp extends StatelessWidget {
  const KhataApp({Key? key}) : super(key: key); //default constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 926,
        minWidth: 428,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(428, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(700, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        ],
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
