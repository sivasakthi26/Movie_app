import 'package:flutter/material.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/services.dart';
import 'package:movie_app/widgets/movies_listview.dart';

import '../widgets/search.dart';
import '../widgets/upcoming.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Model> upcomingFuture,
      trendingFuture,
      popularMoviesFuture,
      popularTvFuture,
      topRatedFuture;
  late Future<Credit> creditsFuture;

  @override
  void initState() {
    upcomingFuture = getUpcomingMovies();
    trendingFuture = getTrendingMovies();
    popularMoviesFuture = getPopularMovies();
    topRatedFuture = getTopRatedMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: [
    //     const SizedBox(
    //       height: 25,
    //     ),
    //     UpcomingMovies(
    //       future: upcomingFuture,
    //     ),
    //     const SizedBox(
    //       height: 10,
    //     ),
    //     MoviesListView(future: trendingFuture, headlineText: 'Trending'),
    //     MoviesListView(
    //         future: popularMoviesFuture, headlineText: 'Popular Movies'),
    //
    //     MoviesListView(
    //         future: topRatedFuture, headlineText: 'Top Rated Movies'),
    //   ],
    // );
    var snapshot;
    return ListView(
      children: [
        GestureDetector(
          onTap: () {
            showSearch(context: context, delegate: Search());
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 70,
            child: Card(
              color: Colors.grey.withOpacity(.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Movie Search...'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            UpcomingMovies(
              future: upcomingFuture,
            ),
            MoviesListView(
              future: trendingFuture,
              headlineText: 'Trending',
            ),
            MoviesListView(
              future: popularMoviesFuture,
              headlineText: 'Popular Movies',
            ),
            MoviesListView(
              future: topRatedFuture,
              headlineText: 'Top Rated Movies',
            ),
          ],
        )
      ],
    );
  }
}
