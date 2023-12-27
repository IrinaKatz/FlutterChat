import 'package:flutter/material.dart';
import 'package:my_first_project/chat_page.dart';
import 'package:my_first_project/services/auth_service.dart';
import 'package:my_first_project/utils/styles.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) { return AuthService(); },
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        textTheme: AppStyles.textTheme,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        primaryColor: AppStyles.primaryColor,
        primarySwatch: Colors.lightBlue,
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData && snapshot.data!) {
              return ChatPage();
            } else {
              return LoginPage();
            }
          }
          return CircularProgressIndicator();
        },
        future: context.read<AuthService>().isLoggedIn(),
      ),
      routes: {
        '/chat': (context) => ChatPage()
      },
    );
  }
}
