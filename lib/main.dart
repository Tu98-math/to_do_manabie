import 'package:flutter/material.dart';

import 'app/app.dart';
import 'base/base_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, watch, _) {
          return const App();
        },
      ),
    );
  }
}
