// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

import 'package:toastification/toastification.dart';

import '../Widgets/comuntitle.dart';

import '../appstaticdata/staticdata.dart';

import '../provider/proviercolors.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void dispose() {
    super.dispose();

    Future.delayed(const Duration(seconds: 0), () {
      for (int a = 0; a < notification.length; a++) {
        toastification.dismiss(notification[a]);
      }

      for (int a = 0; a < notifications.length; a++) {
        toastification.dismiss(notifications[a]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorNotifire>(
      builder: (context, value, child) => ToastificationConfigProvider(
        config: const ToastificationConfig(
          alignment: Alignment.centerRight,
          itemWidth: 440,
          animationDuration: Duration(milliseconds: 500),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: notifire!.getbgcolor,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                // Mobile layout
                return SizedBox(
                  height: 900,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const ComunTitle(
                            title: 'Notification', path: "Buttons"),
                        _buildDefault(),
                        _buildDefault1(),
                        _buildDefault2(),
                        _buildDefault3()
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 1000,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const ComunTitle(
                            title: 'Notification', path: "Buttons"),
                        _buildDefault(),
                        _buildDefault1(),
                        _buildDefault2(),
                        _buildDefault3()
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDefault() {
    return Padding(
        padding: const EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: notifire!.getcontiner,
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Notification Alert",
                      style: mediumBlackTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: notifire!.getMainText),
                      maxLines: 2),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(
                    color: appMainColor,
                    "assets/settingsfill.svg",
                    width: 18,
                    height: 18,
                  )
                ],
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 60,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.spaceEvenly,
                runSpacing: 20,
                spacing: 20,
                children: [
                  _buildDefaultButton(
                    title: "Default",
                    color: appMainColor,
                    ontapp: () {
                      notifications.add(notificationss(
                          color: appMainColor,
                          subtitle: "I am a default notification.",
                          title: "Hello!"));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Success",
                    color: const Color(0xff54ba4a),
                    ontapp: () {
                      notifications.add(notificationss(
                          title: "Well Done!",
                          color: const Color(0xff54ba4a),
                          subtitle:
                              "You just submit your resume successfully."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Info",
                    color: const Color(0xff16c7f9),
                    ontapp: () {
                      notifications.add(notificationss(
                          title: "Reminder!",
                          color: const Color(0xff16c7f9),
                          subtitle: "You have a meeting at 10:30 AM."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Warning",
                    color: const Color(0xffffaa05),
                    ontapp: () {
                      notifications.add(notificationss(
                          title: "Warning!",
                          color: const Color(0xffffaa05),
                          subtitle: "The data presented here can be change."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Danger",
                    color: const Color(0xfffc4438),
                    ontapp: () {
                      notifications.add(notificationss(
                          title: "Sorry!",
                          color: const Color(0xfffc4438),
                          subtitle: "Could not complete your transaction."));
                    },
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  Widget _buildDefault1() {
    return Padding(
        padding: const EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: notifire!.getcontiner,
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Notification with Icons",
                      style: mediumBlackTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: notifire!.getMainText),
                      maxLines: 2),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(
                    color: appMainColor,
                    "assets/settingsfill.svg",
                    width: 18,
                    height: 18,
                  )
                ],
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 60,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.spaceEvenly,
                runSpacing: 20,
                spacing: 20,
                children: [
                  _buildDefaultButton(
                    title: "Default",
                    color: const Color(0xffFFC36A),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          iconpath: "assets/archive.svg",
                          color: const Color(0xffFFC36A),
                          subtitle: "I am a default notification.",
                          title: "Hello!"));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Success",
                    color: const Color(0xff4CAF50),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          iconpath: "assets/verify.svg",
                          title: "Well Done!",
                          color: const Color(0xff4CAF50),
                          subtitle:
                              "You just submit your resume successfully."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Info",
                    color: const Color(0xffFF29EA),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          iconpath: "assets/cup.svg",
                          title: "Reminder!",
                          color: const Color(0xffFF29EA),
                          subtitle: "You have a meeting at 10:30 AM."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Warning",
                    color: const Color(0xffBDFF00),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          iconpath: "assets/more-square.svg",
                          title: "Warning!",
                          color: const Color(0xffBDFF00),
                          subtitle: "The data presented here can be change."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Danger",
                    color: const Color(0xffF44336),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          iconpath: "assets/danger.svg",
                          title: "Sorry!",
                          color: const Color(0xffF44336),
                          subtitle: "Could not complete your transaction."));
                    },
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  List notification = [];
  List notifications = [];
  Widget _buildDefault3() {
    return Padding(
        padding: const EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: notifire!.getcontiner,
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Using the notification hide method",
                      style: mediumBlackTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: notifire!.getMainText),
                      maxLines: 2),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(
                    color: appMainColor,
                    "assets/settingsfill.svg",
                    width: 18,
                    height: 18,
                  )
                ],
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 60,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.spaceEvenly,
                runSpacing: 20,
                spacing: 20,
                children: [
                  _buildDefaultButton(
                    title: "Show notification",
                    color: const Color(0xffFFC36A),
                    ontapp: () {
                      notification.add(notificationssWithIcon(
                          iconpath: "assets/archive.svg",
                          color: const Color(0xffFFC36A),
                          subtitle: "I am a default notification.",
                          title: "Hello!"));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Hide Notification",
                    color: const Color(0xffdc2626),
                    ontapp: () {
                      for (int a = 0; a < notification.length; a++) {
                        toastification.dismiss(notification[a]);
                      }
                    },
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  Widget _buildDefault2() {
    return Padding(
        padding: const EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: notifire!.getcontiner,
            boxShadow: boxShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Auto Close Notifications",
                      style: mediumBlackTextStyle.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: notifire!.getMainText),
                      maxLines: 2),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(
                    color: appMainColor,
                    "assets/settingsfill.svg",
                    width: 18,
                    height: 18,
                  )
                ],
              ),
              Divider(
                color: Colors.grey.shade300,
                height: 60,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.spaceEvenly,
                runSpacing: 20,
                spacing: 20,
                children: [
                  _buildDefaultButton(
                    title: "Default",
                    color: const Color(0xffFFC36A),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          istime: true,
                          iconpath: "assets/archive.svg",
                          color: const Color(0xffFFC36A),
                          subtitle: "I am a default notification.",
                          title: "Hello!"));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Success",
                    color: const Color(0xff4CAF50),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          istime: true,
                          iconpath: "assets/verify.svg",
                          title: "Well Done!",
                          color: const Color(0xff4CAF50),
                          subtitle:
                              "You just submit your resume successfully."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Info",
                    color: const Color(0xffFF29EA),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          istime: true,
                          iconpath: "assets/cup.svg",
                          title: "Reminder!",
                          color: const Color(0xffFF29EA),
                          subtitle: "You have a meeting at 10:30 AM."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Warning",
                    color: const Color(0xffBDFF00),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          istime: true,
                          iconpath: "assets/more-square.svg",
                          title: "Warning!",
                          color: const Color(0xffBDFF00),
                          subtitle: "The data presented here can be change."));
                    },
                  ),
                  _buildDefaultButton(
                    title: "Danger",
                    color: const Color(0xffF44336),
                    ontapp: () {
                      notifications.add(notificationssWithIcon(
                          istime: true,
                          iconpath: "assets/danger.svg",
                          title: "Sorry!",
                          color: const Color(0xffF44336),
                          subtitle: "Could not complete your transaction."));
                    },
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  Widget _buildDefaultButton(
      {required String title,
      required Color color,
      required void Function() ontapp,
      Color? textcolor,
      bool bordertrue = false}) {
    return ElevatedButton(
        onPressed: ontapp,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            side: BorderSide(
                color: bordertrue ? Colors.grey.shade300 : Colors.transparent),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            backgroundColor: color),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w300, color: textcolor ?? Colors.white),
        ));
  }

  ToastificationItem notificationss(
      {required String title, required String subtitle, required Color color}) {
    return toastification.show(
      context: context,
      showProgressBar: false,
      backgroundColor: notifire!.getcontiner,
      icon: Container(
        height: 50,
        width: 3,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
      ),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(color: notifire!.getbacktextcolors),
        ),
        Text(
          subtitle,
          style: TextStyle(color: notifire!.getMaingey),
        ),
      ]),
    );
  }

  ToastificationItem notificationssWithIcon(
      {required String title,
      required String subtitle,
      required Color color,
      required String iconpath,
      bool? istime}) {
    return toastification.show(
      context: context,
      showProgressBar: false,
      autoCloseDuration: istime ?? false ? const Duration(seconds: 5) : null,
      backgroundColor: notifire!.getcontiner,
      icon: Container(
        height: 50,
        width: 3,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
      ),
      title: Row(
        children: [
          SvgPicture.asset(
            iconpath,
            height: 35,
            width: 35,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: TextStyle(color: notifire!.getbacktextcolors),
              ),
              Text(
                subtitle,
                style: TextStyle(color: notifire!.getMaingey),
              ),
            ]),
          ),
        ],
      ),

      // autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
