import '../../constant/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    startAnimation();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      CacheManager.getUserModel() == null
          ? Navigator.of(context).pushReplacementNamed(authscreen)
          : CacheManager.getUserModel()!.active == 1 &&
                      CacheManager.getUserModel()!.roleID == 4 ||
                  CacheManager.getUserModel()!.roleID == 5
              ? Navigator.of(context).pushReplacementNamed(tabScreen)
              : Navigator.of(context).pushReplacementNamed(authscreen);
      Navigator.of(context).pushReplacementNamed(tabScreen);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              scale: 0.5,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Loyalty',
              style: GoogleFonts.montserrat(
                  fontSize: 32,
                  color: Colors.black,
                  fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 5000));
  }
}
