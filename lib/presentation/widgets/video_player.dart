import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/imports.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  Future<void>? _video;
  Timer? _timer;
  int counter = 0;
  int? _start;
  late Bloc adBloc;
  late int adID;
  @override
  void initState() {
    adBloc = BlocProvider.of<AdBloc>(context);
    adBloc.add(LoadAdEvenet());

    //startTimer();
    super.initState();
  }

  void initlizeVideo(String url) async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('${ServerConfig.mainApiUrlImage}$url'),
    );

    _video = _controller!.initialize().then((_) {
      setState(() {});
      _controller!.addListener(checkVideo);
    });
    await _controller!.play();
  }

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (_controller!.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      counter++;
      if (counter == 1) {
        if (_controller!.value.duration >= const Duration(seconds: 15)) {
          _start = 15;
          _startTimer();
        } else {
          _start = _controller!.value.duration.inSeconds;
          _startTimer();
        }
      }
    }

    // if (_controller!.value.position == _controller!.value.duration) {}
  }

  _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            adBloc.add(CompletedWatchAdEvent(adId: adID));
            timer.cancel();
          });
        } else {
          setState(() {
            if (_controller!.value.isPlaying) {
              _start = _start! - 1;
            }
          });
        }
      },
    );
  }

  whatsapp() async {
    var contact = "+963933000741";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
      // ignore: empty_catches
    } on Exception {}
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    if (_controller != null) {
      _controller!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    //final height = MediaQuery.sizeOf(context).height;
    //final width = MediaQuery.sizeOf(context).width;
    return BlocListener<AdBloc, AdState>(
      listener: (context, state) {
        if (state is AdLoaddedState) {
          initlizeVideo(state.ad.url);
          adID = state.ad.id;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.appBarColor,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<AdBloc, AdState>(
          builder: (context, state) {
            if (state is AdLoaddedState) {
              return FutureBuilder(
                future: _video,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: _start == 0
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.exit_to_app,
                                      color: Colors.black,
                                      size: 35,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.buttonColor,
                                      ),
                                      child:  Center(
                                        child: Text(
                                          'skip in ${_start ?? ''}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_controller!.value.isPlaying) {
                                  setState(() {
                                    _controller!.pause();
                                  });
                                } else {
                                  setState(() {
                                    _controller!.play();
                                  });
                                }
                              },
                              child: AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(_controller!),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                backgroundColor: AppColors.buttonColor,
                                child: _controller!.value.isPlaying
                                    ? const Icon(
                                        Icons.pause_circle_outline_rounded,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.play_circle_outlined,
                                        color: Colors.white,
                                      ),
                                onPressed: () {
                                  if (_controller!.value.isPlaying) {
                                    setState(() {
                                      _controller!.pause();
                                    });
                                  } else {
                                    setState(() {
                                      _controller!.play();
                                    });
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).badgeTheme.backgroundColor,
                      ),
                    );
                  }
                },
              );
            } else if (state is AdFaildState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      state.errorMessage,
                      style: GoogleFonts.montserrat(
                          fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      localizations!.back,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).badgeTheme.backgroundColor,
                ),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () => whatsapp(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green,
            ),
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: ListTile(
              leading: const Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 26,
              ),
              title: Text(
                localizations!.toadvertise,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
