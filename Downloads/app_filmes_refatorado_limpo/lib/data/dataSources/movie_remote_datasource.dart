import 'package:dio/dio.dart';
import '../models/movie_model.dart';

class MovieRemoteDataSource {
  final Dio clienteHttp = Dio();
  final String chaveApi = 'a9963bcd';

  Future<List<MovieModel>> searchMovies(String termSearch) async {
    final resposta = await clienteHttp.get(
      'http://www.omdbapi.com/',
      queryParameters: {
        'apikey': chaveApi,
        's': termSearch,
      },
    );

    if (resposta.data['Response'] == 'True') {
      return (resposta.data['Search'] as List)
          .map((json) => MovieModel.deJson(json))
          .toList();
    } else {
      throw Exception(resposta.data['Error']);
    }
  }
}
