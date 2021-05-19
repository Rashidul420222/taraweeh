import 'package:flutter/material.dart';
import './provider/user_provider.dart';
import './screens/home.dart';
import './screens/login1.dart';
import './widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.green),
        home: ScreensController(),
      )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginOne();
      case Status.Authenticated:
        return HomeScreen();
      default:
        return LoginOne();
    }
  }
}

// LETS KEEP THE SPLASH SCREEN HERE FOR NOW
