import '../../constant/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  late int _start;
  @override
  void initState() {
    startTimer();
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      CacheManager.getUserModel()!.active == 1 &&
                  CacheManager.getUserModel()!.roleID == 4 ||
              CacheManager.getUserModel()!.roleID == 5
          ? Navigator.of(context)
              .pushNamedAndRemoveUntil(tabScreen, (route) => false)
          : Navigator.of(context).pushReplacementNamed(authscreen);
    });
  }

  void startTimer() {
    _start = 2;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  bool animate = false;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [AppColors.appBarColor, AppColors.appBarColor],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _start == 0
                ? AnimatedCrossFade(
                    firstChild: const Center(),
                    secondChild: Image.asset(
                      color: Colors.grey[400],
                      "assets/images/logo.png",
                      scale: 0.5,
                    ),
                    crossFadeState: CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 800))
                : const Center(),
            //  _start==0? FadeInImage(placeholder: placeholder, image: AssetImage('assets/images/'),)  Image.asset(
            //       color: Colors.grey[400],
            //       "assets/images/logo.png",
            //       scale: 0.5,
            //     ):const Center(),
            const SizedBox(
              height: 20,
            ),
            Text(
              localizations!.loyalty,
              style: GoogleFonts.montserrat(
                  fontSize: 32,
                  color: Colors.grey[400],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
