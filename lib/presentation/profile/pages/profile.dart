import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/common/helpers/is_dark_mode.dart';
import 'package:sporifyyy/common/widgets/appbar/app_bar.dart';
import 'package:sporifyyy/common/widgets/favorite_button/favorite_button.dart';
import 'package:sporifyyy/core/configs/constants/app_urls.dart';
import 'package:sporifyyy/presentation/profile/bloc/favorite_song_cubit.dart';
import 'package:sporifyyy/presentation/profile/bloc/favorite_song_state.dart';
import 'package:sporifyyy/presentation/profile/bloc/profile_infor_cubit.dart';
import 'package:sporifyyy/presentation/profile/bloc/profile_infor_state.dart';
import 'package:sporifyyy/presentation/settings/pages/settings.dart';
import 'package:sporifyyy/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        action: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            icon: const Icon(Icons.settings)),
        backgroundColor:
            context.isDarkMode ? Color(0xff2C2B2B) : Color(0xffFFFFFF),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          SizedBox(
            height: 30,
          ),
          _favoriteSong(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileInforCubit()..getuser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff2C2B2B) : Color(0xffFFFFFF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInforCubit, ProfileInforState>(
          builder: (context, state) {
            if (state is ProfileInforLoading) {
              return Align(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is ProfileInforLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageUrl!),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(state.userEntity.email!),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    state.userEntity.fullName!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              );
            }
            if (state is ProfileInforFailure) {
              return Text('Please try again');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSong() {
    return BlocProvider(
      create: (context) => FavoriteSongCubit()..getFavoriteSong(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("FAVORITE SONG"),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongCubit, FavoriteSongState>(
                builder: (context, state) {
              if (state is FavoreiteSongLoading) {
                return const CircularProgressIndicator();
              }

              if (state is FavoreiteSongLoaded) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongPlayerPage(
                                  songEntity: state.favoriteSong[index]),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${AppUrls.coverFirestorage}${state.favoriteSong[index].artist} - ${state.favoriteSong[index].title}.jpg?${AppUrls.mediaAlt}'))),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSong[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      state.favoriteSong[index].artist,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSong[index].duration
                                      .toString()
                                      .replaceAll('.', ':'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                FavoriteButton(
                                  songEntity: state.favoriteSong[index],
                                  key: UniqueKey(),
                                  function: () {
                                    context
                                        .read<FavoriteSongCubit>()
                                        .removeSong(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ),
                    itemCount: state.favoriteSong.length);
              }

              if (state is FavoreiteSongFalure) {
                return Text('Try again...');
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
