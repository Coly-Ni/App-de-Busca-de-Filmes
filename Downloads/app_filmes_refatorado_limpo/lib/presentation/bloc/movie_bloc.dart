import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_movie.dart';
import 'movie_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/datasources/movie_remote_datasource.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRemoteDataSource dataSource;

  MovieBloc(this.dataSource) : super(MovieInitial()) {
    on<SearchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        await saveRecentSearch(event.query);
        final movies = await dataSource.searchMovies(event.query);
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }

  Future<void> saveRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('recent_searches') ?? [];

    if (history.contains(query)) {
      history.remove(query); // remove duplicado
    }

    history.insert(0, query); // adiciona no topo

    if (history.length > 5) {
      history = history.sublist(0, 5); // mantém só os 5 primeiros
    }

    await prefs.setStringList('recent_searches', history);
  }
}
