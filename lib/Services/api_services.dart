import 'dart:convert';
import 'dart:developer';

import 'package:netflix/Common/utils.dart';
import 'package:netflix/models/nowplaying_model.dart';
import 'package:netflix/models/popular_movie.dart';
import 'package:netflix/models/search_model.dart';
import 'package:netflix/models/tvseries_model.dart';
import 'package:netflix/models/upcoming_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPont;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovie() async {
    endPont = "movie/upcoming";
    final url = "$baseUrl$endPont$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load upcoming movies");
  }

  Future<NowPlayingMovieModel> getNowPlayingMovies() async {
    endPont = "movie/now_playing";
    final url = "$baseUrl$endPont$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success");
      return NowPlayingMovieModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load Now movies");
  }

  Future<TvSeriesModel> getTopRatedSeries() async {
    endPont = "tv/top_rated";
    final url = "$baseUrl$endPont$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success");
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load Top Rated Series");
  }

  Future<PopularMoviesModel> getPopularMovies() async {
    endPont = "movie/popular";
    final url = "$baseUrl$endPont$key";

    final response = await http.get(Uri.parse(url), headers: {});
    if (response.statusCode == 200) {
      log("Success");
      return PopularMoviesModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load Poular movies");
  }

  Future<SearchModel> getSearchedMovies(String searchText) async {
    endPont = "search/movie?query=$searchText";
    final url = "$baseUrl$endPont";
    print(url);
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("Success");
      return SearchModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to Search movies");
  }
}
