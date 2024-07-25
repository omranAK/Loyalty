import '../../constant/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  bool animate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          AnimatedPositioned(
            top: animate ? MediaQuery.sizeOf(context).height * 0.5 : -30,
            left: animate ? MediaQuery.sizeOf(context).width * 0.5 : -30,
            duration: const Duration(milliseconds: 500),
            child: Text(
              'Loyalty',
              style: GoogleFonts.montserrat(fontSize: 30),
            ),
          )
        ],
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
