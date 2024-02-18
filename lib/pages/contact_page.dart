import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/utilities/images.dart';
import 'package:trishaheed/widgets/footer.dart';
import '../utilities/textstyles.dart';
import '../widgets/complaint_form.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      autofocus: true,
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                "User Feedback Form",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
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
                              SizedBox(height: 8),
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
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 50,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    }
  }
}
