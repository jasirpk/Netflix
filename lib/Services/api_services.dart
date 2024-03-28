import 'dart:convert';
import 'dart:developer';

import 'package:netflix/Common/utils.dart';
// import 'package:netflix/models/nowplaying_model.dart';
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

  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    endPont = "movie/now_playing";
    final url = "$baseUrl$endPont$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load Now movies");
  }
}
