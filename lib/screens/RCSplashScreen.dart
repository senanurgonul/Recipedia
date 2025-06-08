import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:recipe_prokit/screens/RCWelcomeScreen.dart';
import 'package:recipe_prokit/screens/RcDashBoardScraan.dart';
import 'package:recipe_prokit/utils/RCColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RCSplashScreen extends StatefulWidget {
  const RCSplashScreen({Key? key}) : super(key: key);

  @override
  _RCSplashScreenState createState() => _RCSplashScreenState();
}

class _RCSplashScreenState extends State<RCSplashScreen> {
  final _supabaseClient = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.transparent);
    await 3.seconds.delay;
    finish(context);
    //RCWelcomeScreen().launch(context);
    final User? user = _supabaseClient.auth.currentUser;
    print(user);
    if (user != null) {
     
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              RcDashBoardScraan(name: user.userMetadata?["username"] ?? ""),
        ),
      );
    } else {
      RCWelcomeScreen().launch(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -110,
            right: -60,
            child: Icon(Icons.cloud,
                color: Colors.white.withOpacity(0.2), size: 350),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: 300,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: radius(16),
                  color: Colors.white.withOpacity(0.2)),
              transform: Matrix4.rotationZ(6),
            ),
          ),
          Positioned(
            top: 200,
            left: -100,
            child: Image.asset('images/recipe/fork.png',
                height: 350, color: Colors.white.withOpacity(0.2)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: Text('K',
                    style: boldTextStyle(
                        size: 68,
                        color: Colors.white,
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily)),
              ),
              Text('ifot',
                  style: boldTextStyle(
                      size: 50,
                      color: Colors.white,
                      fontFamily: GoogleFonts.playfairDisplay().fontFamily)),
              RotatedBox(
                quarterTurns: 2,
                child: Text('A',
                    style: boldTextStyle(
                        size: 68,
                        color: Colors.white,
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily)),
              ),
            ],
          ).center(),
        ],
      ),
      backgroundColor: primaryColor,
    );
  }
}
