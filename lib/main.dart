import 'package:card_app/database/app_database.dart';
import 'package:card_app/database/cards_data.dart';
import 'package:card_app/presentation/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<CardData> debitBox;
late Box<CardData> creditBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase().initialize();
  debitBox = await Hive.openBox<CardData>(AppDatabase.debitCardBox);
  creditBox = await Hive.openBox<CardData>(AppDatabase.creditCardBox);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
          )),
      home: Dashboard(),
    );
  }
}
