import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../data/models/youtube_id_model.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final List<YoutubeIdModel> vedioPath;
  final Size media; 
  const YouTubePlayerWidget({super.key, required this.vedioPath, required this.media});

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.vedioPath[0].key!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  VideoPlayerController? videoPlayerController;

  @override
  void dispose() {
    youtubePlayerController.dispose();
    youtubePlayerController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                ColorConstance.cbackGroundColor,
                ColorConstance.cbackGroundColor,
                Colors.transparent,
              ],
              stops: [0, 0.3, .01, 5],
            ).createShader(
              Rect.fromLTRB(
                  widget.media.height * .03, 0, bounds.width * .09, bounds.height),
            ),
        child: YoutubePlayer(
          controller: youtubePlayerController,
          showVideoProgressIndicator: true,
          bottomActions: const [],
          progressIndicatorColor: ColorConstance.cDefaultColor,
          aspectRatio: 16 / 11,
          onEnded: (metaData) {
            youtubePlayerController.play();
            youtubePlayerController.pause();
          },
          progressColors: const ProgressBarColors(
            backgroundColor: Colors.white24,
            playedColor: ColorConstance.cDefaultColor,
          ),
        ));
  }
}
