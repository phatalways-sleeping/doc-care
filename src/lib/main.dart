import 'package:components/components.dart';
import 'package:screens/screens.dart';
import 'package:utility/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:src/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:env_flutter/env_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');

  await Future.wait([
    /// Initialize Firebase
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),

    /// Initialize Supabase
    Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authFlowType: AuthFlowType.pkce,
    )
  ]);

  final key = GlobalKey<NavigatorState>();

  NotificationManager.init(key);

  runApp(MaterialApp(
    title: 'DocCare',
    theme: ThemeData(
      // This is the theme of your application.
      //
      // TRY THIS: Try running your application with "flutter run". You'll see
      // the application has a blue toolbar. Then, without quitting the app,
      // try changing the seedColor in the colorScheme below to Colors.green
      // and then invoke "hot reload" (save your changes or press the "hot
      // reload" button in a Flutter-supported IDE, or press "r" if you used
      // the command line to start the app).
      //
      // Notice that the counter didn't reset back to zero; the application
      // state is not lost during the reload. To reset the state, use hot
      // restart instead.
      //
      // This works for code too, not just values: Most code changes can be
      // tested with just a hot reload.
      colorScheme: const DocCareLightColorScheme(),
    ),
    home: MyApp(
      key: key,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage(
      title: 'DocCare',
    );
  }

  @override
  void dispose() {
    NotificationManager.instance.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const DCDoctorFilterScreen();
  }
}
