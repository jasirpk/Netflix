import 'package:flutter/material.dart';
import 'package:netflix/Common/utils.dart';

class Movie_Card_widget<T> extends StatelessWidget {
  final Future<T> future;
  final String headLIneText;

  const Movie_Card_widget({
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
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                          "${imageUrl}${data[index].posterPath}",
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
