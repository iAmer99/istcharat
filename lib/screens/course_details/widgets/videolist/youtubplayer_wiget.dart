import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:istchrat/shared_components/helper_functions.dart';
import 'package:istchrat/shared_components/widgets/custom_app_bar.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String url;
  final String? title;

  const YoutubePlayerWidget({Key? key, required this.url, this.title})
      : super(key: key);

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  bool navigate = true;
  late TextEditingController _seekToController;

  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  bool _showAppBar = true;

  //

  late yt.YoutubePlayerController _ytController;
  late int _rotation;

  @override
  void initState() {
    super.initState();
    _rotation = 0 ;
    _ytController = yt.YoutubePlayerController(
      initialVideoId: getVideoID(widget.url),
      flags: const yt.YoutubePlayerFlags(
        mute: false,
        enableCaption: false,
       showLiveFullscreenButton: false,
       // isLive: true,
      ),
    );
    //_ytController.toggleFullScreenMode();
    _seekToController = TextEditingController();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _seekToController.dispose();
    _ytController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
       /* if(_ytController.value.isFullScreen){
          _ytController.toggleFullScreenMode();
          return false;
        }else{
          return true;
        } */
        return true;
      },
      child: Scaffold(
        appBar:
        _rotation == 0 ? CustomAppBar.appBar(context, text: widget.title ?? "watch_course".tr) : null,
        body:   RotatedBox(
          quarterTurns: _rotation,
          child: SizedBox(
            width: double.infinity,
            height: _rotation == 0 ? null : double.infinity,
            child: yt.YoutubePlayer(
              controller: _ytController,
              showVideoProgressIndicator: true,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),
                RemainingDuration(),
                IconButton(
                  icon: Icon(
                    _rotation == 0 ? Icons.fullscreen : Icons.fullscreen_exit,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    if (_rotation == 0) {
                      setState(() {
                        _showAppBar = false;
                        _rotation = 1;
                      });
                    } else {
                      setState(() {
                        _showAppBar = true;
                        _rotation = 0;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebView() {
    return WebViewPlus(
      initialUrl:
          "https://us02web.zoom.us/rec/share/3xcCM0Wd5mRviiq1tKvUkZXYUxy2EPAetXhDTvBNrWJ6UbbhMdboB7CtKmww56Y4.CuMeCVUzI6CeDc6l",
      navigationDelegate: (NavigationRequest request) {
        print(request.url);
        if (navigate) {
          return NavigationDecision.navigate;
        } else {
          return NavigationDecision.prevent;
        }
      },
      onPageStarted: (_) {
        setState(() {
          navigate = !navigate;
        });
      },
    );
  }
}
