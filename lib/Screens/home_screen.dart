import 'package:flutter/material.dart';
import 'package:netflix/Common/utils.dart';
import 'package:netflix/Services/api_services.dart';
// import 'package:netflix/models/nowplaying_model.dart';
import 'package:netflix/models/upcoming_model.dart';
import 'package:netflix/widgets/movie_card.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  // late Future<NowPlayingMovieModel> nowPlayingFuture;

  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upcomingFuture = apiServices.getUpcomingMovie();
    // nowPlayingFuture = apiServices.getNowPlayingMovies();
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
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(color: Colors.blue, height: 27, width: 27),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 220,
                child: Movie_Card_widget(
                    future: upcomingFuture, headLIneText: "Upcoming Movies"),
              ),
              // SizedBox(
              //   height: 220,
              //   child: Movie_Card_widget(
              //       future: nowPlayingFuture, headLIneText: "Now Playing"),
              // ),
            ],
          ),
        ));
  }
}
