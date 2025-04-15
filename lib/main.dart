import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/movie_remote_datasource.dart';
import 'presentation/bloc/movie_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => MovieBloc(MovieRemoteDataSource()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: PageInitial(),
    );
  }
}
