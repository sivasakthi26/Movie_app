import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/detail_page.dart';
import 'package:movie_app/utils.dart';
import 'package:movie_app/widgets/carousel_slider.dart';
import '../models/movie_model.dart';
import '../pages/liked.dart';

class UpcomingMovies extends StatelessWidget {
  const UpcomingMovies({required this.future, Key? key}) : super(key: key);
  final Future<Model> future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Model>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.results;
          return Container(
            // width: MediaQuery.of(context).size.width * 11/2,
          child:Column(
              children: [
                Text(
                  'Upcoming Movies',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyCarouselSlider(
                  itemCount: data!.length,
                  itemBuilder: (context, index, realindex) {
                    print('id:${data[index].id}');
                    print('title:${data[index].title}');
                    print('votecount:${data[index].voteCount}');
                    print('posterpath:${data[index].posterPath}');
                    print('overview:${data[index].overview}');

                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      isTvShow: false,
                                      data: snapshot.data!,
                                      index: index),
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              '$imageUrl${data[index].posterPath!}',
                              width: 194.5,
                              height: 290,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              height: 50,
                              width: 195,
                              // padding: const EdgeInsets.all(10),
                              color: Colors.black26,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 0,left: 0),
                                    child: IconButton(
                                        onPressed: () {
                                          print('icon:icons');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const Liked(),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.favorite_outline_rounded)),
                                  ),

                                  Text(
                                    data[index].title ?? data[index].name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,

                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  SizedBox(height: 10,),
                                  // Text(
                                  //   getGenres(data[index].genreIds!),
                                  //   overflow: TextOverflow.ellipsis,
                                  //   style: const TextStyle(
                                  //       fontSize: 12, color: Colors.white),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),

          );
        } else if (snapshot.hasError) {
          throw snapshot.error.toString();
        } else {
          return Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
