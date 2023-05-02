import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/models/credit_model.dart';
import 'package:movie_app/models/liked_model.dart';
import 'package:movie_app/utils.dart';
import 'package:movie_app/widgets/similar.dart';
import '../models/movie_model.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.data,
      required this.index,
      this.creditData,
      required this.isTvShow})
      : super(key: key);
  final int index;
  final Model data;
  final Credit? creditData;
  final bool isTvShow;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isReadmore = false;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<LikedModel>('liked');
    return Scaffold(
        body: CustomScrollView(
      // sliver app bar
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          expandedHeight: MediaQuery.of(context).size.height / 2.1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    box.put(
                        widget.data.results[widget.index].id,
                        LikedModel(
                            title: widget.data.results[widget.index].title ??
                                widget.data.results[widget.index].name!,
                            genres: widget.data.results[widget.index].genreIds!,
                            voteAverage:
                                widget.data.results[widget.index].voteAverage!,
                            posterPath:
                                widget.data.results[widget.index].posterPath!,
                            isLiked: !(box
                                    .get(
                                      widget.data.results[widget.index].id,
                                    )
                                    ?.isLiked ??
                                false)));
                    setState(() {
                      // print('sakthi:${widget.index.runtimeType}');
                    });
                  },
                  icon: box
                              .get(
                                widget.data.results[widget.index].id,
                              )
                              ?.isLiked ??
                          false
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border)),
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              '$imageUrl${widget.data.results[widget.index].posterPath}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: const Center(child: Text('No Image')),
                );
              },
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((ctx, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.results[widget.index].title ??
                      widget.data.results[widget.index].name!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.date_range),
                      Text(widget.data.results[widget.index].releaseDate == null
                          ? widget.data.results[widget.index].firstAirDate
                              .toString()
                              .substring(0, 4)
                          : widget.data.results[widget.index].releaseDate
                              .toString()
                              .substring(0, 4)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.star),
                      Text(widget.data.results[widget.index].voteAverage
                          .toString()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Story Line',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                buildText(
                  widget.data.results[widget.index].overview!,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isReadmore = !isReadmore;
                      });
                    },
                    child: Text((isReadmore ? 'less...' : 'more...'))),

                // Text(
                //   widget.data.results[widget.index].overview!,
                //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //       color: Colors.white.withOpacity(.9), fontSize: 15),
                // ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          );
        }, childCount: 1))
      ],
    ));
  }

  Widget buildText(String text) {
    final lines = isReadmore ? null : 2;
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Colors.white.withOpacity(.9), fontSize: 15),
      maxLines: lines,
    );
  }
}
