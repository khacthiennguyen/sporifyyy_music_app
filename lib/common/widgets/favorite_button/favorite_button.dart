import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sporifyyy/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:sporifyyy/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:sporifyyy/common/helpers/is_dark_mode.dart';
import 'package:sporifyyy/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  const FavoriteButton({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
          builder: (context, state) {
        if (state is FavoriteButtonInitial) {
          return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdate(songEntity.songId);
              },
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color:
                    context.isDarkMode ? Color(0xff565656) : Color(0xffB4B4B4),
              ));
        }

        if (state is FavoriteButtonUpdate) {
          return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdate(songEntity.songId);
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color:
                    context.isDarkMode ? Color(0xff565656) : Color(0xffB4B4B4),
              ));
        }
        return Container();
      }),
    );
  }
}
