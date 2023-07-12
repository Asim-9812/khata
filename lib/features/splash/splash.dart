
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khata_app/features/login/presentation/status_page.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const StatusPage(),)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if(orientation == Orientation.portrait){
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff076787).withOpacity(0.35),
                      const Color(0xffE3EEF8).withOpacity(0.7),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                  )
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 240,
                  ),
                  Image.asset('assets/images/khata-logo.png', height: 180, width: 200,),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                      'Accounting with Inventory\n Management System',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.merriweather(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  const SizedBox(height: 120,),
                  const SpinKitFoldingCube(
                    color: Color(0xffFD872A),
                    size: 50.0,
                  ),
                ],
              ),
            );
          }else{
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff076787).withOpacity(0.35),
                      const Color(0xffE3EEF8).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.16,
                  ),
                  Image.asset('assets/images/khata-logo.png', height: size.height * 0.4, width: size.height * 0.4,),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Text(
                      'Accounting with Inventory\n Management System',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.merriweather(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  SizedBox(height: size.height * 0.1,),
                  SpinKitFoldingCube(
                    color: Color(0xffFD872A),
                    size: size.height * 0.08,
                  ),
                ],
              ),
            );
          }
        }
      ),
    );
  }
}
