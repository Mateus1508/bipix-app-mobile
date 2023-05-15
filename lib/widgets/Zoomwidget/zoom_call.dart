import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:zoom_video_sdk/zoom_video_sdk.dart';

class Video extends StatelessWidget {
  final ZoomVideoSdkUser? user;
  final bool sharing;
  final bool preview;
  final bool focused;
  final bool hasMultiCamera;
  final String multiCameraIndex;
  final String? videoAspect;
  final bool fullScreen;

  const Video({
    Key? key,
    required this.user,
    required this.sharing,
    required this.preview,
    required this.focused,
    required this.hasMultiCamera,
    required this.multiCameraIndex,
    this.videoAspect,
    required this.fullScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.android
        ? AndroidView(
            viewType: 'the name of view type',
            layoutDirection: TextDirection.ltr,
            creationParams: {
              'user': user?.toJson(),
              'sharing': sharing,
              'preview': preview,
              'focused': focused,
              'hasMultiCamera': hasMultiCamera,
              'multiCameraIndex': multiCameraIndex,
              'videoAspect': videoAspect,
              'fullScreen': fullScreen,
            },
            creationParamsCodec: const StandardMessageCodec(),
          )
        : UiKitView(
            viewType: 'the name of view type',
            layoutDirection: TextDirection.ltr,
            creationParams: {
              'user': user?.toJson(),
              'sharing': sharing,
              'preview': preview,
              'focused': focused,
              'hasMultiCamera': hasMultiCamera,
              'multiCameraIndex': multiCameraIndex,
              'videoAspect': videoAspect,
              'fullScreen': fullScreen,
            },
            creationParamsCodec: const StandardMessageCodec(),
          );
  }
}
