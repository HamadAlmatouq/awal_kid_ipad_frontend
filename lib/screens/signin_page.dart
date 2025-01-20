// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerScreen extends StatefulWidget {
//   const QRScannerScreen({super.key});

//   @override
//   _QRScannerScreenState createState() => _QRScannerScreenState();
// }

// class _QRScannerScreenState extends State<QRScannerScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QR Scanner'),
//         backgroundColor: Colors.blue, // Adjust to match the home page theme
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (result != null)
//                   ? Text(
//                       'Barcode Type: ${result!.format}   Data: ${result!.code}',
//                       style: const TextStyle(
//                         fontFamily: 'Jua',
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     )
//                   : const Text(
//                       'Scan a code',
//                       style: TextStyle(
//                         fontFamily: 'Jua',
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//             ),
//           )
//         ],
//       ),
//       backgroundColor: Colors.black, // Adjust to match the home page theme
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'qr_scanner_screen.dart';
import 'home_page.dart'; // Import the new home page

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF38E22),
              Color(0xFFF5A147),
              Color(0xFFF6AE60),
              Color(0xFFF49734),
            ],
            stops: [0.0, 0.33, 0.64, 0.97],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome Banner
                Image.network(
                  'https://dashboard.codeparrot.ai/api/assets/Z4yVpr9JV5SvYOiQ',
                  width: 700, // Adjusted for landscape
                  height: 180, // Adjusted for landscape
                ),
                const SizedBox(height: 40),
                // Awal Text
                const Text(
                  'awal.',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 140, // Adjusted for landscape
                    color: Colors.white,
                    letterSpacing: -0.23,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Subtitle
                const Text(
                  'Your child\'s future starts here',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 24, // Adjusted for landscape
                    color: Colors.white,
                    letterSpacing: -0.23,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // QR Code Text
                const Text(
                  'To Sign in, scan the QR code!',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 20, // Adjusted for landscape
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Scan QR Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QRScannerScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 220, // Adjusted for landscape
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Scan QR code',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20, // Adjusted for landscape
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF38E22),
                          letterSpacing: -0.23,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // OR Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100, // Adjusted for landscape
                      height: 1,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20, // Adjusted for landscape
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 100, // Adjusted for landscape
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Sign in Text
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'sign in',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20, // Adjusted for landscape
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
