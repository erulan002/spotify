import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/domain/entities/song.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

import '../../../core/configs/const/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;

  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Center(
          child: Text(
            'Now Playing',
            style: TextStyle(fontSize: 18),
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSong(
              '${AppURLs.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppURLs.mediaAlt}'),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 30),
              _songDetails(context),
              const SizedBox(height: 30),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) => Container(
        height: MediaQuery.sizeOf(context).height / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                '${AppURLs.coverFirestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppURLs.mediaAlt}'),
          ),
        ),
      );

  Widget _songDetails(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                songEntity.artist,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              )
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline_outlined,
              size: 30,
              color: AppColors.darkGrey,
            ),
          ),
        ],
      );

  Widget _songPlayer(BuildContext context) =>
      BlocBuilder<SongPlayerCubit, SongPlayerState>(builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition,
                    ),
                  ),
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => context.read<SongPlayerCubit>().playOrStopSong(),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      });

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
