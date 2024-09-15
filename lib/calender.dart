import 'dart:math';

import 'package:buzz/appstaticdata/staticdata.dart';
import 'package:buzz/provider/proviercolors.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final CalendarDataSource _dataSource = _DataSource(<Appointment>[]);
  final List<String> _subjectCollection = <String>[];
  final List<DateTime> _startTimeCollection = <DateTime>[];
  final List<DateTime> _endTimeCollection = <DateTime>[];
  final List<Color> _colorCollection = <Color>[];
  List<TimeRegion> _specialTimeRegion = <TimeRegion>[];

  @override
  void initState() {
    _getSubjectCollection();
    _getStartTimeCollection();
    _getEndTimeCollection();
    _getColorCollection();
    super.initState();
  }

  ColorNotifire notifier = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: notifier.getbgcolor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ComunTitle(title: 'Calendar', path: "MISCELLANEOUS"),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  width: Get.width,
                  height: Get.height,
                  color: notifier.getbgcolor,
                  child: calenderData(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget calenderData() {
    return Container(
      // height: Get.height,
      // margin: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: notifier.getbgcolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SfCalendar(
          timeSlotViewSettings: TimeSlotViewSettings(
            timeTextStyle: TextStyle(
              color: notifier.getMainText,
            ),
          ),
          monthViewSettings: MonthViewSettings(
            monthCellStyle: MonthCellStyle(
              textStyle: TextStyle(color: notifier.getMainText),
              leadingDatesTextStyle: TextStyle(color: notifier.getMaingey),
              trailingDatesTextStyle: TextStyle(color: notifier.getMaingey),
            ),
          ),
          viewHeaderStyle: ViewHeaderStyle(
            dayTextStyle: TextStyle(color: notifier.getMainText),
            dateTextStyle: TextStyle(color: notifier.getMainText),
          ),
          dataSource: _dataSource,
          headerStyle: CalendarHeaderStyle(
              textStyle: TextStyle(color: notifier.getMainText)),
          cellBorderColor: notifier.getMaingey,
          backgroundColor: notifier.getcontiner,
          todayHighlightColor: appMainColor,
          view: CalendarView.month,
          allowedViews: const [
            CalendarView.day,
            CalendarView.week,
            CalendarView.workWeek,
            CalendarView.month,
            CalendarView.timelineDay,
            CalendarView.timelineWeek,
            CalendarView.timelineWorkWeek,
            CalendarView.timelineMonth,
            CalendarView.schedule
          ],
          scheduleViewSettings: ScheduleViewSettings(
              appointmentTextStyle: TextStyle(color: notifier.getMainText)),
          onViewChanged: viewChanged,
          specialRegions: _specialTimeRegion,
        ),
      ),
    );
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    List<DateTime> visibleDates = viewChangedDetails.visibleDates;
    List<TimeRegion> timeRegion = <TimeRegion>[];
    List<Appointment> appointments = <Appointment>[];
    _dataSource.appointments!.clear();

    for (int i = 0; i < visibleDates.length; i++) {
      if (visibleDates[i].weekday == 6 || visibleDates[i].weekday == 7) {
        continue;
      }
      timeRegion.add(TimeRegion(
          startTime: DateTime(visibleDates[i].year, visibleDates[i].month,
              visibleDates[i].day, 13, 0, 0),
          endTime: DateTime(visibleDates[i].year, visibleDates[i].month,
              visibleDates[i].day, 14, 0, 0),
          text: 'Break',
          enablePointerInteraction: false));

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _specialTimeRegion = timeRegion;
        });
      });

      for (int j = 0; j < _startTimeCollection.length; j++) {
        DateTime startTime = DateTime(
            visibleDates[i].year,
            visibleDates[i].month,
            visibleDates[i].day,
            _startTimeCollection[j].hour,
            _startTimeCollection[j].minute,
            _startTimeCollection[j].second);
        DateTime endTime = DateTime(
            visibleDates[i].year,
            visibleDates[i].month,
            visibleDates[i].day,
            _endTimeCollection[j].hour,
            _endTimeCollection[j].minute,
            _endTimeCollection[j].second);
        Random random = Random();
        appointments.add(Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: _subjectCollection[random.nextInt(9)],
            color: _colorCollection[random.nextInt(9)]));
      }
    }

    for (int i = 0; i < appointments.length; i++) {
      _dataSource.appointments!.add(appointments[i]);
    }

    _dataSource.notifyListeners(
        CalendarDataSourceAction.reset, _dataSource.appointments!);
  }

  void _getSubjectCollection() {
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');
    _subjectCollection.add('Project Plan');
    _subjectCollection.add('Consulting');
    _subjectCollection.add('Support');
    _subjectCollection.add('Development Meeting');
    _subjectCollection.add('Scrum');
    _subjectCollection.add('Project Completion');
    _subjectCollection.add('Release updates');
    _subjectCollection.add('Performance Check');
  }

  void _getStartTimeCollection() {
    var currentDateTime = DateTime.now();

    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 9, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 10, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 11, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 12, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 14, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 15, 0, 0));
    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 16, 0, 0));

    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 17, 0, 0));

    _startTimeCollection.add(DateTime(currentDateTime.year,
        currentDateTime.month, currentDateTime.day, 18, 0, 0));
  }

  void _getEndTimeCollection() {
    var currentDateTime = DateTime.now();
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 10, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 11, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 12, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 13, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 15, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 16, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 17, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 18, 0, 0));
    _endTimeCollection.add(DateTime(currentDateTime.year, currentDateTime.month,
        currentDateTime.day, 19, 0, 0));
  }

  void _getColorCollection() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
