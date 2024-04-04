import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/screens/movie_detail.dart';

class Popular_Widget_Screen<T> extends StatelessWidget {
  final Future<T> future;
  final String headLIneText;

  const Popular_Widget_Screen({
    Key? key,
    required this.future,
    required this.headLIneText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the future to complete
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 5.0,
            ),
          );
        } else if (snapshot.hasError) {
          // Show an error message if the future throws an error
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null) {
          // Show a placeholder or an empty widget if the data is null
          return Text('No data available');
        } else {
          // Access the data when it's available
          var data = (snapshot.data as dynamic).results;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headLIneText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetail_Screen(
                                      movieId: data[index].id,
                                    )));
                      },
                      child: Container(
                        height: 150,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              "${imageUrl}${data[index].posterPath}",
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox(
                                width: 260,
                                child: Text(
                                  data[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
