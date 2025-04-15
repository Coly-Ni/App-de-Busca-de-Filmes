import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_bloc.dart';
import '../bloc/event_movie.dart';
import '../bloc/movie_state.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({super.key});

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  final TextEditingController campoSearch = TextEditingController();

  void searchMovies() {
    final term = campoSearch.text.trim();
    if (term.isNotEmpty) {
      context.read<MovieBloc>().add(SearchMovies(term));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: campoSearch,
            decoration: InputDecoration(
              labelText: 'Digite o nome do filme',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: searchMovies,
              ),
            ),
            onSubmitted: (_) => searchMovies(),
          ),
        ),
        Expanded(
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieInitial) {
                return const Center(child: Text("Digite algo para pesquisar."));
              } else if (state is MovieLoaded) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                final movies = state.movies;
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (_, indice) {
                    final movie = movies[indice];
                    return ListTile(
                      title: Text(movie.title),
                      subtitle: Text("Ano: ${movie.year}"),
                      leading: Image.network(movie.poster, width: 50),
                    );
                  },
                );
              } else if (state is MovieError) {
                return Center(child: Text("Error: ${state.message}"));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
