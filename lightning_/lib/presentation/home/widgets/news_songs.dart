import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lightning_/common/helpers/is_dark_mode.dart';
import 'package:lightning_/core/configs/constants/app_urls.dart';
import 'package:lightning_/core/configs/theme/app_colors.dart';
import 'package:lightning_/domain/entities/song/song.dart';
import 'package:lightning_/presentation/home/bloc/news_songs_cubit.dart';
import 'package:lightning_/presentation/home/bloc/news_songs_state.dart';
import 'package:lightning_/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
          height: 200,
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
              builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }
            return Container();
          })),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SongPlayerPage(songEntity: songs[index])));
          },
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(AppUrls.firestorage +
                                songs[index].artist +
                                ' - ' +
                                songs[index].title +
                                '.jpg?' +
                                AppUrls.media))),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 40,
                        width: 40,
                        transform: Matrix4.translationValues(10, 10, 0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode
                                ? AppColors.darkGrey
                                : const Color(0xffE6E6E6)),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: context.isDarkMode
                              ? const Color(0xff9595995)
                              : const Color(0xff555555),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  songs[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  songs[index].artist,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        width: 14,
      ),
      itemCount: songs.length,
    );
  }
}
