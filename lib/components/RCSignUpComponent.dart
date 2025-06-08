import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:recipe_prokit/screens/RCOTPScreen.dart';
import 'package:recipe_prokit/screens/RcDashBoardScraan.dart';
import 'package:recipe_prokit/utils/RCColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RCSignUpComponent extends StatefulWidget {
  @override
  State<RCSignUpComponent> createState() => _RCSignUpComponentState();
}

class _RCSignUpComponentState extends State<RCSignUpComponent> {
  var form_key = GlobalKey<FormState>();
  final _supabaseClient = Supabase.instance.client;

  FocusNode name = FocusNode();

  FocusNode password = FocusNode();

  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _signUp() async {
    try {
      final email = emailController.text;
      final password = passwordController.text;
      AuthResponse auth = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
          data: {'username': nameController.text});

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Register is Successful!"),
        backgroundColor: Colors.green,
      ));
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
        backgroundColor: Colors.red,
      ));
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
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
          Text('Sign Up',
              style: boldTextStyle(
                  size: 30,
                  fontFamily: GoogleFonts.playfairDisplay().fontFamily)),
          12.height,
          Text('To discover all our tastebud tickling recipes and features',
              style: secondaryTextStyle(color: rcSecondaryTextColor)),
          16.height,
          AppTextField(
            controller: emailController,
            nextFocus: name,
            textFieldType: TextFieldType.EMAIL,
            textStyle: boldTextStyle(),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.mail_outlined,
                color: rcSecondaryTextColor,
              ),
              hintText: 'Enter email',
              hintStyle: secondaryTextStyle(),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: rcSecondaryTextColor)),
            ),
          ),
          16.height,
          AppTextField(
            nextFocus: password,
            focus: name,
            controller: nameController,
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
            textFieldType: TextFieldType.PASSWORD,
            suffixIconColor: rcSecondaryTextColor,
            textStyle: boldTextStyle(),
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon:
                  Icon(Icons.lock_outlined, color: rcSecondaryTextColor),
              hintText: 'Enter password',
              hintStyle: secondaryTextStyle(),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: rcSecondaryTextColor)),
            ),
          ),
          32.height,
          RichText(
              text: TextSpan(
                  text: 'By signing up I accept the ',
                  style: secondaryTextStyle(color: rcSecondaryTextColor),
                  children: <TextSpan>[
                TextSpan(
                    text: 'terms of use ',
                    style: secondaryTextStyle(
                        color: primaryColor,
                        weight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
                TextSpan(
                  text: 'and ',
                  style: secondaryTextStyle(color: rcSecondaryTextColor),
                ),
                TextSpan(
                    text: 'data,private,policy.',
                    style: secondaryTextStyle(
                        color: primaryColor,
                        weight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ])),
          50.height,
          Container(
                  child: Text('Sign Up',
                          style: boldTextStyle(size: 18, color: Colors.white))
                      .center(),
                  width: context.width() - 40,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: radius(32), color: primaryColor))
              .onTap(() {
            if (form_key.currentState!.validate()) {
              // RCOTPScreen(
              //   email: emailController.text,
              //   name: nameController.text,
              // ).launch(context);
              _signUp();
            }
          },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
        ]));
  }
}
