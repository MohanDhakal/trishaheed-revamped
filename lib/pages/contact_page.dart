import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/utilities/images.dart';
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
                      color: Colors.white,
                      child: SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.25,
                        child: Column(
                          children: [
                            SizedBox(height: 24),
                            Image.asset(
                              customerCare,
                              height: size.height * 0.1,
                              width: size.width * 0.1,
                            ),
                            SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Center(
                                child: Text(
                                  """Send Your Message Directly to the authority,One of our admin will forward message to the concerned department.""",
                                  style: CustomTextStyle.quote(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
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
