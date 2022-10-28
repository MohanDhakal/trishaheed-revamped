import 'package:flutter/material.dart';

import '../utilities/images.dart';

class HeadMasterSaying extends StatelessWidget {
  const HeadMasterSaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              potraitSample,
              width: size.width * 0.2,
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'प्रधानाध्यापक को सन्देश',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Text(
                  "“गुणस्तरीय र प्राविधिक शिक्षा, आजको आवश्यकता ” भन्ने तथ्यलाई हृदयंगम गर्दै सूचना तथा प्रविधिको प्रयोग वालमैत्री वातावरणमा विद्यार्थी केन्द्रित विधि मार्फत आधुनिक युगअनुसारको अंग्रेजी र नेपाली माध्यममा कक्षा नर्सरी देखि १२ सम्म साधारण र प्राविधिक धार अन्तरगतको गुणस्तरीय शिक्षा प्रदान गर्दै आइरहेको नमुना विद्यालयको रुपमा विकसित यस श्री त्रि-शहीद मा.वि.पञ्चमूलमा अध्ययन गरेका र अध्ययनरत सम्पूणर् विद्यार्थीहरु, सेवा निवृत्त एवं सेवारत शिक्षकहरु, अमूल्य योगदान दिनु हुने अभिभावकज्यूहरु प्रति हार्दिक शुभे्च्छा व्यक्त गर्दछु र समायानुकुल परिवर्तन हुदै आधुनिक युगअनुसारको प्रविधियुक्त शिक्षा प्रदान गरिरहेको यस विद्यालयको उत्तरोत्तर प्रगतिको कामना गर्दछु ।",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
