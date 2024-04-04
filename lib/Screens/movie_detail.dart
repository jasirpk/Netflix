import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/Services/api_services.dart';
import 'package:netflix/models/movie_detail.dart';
import 'package:netflix/models/recommentation.dart';
import 'package:netflix/widgets/popular_card.dart';

class MovieDetail_Screen extends StatefulWidget {
  final int movieId;

  const MovieDetail_Screen({super.key, required this.movieId});

  @override
  State<MovieDetail_Screen> createState() => _MovieDetail_ScreenState();
}

class _MovieDetail_ScreenState extends State<MovieDetail_Screen> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetatilsModel> movieDetail;
  late Future<MovieRecommendationModel> movieRecommendationModel;
  @override
  void initState() {
    super.initState();
    fetchInitData();
  }

  fetchInitData() {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    movieRecommendationModel =
        apiServices.getMovieRecommendation(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(widget.movieId);
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<MovieDetatilsModel>(
        future: movieDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return Text('No data available');
          } else {
            final movie = snapshot.data;
            String genresText =
                movie!.genres.map((genre) => genre.name).join(', ');
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                "${imageUrl}${movie.posterPath}",
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            SizedBox(
                              width: 42,
                            ),
                            Flexible(
                              child: Text(
                                genresText,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FutureBuilder(
                          future: movieRecommendationModel,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final movie = snapshot.data;
                              return movie!.results.isEmpty
                                  ? Popular_Widget_Screen(
                                      future: apiServices.getPopularMovies(),
                                      headLIneText: 'Trending Movies')
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'More Like this',
                                          maxLines: 6,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemCount: movie.results.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 15,
                                            childAspectRatio: 1.5 / 2,
                                          ),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetail_Screen(
                                                      movieId: movie
                                                          .results[index].id,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${movie.results[index].posterPath}",
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    );
                            }
                            return Popular_Widget_Screen(
                                future: apiServices.getPopularMovies(),
                                headLIneText: "Trending Movies");
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
