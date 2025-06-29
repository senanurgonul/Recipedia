import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:recipe_prokit/components/RCStoryComponent.dart';
import 'package:recipe_prokit/models/RCHomeStoryModel.dart';
import 'package:recipe_prokit/utils/RCClipperPaths.dart';
import 'package:recipe_prokit/utils/RCColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RCHomeComponent extends StatefulWidget {
  String name;

  RCHomeComponent({required this.name});

  @override
  State<RCHomeComponent> createState() => _RCHomeComponentState();
}

class _RCHomeComponentState extends State<RCHomeComponent> {
  bool no = false;

  List<RCHomeStoryModel> list = getHomeStoryList();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (context.statusBarHeight + 16).toInt().height,
            Text('Good Morning,',
                    style: boldTextStyle(
                        size: 30,
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily))
                .paddingSymmetric(horizontal: 16),
            Text('${widget.name} !',
                    style: boldTextStyle(
                        size: 30,
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily))
                .paddingSymmetric(horizontal: 16),
            16.height,
            Text('Would you consider a solely plant-based out of climate change reasons?',
                    style: secondaryTextStyle(color: rcSecondaryTextColor))
                .paddingSymmetric(horizontal: 16),
            16.height,
            Wrap(
              runSpacing: 8,
              spacing: 16,
              children: [
                Container(
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: BackgroundClipper(),
                        child: Container(
                            height: 180,
                            width: 150,
                            color: !no ? primaryColor : rcSecondaryColor,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Yes',
                                style: boldTextStyle(
                                    color: !no
                                        ? Colors.white
                                        : rcSecondaryTextColor),
                              ).paddingOnly(bottom: 8),
                            )),
                      ),
                      Positioned(
                        top: 8,
                        child: Image.asset(
                          'images/recipe/leonardo.png',
                          height: 130,
                        ),
                      )
                    ],
                  ),
                ).onTap(() {
                  no = !no;
                  setState(() {});
                },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                Container(
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: BackgroundClipper(),
                        child: Container(
                            height: 180,
                            width: 150,
                            color: no ? primaryColor : rcSecondaryColor,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'No',
                                style: boldTextStyle(
                                    color: no
                                        ? Colors.white
                                        : rcSecondaryTextColor),
                              ).paddingOnly(bottom: 8),
                            )),
                      ),
                      Positioned(
                        top: 8,
                        child: Image.asset(
                          'images/recipe/leonardo.png',
                          height: 130,
                        ),
                      )
                    ],
                  ),
                ).onTap(() {
                  no = !no;
                  setState(() {});
                },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
              ],
            ).paddingSymmetric(horizontal: 16).center(),
            20.height,
            Text('Today\'s Story',
                    style: boldTextStyle(
                        size: 24,
                        fontFamily: GoogleFonts.playfairDisplay().fontFamily))
                .paddingSymmetric(horizontal: 16),
            20.height,
            Wrap(
              runSpacing: 26,
              children: list.map((element) {
                return RCStoryComponent(element: element, isProfile: false);
              }).toList(),
            ),
            70.height,
          ],
        ),
      ),
    );
  }
}
