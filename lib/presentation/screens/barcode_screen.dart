import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../constant/imports.dart';

class BarCodeScreen extends StatelessWidget {
  const BarCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250 ,
            child: SfBarcodeGenerator(
              barColor: Colors.red,
              
              value: '*2300250*',
              showValue: true,
            ),
          ),
        ],
      ),
    );
  }
}
