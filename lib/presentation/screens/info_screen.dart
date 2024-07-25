import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/imports.dart';

class InfoScren extends StatelessWidget {
  const InfoScren({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    whatsapp() async {
      var contact = "+963933000741";
      var androidUrl =
          "whatsapp://send?phone=$contact&text=Hi, I need some help";
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

    //final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations!.about,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset('assets/images/logo.png'),
            Text(
              'sub' * 100,
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          whatsapp();
        },
        child: const Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
