import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/common/helpers/is_dark_mode.dart';
import 'package:sporifyyy/core/configs/constants/app_urls.dart';
import 'package:sporifyyy/domain/entities/song/song.dart';
import 'package:sporifyyy/presentation/home/bloc/news_songs_cubit.dart';
import 'package:sporifyyy/presentation/home/bloc/news_songs_state.dart';
import 'package:sporifyyy/presentation/song_player/pages/song_player.dart';

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
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SongPlayerPage(
                            songEntity: songs[index],
                          )));
            },
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Đặt chiều cao cố định cho ảnh
                  Container(
                    height: 120, // Điều chỉnh chiều cao của ảnh
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '${AppUrls.coverFirestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppUrls.mediaAlt}'),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 30,
                        height: 30,
                        transform: Matrix4.translationValues(10, 10, 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode
                              ? Color(0xff2C2C2C)
                              : Color(0xffE6E6E6),
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Color(0xff959595),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Đảm bảo title có thể xuống dòng
                  Text(
                    songs[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1, // Giới hạn số dòng
                    overflow:
                        TextOverflow.ellipsis, // Cắt bớt nếu văn bản quá dài
                  ),
                  Text(
                    songs[index].artist,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    maxLines: 1, // Giới hạn số dòng
                    overflow:
                        TextOverflow.ellipsis, // Cắt bớt nếu văn bản quá dài
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemCount: songs.length,
      ),
    );
  }
}
