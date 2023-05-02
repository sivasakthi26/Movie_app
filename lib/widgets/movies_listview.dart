import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/pages/detail_page.dart';
import 'package:movie_app/utils.dart';
import '../models/movie_model.dart';
import '../pages/liked.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({
    required this.future,
    Key? key,
    required this.headlineText,
  }) : super(key: key);
  final String headlineText;
  final Future<Model> future;
  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder<Model>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.results;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headlineText,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 310,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            isTvShow: headlineText
                                                        .contains('Movies') ||
                                                    data[index].mediaType ==
                                                        MediaType.movie
                                                ? false
                                                : true,
                                            data: snapshot.data!,
                                            index: index),
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    '$imageUrl${data[index].posterPath}',
                                    height: 240,
                                    width: 190,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 250,
                                        width: 170,
                                        color: Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 7, sigmaY: 7),
                                    child: Container(
                                      height: 50,
                                      width: 195,
                                      // padding: const EdgeInsets.all(10),
                                      color: Colors.black26,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 0, left: 0),
                                            child: IconButton(
                                                onPressed: () {
                                                  print('icon:icons');
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Liked(),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(Icons
                                                    .favorite_outline_rounded)),
                                          ),

                                          Container(
                                            // width: MediaQuery.of(context).size.width/2,
                                            child: Text(
                                              data[index].title ??
                                                  data[index].name!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Text(
                                          //   getGenres(data[index].genreIds!),
                                          //   maxLines: 2,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: const TextStyle(
                                          //       fontSize: 12, color: Colors.white),
                                          // ),
                                        ],
                                      ),
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
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

//
// Container(
// width: 170,
// height: 50,
// margin: const EdgeInsets.only(left: 5),
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceEvenly,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(data[index].title ?? data[index].name!,
// overflow: TextOverflow.ellipsis,
// style: Theme.of(context)
// .textTheme
//     .bodyLarge),
// Text(
// data[index].genreIds!.isNotEmpty
// ? getGenres(data[index].genreIds!)
// : '',
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// color: Colors.grey.shade400,
// fontSize: 13),
// )
// ],
// ),
// ),
