import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_prokit/screens/RcDashBoardScraan.dart';
import 'package:recipe_prokit/utils/RCColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RCSignInComponent extends StatefulWidget {
  @override
  State<RCSignInComponent> createState() => _RCSignInComponentState();
}

class _RCSignInComponentState extends State<RCSignInComponent> {
  FocusNode password = FocusNode();

  var form_key = GlobalKey<FormState>();
  final _supabaseClient = Supabase.instance.client;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      final email = nameController.text;
      final password = passwordController.text;
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    _supabaseClient.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        final User? user = _supabaseClient.auth.currentUser;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                RcDashBoardScraan(name: user?.userMetadata?["username"]),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: form_key,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          Text('Welcome to,',
              style: boldTextStyle(
                  size: 30,
                  fontFamily: GoogleFonts.playfairDisplay().fontFamily)),
          12.height,
          Text('Kifota',
              style: boldTextStyle(
                  size: 30,
                  fontFamily: GoogleFonts.playfairDisplay().fontFamily,
                  color: primaryColor)),
          24.height,
          AppTextField(
            controller: nameController,
            nextFocus: password,
            textFieldType: TextFieldType.NAME,
            textStyle: boldTextStyle(),
            decoration: InputDecoration(
              prefixIcon:
                  Icon(Icons.person_outlined, color: rcSecondaryTextColor),
              hintText: 'Enter username',
              hintStyle: secondaryTextStyle(),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: rcSecondaryTextColor)),
            ),
          ),
          16.height,
          AppTextField(
            focus: password,
            controller: passwordController,
            textFieldType: TextFieldType.PASSWORD,
            suffixIconColor: rcSecondaryTextColor,
            textStyle: boldTextStyle(),
            decoration: InputDecoration(
              prefixIcon:
                  Icon(Icons.lock_outlined, color: rcSecondaryTextColor),
              hintText: 'Enter password',
              hintStyle: secondaryTextStyle(),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: rcSecondaryTextColor)),
            ),
          ),
          150.height,
          Container(
                  child: Text('Sign In',
                          style: boldTextStyle(size: 18, color: Colors.white))
                      .center(),
                  width: context.width() - 40,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: radius(32), color: primaryColor))
              .onTap(() {
            if (form_key.currentState!.validate()) {
              _signIn();
              //RcDashBoardScraan(name: nameController.text).launch(context);
            }
          },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
        ]));
  }
}
