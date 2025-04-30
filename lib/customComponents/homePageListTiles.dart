import 'package:flutter/material.dart';
import 'package:routi_n/pages/HomePage/view/homePage.dart';

class Homepagelisttiles extends StatefulWidget {
  Homepagelisttiles({required this.details, super.key});

  DummyDataModel details;

  @override
  State<Homepagelisttiles> createState() => HomepagelisttilesState();
}

class HomepagelisttilesState extends State<Homepagelisttiles> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  customTextWidget(
                    text: widget.details.title ?? '',
                    fontweight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  customTextWidget(
                    text: widget.details.subTitle ?? '',
                    fontweight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Checkbox(
                    shape: CircleBorder(eccentricity: 0.8),
                    value: selected,
                    onChanged: (value) {
                      setState(() {
                        selected = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Divider(color: Colors.black, endIndent: 1, indent: 1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: customTextWidget(
                  text: widget.details.caption ?? '',
                  fontweight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  value: calculateProgress(
                    widget.details.startDateTime,
                    widget.details.endDateTime,
                  ),

                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                  color: Colors.blue,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customTextWidget({
    required String text,
    required FontWeight fontweight,
    required double fontSize,
  }) {
    return Text(
      text,
      maxLines: 10,
      overflow: TextOverflow.fade,
      softWrap: true,

      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.black,
        fontWeight: fontweight,
        fontSize: fontSize,
      ),
    );
  }

  calculateProgress(DateTime? startDateTime, DateTime? endDateTime) {
    if (startDateTime == null || endDateTime == null) {
      return 0.0;
    }

    final totalDuration = endDateTime.difference(startDateTime).inSeconds;
    if (totalDuration <= 0) {
      return 0.0;
    }

    final elapsedDuration = DateTime.now().difference(startDateTime).inSeconds;
    return (elapsedDuration / totalDuration).clamp(0.0, 1.0);
  }
}
