import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/widgets/footer.dart';
import 'package:webviewx/webviewx.dart';
import '../utilities/textstyles.dart';
import '../widgets/complaint_form.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    late WebViewXController webviewController;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              ComplaintForm(),
              ResponsiveWrapper.of(context).isLargerThan(TABLET)
                  ? Card(
                      elevation: 12,
                      color: Colors.blue,
                      child: SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Center(
                            child: Text(
                              """Send Your Message Directly to the authority,One of our admin will forward message to the concerned department.""",
                              style: CustomTextStyle.quote(context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          FooterWidget(),
        ],
      ),
    );
  }
}
