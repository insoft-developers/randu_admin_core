import 'package:buzz/appstaticdata/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/proviercolors.dart';
import '../widgets/comuntitle.dart';

class TabsPills extends StatefulWidget {
  const TabsPills({super.key});

  @override
  State<TabsPills> createState() => _TabsPillsState();
}

class _TabsPillsState extends State<TabsPills> with TickerProviderStateMixin {
  late TabController controller1;
  late TabController controller2;
  late TabController controller3;

  int tab1 = 0;
  int tab2 = 0;
  int tab3 = 0;

  ColorNotifire notifier = ColorNotifire();

  List varticallist = [
    "Home",
    "Profile",
    "Messages",
    "Setting",
  ];

  @override
  void initState() {
    controller1 = TabController(length: 3, vsync: this);
    controller2 = TabController(length: 3, vsync: this);
    controller3 = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.getbgcolor,
      body: SingleChildScrollView(child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(children: [
            const ComunTitle(title: 'Tabs & Pills', path: "MISCELLANEOUS"),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(padding),

                    // height: 50,
                    decoration: BoxDecoration(
                      color: notifier.getcontiner,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: padding, right: padding, top: padding),
                          child: Text(
                            "Basic Tabs",
                            style: TextStyle(
                                color: notifier.getMainText,
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "PublicSansMedium"),
                          ),
                        ),
                        TabBar(
                            isScrollable: true,
                            controller: controller1,
                            indicatorColor: Colors.grey.shade300,
                            indicatorPadding: const EdgeInsets.only(bottom: 6),
                            labelStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                            unselectedLabelColor: notifier.getMainText,
                            labelColor: appMainColor,
                            onTap: (value) {
                              setState(() {
                                tab1 = value;
                              });
                            },
                            tabs: const [
                              Tab(
                                  child: Text(
                                "HOME",
                              )),
                              Tab(
                                  child: Text(
                                "PROFILE",
                              )),
                              Tab(
                                  child: Text(
                                "CONTACT",
                              )),
                            ]),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: padding, left: padding, bottom: padding),
                          child: Column(
                            children: [
                              tab1 == 0
                                  ? Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: notifier.getMainText,
                                          fontWeight: FontWeight.w100),
                                    )
                                  : tab1 == 1
                                      ? Text(
                                          "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: notifier.getMainText,
                                              fontWeight: FontWeight.w100),
                                        )
                                      : Text(
                                          "the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: notifier.getMainText,
                                              fontWeight: FontWeight.w100),
                                        )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(padding),
                    padding: const EdgeInsets.all(padding),

                    // height: 50,
                    decoration: BoxDecoration(
                      color: notifier.getcontiner,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Basic Pills",
                          style: TextStyle(
                              color: notifier.getMainText,
                              letterSpacing: 0.5,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PublicSansMedium"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 35,
                          child: TabBar(
                              isScrollable: true,
                              controller: controller2,
                              indicator: BoxDecoration(
                                color: appMainColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelStyle: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                              unselectedLabelColor: appMainColor,
                              labelColor: Colors.white,
                              onTap: (value) {
                                setState(() {
                                  tab2 = value;
                                });
                              },
                              tabs: const [
                                Tab(
                                    child: Text(
                                  "Home",
                                )),
                                Tab(
                                    child: Text(
                                  "Profile",
                                )),
                                Tab(
                                    child: Text(
                                  "Contact",
                                )),
                              ]),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            tab2 == 0
                                ? Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: notifier.getMainText,
                                        fontWeight: FontWeight.w100),
                                  )
                                : tab2 == 1
                                    ? Text(
                                        "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: notifier.getMainText,
                                            fontWeight: FontWeight.w100),
                                      )
                                    : Text(
                                        "the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: notifier.getMainText,
                                            fontWeight: FontWeight.w100),
                                      )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(padding),
                    padding: const EdgeInsets.all(padding),

                    // height: 50,
                    decoration: BoxDecoration(
                      color: notifier.getcontiner,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vertical Pills",
                          style: TextStyle(
                              color: notifier.getMainText,
                              letterSpacing: 0.5,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PublicSansMedium"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        constraints.maxWidth < 600
                            ? Column(
                                children: [
                                  tabbbar3(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  tabview3(),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 1, child: tabbbar3()),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(flex: 3, child: tabview3()),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]);
        },
      )),
    );
  }

  Widget tabbbar3() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                tab3 = index;
              });
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: tab3 == index ? appMainColor : Colors.transparent,
                ),
                child: Text(
                  "${varticallist[index]}",
                  style: TextStyle(
                      color:
                          tab3 == index ? Colors.white : notifier.getMainText,
                      fontSize: 13),
                )),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: varticallist.length);
  }

  Widget tabview3() {
    return Container(
      child: tab3 == 0
          ? Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
              style: TextStyle(
                  fontSize: 14,
                  color: notifier.getMainText,
                  fontWeight: FontWeight.w100,
                  height: 1.7),
            )
          : tab3 == 1
              ? Text(
                  "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  style: TextStyle(
                      fontSize: 14,
                      color: notifier.getMainText,
                      fontWeight: FontWeight.w100,
                      height: 1.7),
                )
              : Text(
                  "the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  style: TextStyle(
                      fontSize: 14,
                      color: notifier.getMainText,
                      fontWeight: FontWeight.w100,
                      height: 1.7),
                ),
    );
  }
}
