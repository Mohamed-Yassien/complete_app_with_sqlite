import 'package:dog/providers/dogs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: DogsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
          accentColor: Colors.purple,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
