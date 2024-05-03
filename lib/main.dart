import 'package:flutter/material.dart';
import 'package:listafilmes/pages/movie_list/movie_list_page.dart';
import 'package:listafilmes/service_locator.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF15173D),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xffbb86fc),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(21, 23, 61, 1),
        ),
        useMaterial3: true,
      ),
      home: const MovieListPage(),
    );
  }
}
