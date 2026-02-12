import 'package:boi_poka/explore/viewmodel/explore_viewmodel.dart';
import 'package:boi_poka/home/screen/home_screen.dart';
import 'package:boi_poka/home/viewmodel/home_view_model.dart';
import 'package:boi_poka/my_books/viewmodel/my_books_viewmodel.dart';
import 'package:boi_poka/navigation/main_navigation.dart';
import 'package:boi_poka/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import your ViewModels here as we build them
// import 'viewmodels/home_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  // await Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()..fetchHomeData()),
        ChangeNotifierProvider(create: (_) => ExploreViewModel()..fetchExploreData()),
        ChangeNotifierProvider(create: (_) => MyBooksViewModel()..fetchMyBooks()),
      ],
      child: const BoipokaApp(),
    ),
  );
}

class BoipokaApp extends StatelessWidget {
  const BoipokaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boipoka',
      debugShowCheckedModeBanner: false,
      theme: BoipokaTheme.lightTheme,
      // Home screen will be our first target
      home: const MainNavigationWrapper(), // We will replace this with HomeScreen()
    );
  }
}
