import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/Common/utils.dart';
import 'package:netflix/Screens/movie_detail.dart';
import 'package:netflix/Services/api_services.dart';
import 'package:netflix/models/search_model.dart';
import 'package:netflix/widgets/popular_card.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchModel? searchModel;
  ApiServices apiService = ApiServices();
  void Search(String query) {
    apiServices.getSearchedMovies(query).then((results) {
      setState(() {
        searchModel = results;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CupertinoSearchTextField(
                    backgroundColor: Colors.white24,
                    controller: searchController,
                    padding: EdgeInsets.all(10),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      if (value.isEmpty) {
                      } else {
                        Search(searchController.text);
                      }
                    },
                  ),
                ),
                searchController.text.isEmpty
                    ? Popular_Widget_Screen(
                        future: apiService.getPopularMovies(),
                        headLIneText: "Top Searches")
                    : searchModel == null
                        ? SizedBox.shrink()
                        : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: searchModel?.results.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1.2 / 2,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetail_Screen(
                                                  movieId: searchModel!
                                                      .results[index].id)));
                                },
                                child: Column(
                                  children: [
                                    searchModel?.results[index].backdropPath ==
                                            null
                                        ? Image.asset(
                                            "assets/images/BrandAssets_Logos_02-NSymbol.jpg",
                                            height: 170,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "${imageUrl}${searchModel!.results[index].backdropPath}",
                                            height: 170,
                                          ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        searchModel!
                                            .results[index].originalTitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
              ],
            ),
          ),
        ));
  }
}
