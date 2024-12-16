// ignore_for_file: deprecated_member_use

import 'package:buzz/login/login_controllder.dart';
import 'package:buzz/provider/proviercolors.dart';
import 'package:buzz/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'appstaticdata/staticdata.dart';

class AppBarCode extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCode({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarCode> createState() => _AppBarCodeState();
}

class _AppBarCodeState extends State<AppBarCode> {
  bool search = false;
  bool darkMood = false;
  final AppConst controller = Get.put(AppConst());
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ColorNotifire>(context);
    final screenwidth = Get.width;
    bool ispresent = false;
    // getting the value from the provider instance

    const breakpoint = 600.0;

    if (screenwidth >= breakpoint) {
      setState(() {
        ispresent = true;
      });
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return GetBuilder<AppConst>(builder: (controller) {
        return AppBar(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: notifier.getbordercolor)),
          backgroundColor: notifier.getprimerycolor,
          elevation: 1,
          leading: ispresent
              ? InkWell(
                  onTap: () {
                    controller.updateshowDrawer();
                  },
                  child: SizedBox(
                      height: 27,
                      width: 27,
                      child: Center(
                          child: Image.asset(
                        "assets/menu-home.png",
                        height: 25,
                        width: 25,
                        color: notifier.geticoncolor,
                      ))))
              : InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SizedBox(
                      height: 27,
                      width: 27,
                      child: Center(
                          child: SvgPicture.asset(
                        "assets/menu-left.svg",
                        height: 25,
                        width: 25,
                        color: notifier.geticoncolor,
                      )))),
          title: search
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        height: 42,
                        width: Get.width * 0.3,
                        child: TextField(
                          style: TextStyle(color: notifier.getMainText),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 5),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: notifier.getbordercolor, width: 2)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: notifier.getbordercolor, width: 2)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: notifier.getbordercolor, width: 2)),
                            hintStyle: TextStyle(color: notifier.getMainText),
                            hintText: "Search..",
                            prefixIcon: SizedBox(
                                height: 16,
                                width: 16,
                                child: Center(
                                    child: SvgPicture.asset(
                                  "assets/search.svg",
                                  height: 16,
                                  width: 16,
                                  color: notifier.geticoncolor,
                                ))),
                          ),
                        )),
                  ],
                )
              : const SizedBox(),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                PopupMenuButton(
                  color: notifier.getcontiner,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tooltip: "Notifications",
                  offset: const Offset(0, 50),
                  icon: SvgPicture.asset(
                    "assets/bell-notification.svg",
                    width: 20,
                    height: 20,
                    color: notifier.geticoncolor,
                  ),
                  itemBuilder: (ctx) => [],
                ),
                PopupMenuButton(
                  color: notifier.getcontiner,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  tooltip: "Account",
                  offset: Offset(0, constraints.maxWidth >= 800 ? 60 : 50),
                  child: const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage("assets/randu_core_icon.png"),
                      backgroundColor: Colors.transparent),
                  itemBuilder: (ctx) => [
                    _buildPopupAdminMenuItem(),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        );
      });
    });
  }

  PopupMenuItem _buildPopupAdminMenuItem() {
    LoginController _controller = Get.put(LoginController());
    return PopupMenuItem(
      enabled: false,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 90,
            width: 155,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _controller.logout();
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool light1 = true;

  TableRow row(
      {required String title, required String icon, required int index}) {
    return TableRow(children: [
      TableRowInkWell(
        onTap: () {
          controller.changePage(index);
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset(icon,
              width: 18, height: 18, color: notifire!.geticoncolor),
        ),
      ),
      TableRowInkWell(
        onTap: () {
          controller.changePage(index);
          Get.back();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 20, top: 12, right: 20),
          child: Text(title,
              style:
                  mediumBlackTextStyle.copyWith(color: notifire!.getMainText)),
        ),
      ),
    ]);
  }
}

Widget _buildcomuntile(
    {required String title,
    required String subtile,
    EdgeInsetsGeometry? padding,
    required Color color,
    required String backgroundImage,
    Color? backcolor,
    FontWeight? fontWeight,
    Color? colors,
    double? width,
    double? height,
    required Color colorsub}) {
  return Container(
    color: backcolor,
    child: Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 15),
          //   child: Container(
          //     width: 7,
          //     height: 7,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(100), color: color),
          //   ),
          // ),
          Flexible(
            flex: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              trailing: Text(
                "just now",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                    overflow: TextOverflow.ellipsis),
              ),
              title: Text(
                title,
                style: TextStyle(
                    color: colors,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(subtile,
                  style: TextStyle(
                      color: colorsub,
                      fontWeight: fontWeight,
                      overflow: TextOverflow.ellipsis)),
              leading: Material(
                // elevation: 3,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  padding: padding,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        backgroundImage,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
