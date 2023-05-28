import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'Menu/menu.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final _drawerController = ZoomDrawerController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Extract theme data into a separate method
  ThemeData _buildThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.activeBlue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      theme: _buildThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
    _initializeNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      borderRadius: 24,
      style: DrawerStyle.style1,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      menuScreen: const MenuView(),
      mainScreen: MainScreen(drawerController: _drawerController),
    );
  }
}

class MainScreen extends StatelessWidget {
  final ZoomDrawerController drawerController;

  const MainScreen({Key? key, required this.drawerController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () => drawerController.toggle?.call(),
          child: const Icon(CupertinoIcons.bars, size: 28, color: Colors.white),
        ),
      ),
      child: const Center(
        child: Text(
          'Welcome to Crafted Manager App!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// Initialize Notification settings
Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
}

// Handle the reception of a local notification
Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {}

// Handle the user's response to a notification
Future<void> onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  debugPrint('notification payload: ${notificationResponse.payload}');
}
