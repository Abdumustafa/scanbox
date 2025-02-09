import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3b0356),
        title: Text.rich(
          TextSpan(
            text: 'Scan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: 'B',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, color: Color(0xfff4a8b6))),
              TextSpan(
                text: 'ox',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // زر Scan QR Code
                  GestureDetector(
                    onTap: () {
                      // الانتقال إلى صفحة المسح
                      context.push('/scanner');
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 80,
                            color: Colors.purple.shade900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Scan QR Code',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  // زر Generate QR Code
                  GestureDetector(
                    onTap: () {
                      // الانتقال إلى صفحة التوليد
                      context.push('/generate');
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.qr_code_2,
                            size: 80,
                            color: Colors.purple.shade900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Generate QR Code',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ElevatedButton.icon(
//                 onPressed: () {
//                   context.push('/scanner');
//                 },
//                 icon: Icon(Icons.qr_code_scanner),
//                 label: Text('Start Scanning'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   textStyle: TextStyle(fontSize: 18),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   context.push('/generate');
//                 },
//                 icon: Icon(Icons.create),
//                 label: Text('Generate QR Code'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   textStyle: TextStyle(fontSize: 18),
//                 ),
//               ),
