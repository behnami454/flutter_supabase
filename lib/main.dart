import 'package:flutter/material.dart';
import 'package:flutter_supabase/configs/bloc_provider.dart';
import 'package:flutter_supabase/configs/routes.dart';
import 'package:flutter_supabase/configs/shared_prefrences.dart';
import 'package:flutter_supabase/api/supabase_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await PreferencesService().getLoggedIn();
  runApp(MyApp(startRoute: isLoggedIn ? Routes.routeHome : Routes.routeLogin));
}

class MyApp extends StatelessWidget {
  final String startRoute;
  const MyApp({super.key, required this.startRoute});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      supabaseManager: SupabaseManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Supabase',
        initialRoute: startRoute,
        routes: Routes.routes,
      ),
    );
  }
}
