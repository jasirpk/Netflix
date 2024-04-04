import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/tvseries_model.dart';

class carousal_Widget_Screen extends StatelessWidget {
  final TvSeriesModel data;

  const carousal_Widget_Screen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  CachedNetworkImage(imageUrl: "$imageUrl$url"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    data.results[index].name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          },
          options: CarouselOptions(
              height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
              aspectRatio: 16 / 9,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(microseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal)),
    );
  }
}
