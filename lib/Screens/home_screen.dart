import 'package:flutter/material.dart';
import 'package:netflix/Common/utils.dart';
import 'package:netflix/Screens/profile.dart';
import 'package:netflix/Screens/search_screen.dart';
import 'package:netflix/Services/api_services.dart';
import 'package:netflix/models/nowplaying_model.dart';
import 'package:netflix/models/popular_movie.dart';
import 'package:netflix/models/tvseries_model.dart';
import 'package:netflix/models/upcoming_model.dart';
import 'package:netflix/widgets/carousal_widget.dart';
import 'package:netflix/widgets/movie_card.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  late Future<TvSeriesModel> topRatedSeries;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    topRatedSeries = apiServices.getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/images/netflix-logo.webp',
            height: 80,
            width: 140,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Search_Screen()));
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome_Netflix()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(color: Colors.blue, height: 27, width: 27),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: topRatedSeries,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return carousal_Widget_Screen(data: snapshot.data!);
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
              SizedBox(
                  height: 260,
                  child: Movie_Card_widget<NowPlayingMovieModel>(
                    future: ApiServices().getNowPlayingMovies(),
                    headLIneText: 'Now Playing',
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 260,
                child: Movie_Card_widget<UpcomingMovieModel>(
                  future: ApiServices().getUpcomingMovie(),
                  headLIneText: 'Upcoming Movies',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 260,
                child: Movie_Card_widget<PopularMoviesModel>(
                  future: ApiServices().getPopularMovies(),
                  headLIneText: 'Popular Movies',
                ),
              ),
            ],
          ),
        ));
  }
}
