import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/utilities/images.dart';

class EventCard extends StatelessWidget {
  final String? bannerUrl;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;

  EventCard({
    required this.bannerUrl,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveWrapper = ResponsiveWrapper.of(context);
    final size = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: bannerUrl == null
                ? Image.asset(
                    eventBanner,
                    fit: BoxFit.cover,
                    width: responsiveWrapper.isSmallerThan(DESKTOP)
                        ? size.width * 0.9
                        : size.width * 0.3,
                    height: size.height * 0.4,
                  )
                : Image.network(
                    bannerUrl!,
                    fit: BoxFit.cover,
                    width: responsiveWrapper.isSmallerThan(DESKTOP)
                        ? size.width * 0.9
                        : size.width * 0.3,
                    height: size.height * 0.3,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SelectableText(description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Starts at: $startDate  $startTime  ',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,

                  ),
                ),
                Text(
                  '  Ends at:$endDate  $endTime  ',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
