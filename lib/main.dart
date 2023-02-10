import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/workout_data.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hhkvewtdfkidiyaaawsv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhoa3Zld3RkZmtpZGl5YWFhd3N2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzU1MzY4MDUsImV4cCI6MTk5MTExMjgwNX0.cT45uzcOO8rdPdR_R58AAnWPUE9NDymGPA1iRhqhg1k',
  );

  runApp(MyApp());
}
// It's handy to then extract the Supabase client in a variable for later uses
final supabase = Supabase.instance.client;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
      );
  }
}