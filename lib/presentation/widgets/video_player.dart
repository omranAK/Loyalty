import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/web_services/server_config.dart';
import 'package:loyalty_system_mobile/logic/ad/bloc/ad_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  Future<void>? _video;
  Timer? _timer;
  late int _start;
  late Bloc adBloc;
  late int adID;
  @override
  void initState() {
    adBloc = BlocProvider.of<AdBloc>(context);
    adBloc.add(LoadAdEvenet());
    //startTimer();
    super.initState();
  }

  void initlizeVideo(String url) {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('${ServerConfig.mainApiUrlImage}$url'),
    );
    _video = _controller!.initialize();
    _controller!.play();
  }

  void startTimer() {
    _start = 10;
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
              _start--;
            }
          });
        }
      },
    );
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
    final height = MediaQuery.sizeOf(context).height;
    //final width = MediaQuery.sizeOf(context).width;
    return BlocListener<AdBloc, AdState>(
      listener: (context, state) {
        if (state is AdLoaddedState) {
          startTimer();
          initlizeVideo(state.ad.url);
          adID = state.ad.id;
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.appBarColor,
        body: BlocBuilder<AdBloc, AdState>(
          builder: (context, state) {
            if (state is AdLoaddedState) {
              return FutureBuilder(
                future: _video,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.buttonColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$_start',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
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
                        // Container(
                        //   padding: const EdgeInsets.all(12),
                        //   height: height * 0.2,
                        //   decoration: BoxDecoration(
                        //       color: AppColors.buttonColor,
                        //       borderRadius: BorderRadius.circular(12)),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const Text(
                        //         'To advertise on the Walaa application, please contact the following number',
                        //         style: TextStyle(
                        //           fontSize: 20,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           GestureDetector(
                        //             onTap: () async {
                        //               var whatsapp = "+963933000741";
                        //               var whatsappURl =
                        //                   "whatsapp://send?phone=$whatsapp";
                        //               if (await canLaunchUrl(
                        //                   Uri.parse(whatsappURl))) {
                        //                 await launchUrl(
                        //                   Uri.parse(whatsappURl),
                        //                 );
                        //               } else {
                        //                 ScaffoldMessenger.of(context)
                        //                     .showSnackBar(
                        //                   const SnackBar(
                        //                     content:
                        //                         Text('whatsapp not installed'),
                        //                   ),
                        //                 );
                        //               }
                        //             },
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(15),
                        //                 color: Colors.green,
                        //               ),
                        //               width: MediaQuery.sizeOf(context).width *
                        //                   0.5,
                        //               child: const ListTile(
                        //                 leading: Icon(
                        //                   FontAwesomeIcons.whatsapp,
                        //                   color: Colors.white,
                        //                   size: 20,
                        //                 ),
                        //                 title: Text(
                        //                   '+963933000741',
                        //                   style: TextStyle(color: Colors.white),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // )
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
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
                    child: const Text(
                      'Back to home',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
