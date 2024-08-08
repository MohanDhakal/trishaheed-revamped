import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../utilities/images.dart';

class HeadMasterSaying extends StatefulWidget {
  const HeadMasterSaying({Key? key}) : super(key: key);

  @override
  State<HeadMasterSaying> createState() => _HeadMasterSayingState();
}

class _HeadMasterSayingState extends State<HeadMasterSaying> {
  double endX = 0;
  double endY = 50;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return VisibilityDetector(
      key: Key('head master'),
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage > 1) {
          if (endY != 0) setState(() => endY = 0);
        }
      },
      child: TweenAnimationBuilder(
          tween: Tween<Offset>(begin: Offset(0, 50), end: Offset(endX, endY)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          builder: (context, Offset value, child) {
            return Transform.translate(
              offset: value,
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 24),
                      Text(
                        'प्रधानाध्यापक को कलमबाट',
                        textAlign: TextAlign.center,
                        style: ResponsiveWrapper.of(context).isMobile
                            ? Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold)
                            : Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),

                      SizedBox(
                        width: size.width * 0.2,
                        child: Divider(thickness: 4),
                      ),
                      SizedBox(height: 16),

                    ],
                  ),
                  ResponsiveRowColumn(
                    layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                    rowCrossAxisAlignment: CrossAxisAlignment.start,
                    rowMainAxisAlignment: MainAxisAlignment.center,
                    columnMainAxisAlignment: MainAxisAlignment.start,
                    columnCrossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ResponsiveRowColumnItem(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            contact1,
                            width: ResponsiveWrapper.of(context)
                                    .isSmallerThan(DESKTOP)
                                ? size.width * 0.6
                                : size.width * 0.3,
                            height: ResponsiveWrapper.of(context)
                                    .isSmallerThan(DESKTOP)
                                ? size.width * 0.8
                                : size.width * 0.3,
                            // color: Colors.red,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ResponsiveRowColumnItem(
                        child: SizedBox(width: 36),
                      ),
                      ResponsiveRowColumnItem(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 24),
                            SizedBox(
                              width: ResponsiveWrapper.of(context)
                                      .isLargerThan(TABLET)
                                  ? size.width * 0.45
                                  : size.width * 0.90,
                              child: SelectableText.rich(
                                TextSpan(
                                  text:
                                      "\“गुणस्तरीय र प्राविधिक शिक्षा, आजको आवश्यकता \”",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    // fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          " भन्ने तथ्यलाई हृदयंगम गर्दै सूचना तथा प्रविधिको प्रयोग वालमैत्री वातावरणमा विद्यार्थी केन्द्रित विधि मार्फत आधुनिक युगअनुसारको अंग्रेजी र नेपाली माध्यममा कक्षा नर्सरी देखि १२ सम्म साधारण र प्राविधिक धार अन्तरगतको गुणस्तरीय शिक्षा प्रदान गर्दै आइरहेको नमुना विद्यालयको रुपमा विकसित यस श्री त्रि-शहीद मा.वि.पञ्चमूलमा अध्ययन गरेका र अध्ययनरत सम्पूणर् विद्यार्थीहरु, सेवा निवृत्त एवं सेवारत शिक्षकहरु, अमूल्य योगदान दिनु हुने अभिभावकज्यूहरु प्रति हार्दिक शुभे्च्छा व्यक्त गर्दछु र समायानुकुल परिवर्तन हुदै आधुनिक युगअनुसारको प्रविधियुक्त शिक्षा प्रदान गरिरहेको यस विद्यालयको उत्तरोत्तर प्रगतिको कामना गर्दछु ।",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        // fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                                style: ResponsiveWrapper.of(context)
                                        .isLargerThan(TABLET)
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 20)
                                    : Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
