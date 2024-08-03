import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../model/states/EventState.dart';
import 'event_card.dart';

class EventSection extends StatefulWidget {
  const EventSection({super.key});

  @override
  State<EventSection> createState() => _EventSectionState();
}

class _EventSectionState extends State<EventSection> {
  double endX = 0;
  double endY = 100;

  @override
  void initState() {
    super.initState();
    Provider.of<EventState>(context, listen: false).events();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;
    return VisibilityDetector(
      key: Key('events'),
      onVisibilityChanged: (VisibilityInfo info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage > 1) {
          if (endY != 0) setState(() => endY = 0);
          // debugPrint('Widget ${info.key} is ${visiblePercentage}% visible');
        }
      },
      child: TweenAnimationBuilder(
          tween: Tween<Offset>(begin: Offset(0,100), end: Offset(endX, endY)),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: Column(
            children: [
              ResponsiveRowColumnItem(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Latest Events",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontStyle: FontStyle.normal,
                        ),
                  ),
                ),
              ),
              ResponsiveRowColumnItem(
                child: SizedBox(
                  width: size.width * 0.2,
                  child: Divider(thickness: 4),
                ),
              ),
              const ResponsiveRowColumnItem(child: SizedBox(height: 24)),
            ],
          ),
          builder: (BuildContext context,Offset value, child) {
            return Transform.translate(
              offset: value,
              child: Column(
                children: [
                  child ?? SizedBox(),
                  Consumer<EventState>(builder: (context, model, child) {
                    return ResponsiveRowColumn(
                      layout: responsiveWrapper.isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnType.COLUMN
                          : ResponsiveRowColumnType.ROW,
                      rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      columnMainAxisAlignment: MainAxisAlignment.center,
                      columnMainAxisSize: MainAxisSize.min,
                      children: [
                        ...model.schoolEvents.map((e) {
                          return ResponsiveRowColumnItem(
                              child: EventCard(
                            bannerUrl: e.imageUri,
                            title: e.eventName,
                            description: e.eventDescription,
                            startDate: e.startDate,
                            endDate: e.endDate,
                            startTime: e.startTime,
                            endTime: e.endTime,
                          ));
                        }).toList()
                      ],
                    );
                  }),
                ],
              ),
            );
          }),
    );
  }
}
