import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/movie_bloc.dart';
import '../bloc/event_movie.dart';

class TabRecent extends StatefulWidget {
  const TabRecent({super.key});

  @override
  State<TabRecent> createState() => _TabRecentState();
}

class _TabRecentState extends State<TabRecent> {
  List<String> searchsRecent = [];

  @override
  void initState() {
    super.initState();
    loadingHistorico();
  }

  Future<void> loadingHistorico() async {
    final preferencias = await SharedPreferences.getInstance();
    setState(() {
      searchsRecent = preferencias.getStringList('searchs_recent') ?? [];
    });
  }

  void searchAPartirDoHistorico(String termSearch) {
    context.read<MovieBloc>().add(SearchMovies(termSearch));
    DefaultTabController.of(context).animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    if (searchsRecent.isEmpty) {
      return const Center(child: Text("Nenhuma pesquisa recent."));
    }

    return ListView.builder(
      itemCount: searchsRecent.length,
      itemBuilder: (context, indice) {
        final term = searchsRecent[indice];
        return ListTile(
          title: Text(term),
          trailing: const Icon(Icons.search),
          onTap: () => searchAPartirDoHistorico(term),
        );
      },
    );
  }
}
