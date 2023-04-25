import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';

import '../models/credit_model.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
var key = '?api_key=3894fcbb8bfa5544457ff6c97e2b833b';
late String endPoint;

Future<Model> getUpcomingMovies() async {
  endPoint = 'movie/upcoming';
  final url = '$baseUrl$endPoint$key';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var body = response.body;
    var tre2 = modelFromJson(body);
    print('upcoming:${response.body}');
    print('page:${tre2.page}');
    print('upcomingmovies:${response.body}');
    print('id:${tre2.results[0].id}');
    print('title:${tre2.results[0].title}');
    print('voteAverage:${tre2.results[0].voteAverage}');
    print('releaseDate:${tre2.results[0].releaseDate}');
    print('popularity:${tre2.results[0].popularity}');
    print('overview:${tre2.results[0].overview}');
    print('posterPath:${tre2.results[0].posterPath}');
    print('votecount:${tre2.results[0].voteCount}');
    print('popular:${response.body}');
    return modelFromJson(response.body);
  } else {
    throw Exception('failed to load trending');
  }
}

Future<Model> getTrendingMovies() async {
  endPoint = 'trending/all/day';
  final url = '$baseUrl$endPoint$key';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var body = response.body;
    var tre = modelFromJson(body);
    print('trending:${response.body}');
    print('page:${tre.page}');
    print('trendingmovies:${response.body}');
    print('id:${tre.results[0].id}');
    print('title:${tre.results[0].title}');
    print('voteAverage:${tre.results[0].voteAverage}');
    print('releaseDate:${tre.results[0].releaseDate}');
    print('popularity:${tre.results[0].popularity}');
    print('overview:${tre.results[0].overview}');
    print('posterPath:${tre.results[0].posterPath}');
    print('votecount:${tre.results[0].voteCount}');

    return modelFromJson(response.body);
  } else {
    throw Exception('failed to load trending');
  }
}

Future<Model> getPopularMovies() async {
  endPoint = 'movie/popular';
  final url = '$baseUrl$endPoint$key';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var body = response.body;
    var tre1 = modelFromJson(body);
    print('popular:${response.body}');
    print('page:${tre1.page}');
    print('popularmovies:${response.body}');
    print('id:${tre1.results[0].id}');
    print('title:${tre1.results[0].title}');
    print('voteAverage:${tre1.results[0].voteAverage}');
    print('releaseDate:${tre1.results[0].releaseDate}');
    print('popularity:${tre1.results[0].popularity}');
    print('overview:${tre1.results[0].overview}');
    print('posterPath:${tre1.results[0].posterPath}');
    print('votecount:${tre1.results[0].voteCount}');
    print('popular:${response.body}');

    return modelFromJson(response.body);
  } else {
    throw Exception('failed to load popular');
  }
}


Future<Model> getTopRatedMovies() async {
  endPoint = 'movie/top_rated';
  final String url = '$baseUrl$endPoint$key';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var body = response.body;
    var tre3 = modelFromJson(body);
    print('toptratedmovies:${response.body}');
    print('page:${tre3.page}');
    print('trendingmovies:${response.body}');
    print('id:${tre3.results[0].id}');
    print('title:${tre3.results[0].title}');
    print('voteAverage:${tre3.results[0].voteAverage}');
    print('releaseDate:${tre3.results[0].releaseDate}');
    print('popularity:${tre3.results[0].popularity}');
    print('overview:${tre3.results[0].overview}');
    print('posterPath:${tre3.results[0].posterPath}');
    print('votecount:${tre3.results[0].voteCount}');
    print('toprated:${response.body}');
    return modelFromJson(response.body);
  } else {
    throw Exception('failed to load top rated movies');
  }
}

Future<Model> discoverMovies({int? genreId}) async {
  endPoint = 'discover/movie';
  final String url = genreId == null
      ? '$baseUrl$endPoint$key'
      : '$baseUrl$endPoint$key&with_genres=$genreId';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('discover:${response.body}');

    return modelFromJson(response.body);
  } else {
    throw Exception('failed to load genres');
  }
}

Future<Credit> getCredits(int id, bool isTvShow) async {
  endPoint = isTvShow ? 'tv/$id/credits' : 'movie/$id/credits';
  final String url = '$baseUrl$endPoint$key';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('tv:${response.body}');

    return creditFromJson(response.body);
  } else {
    throw Exception('failed to load credits');
  }
}

Future<Model> getSimilar(int id, bool isTvShow) async {
  endPoint = isTvShow ? 'tv/$id/similar' : 'movie/$id/similar';
  final String url = '$baseUrl$endPoint$key';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print('moviek:${response.body}');

    return modelFromJson(response.body);
  } else {
    throw Exception('failed to load similar');
  }
}

// Future<Review> getReviews(int id, bool isTvShow) async {
//   endPoint = isTvShow ? 'tv/$id/reviews' : 'movie/$id/reviews';
//   final String url = '$baseUrl$endPoint$key';
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     return reviewFromJson(response.body);
//   } else {
//     throw Exception('failed to load reviews');
//   }
// }

Future<Model> movieSearch(String query) async {
  endPoint = 'search/movie';
  final url = '$baseUrl$endPoint$key&query=$query';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return modelFromJson(response.body);
  } else {
    throw Exception('not found');
  }
}

Future<Model> searchData(String query) async {
  endPoint = 'search/multi';
  final url = '$baseUrl$endPoint$key&query=$query';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return modelFromJson(response.body);
  } else {
    throw Exception('not found');
  }
}
