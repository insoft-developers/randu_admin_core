// ignore_for_file: deprecated_member_use

import 'package:buzz/appstaticdata/staticdata.dart';
import 'package:buzz/provider/proviercolors.dart';
import 'package:buzz/widgets/comuntitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends State<FileManagerScreen> {
  List checkBoxFolders = [];
  List checkBoxFiles = [];
  List checkBoxPayment = [];
  var isExpanded = false;

  bool colorChange = false;

  List isHoverFolders = [];
  List isHoverFiles = [];
  ColorNotifire notifier = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: Get.width,
          height: Get.height,
          color: notifier.getbgcolor,
          child: fileManger(constraints, size: constraints.maxWidth),
        );
      },
    );
  }

  Widget fileManger(constraints, {required double size}) {
    return Theme(
      data: Theme.of(context).copyWith(
          scrollbarTheme: const ScrollbarThemeData(
              thickness: MaterialStatePropertyAll(4),
              thumbColor: MaterialStatePropertyAll(
                Color(0xff883DCF),
              ))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ComunTitle(title: 'File Manager', path: "MISCELLANEOUS"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                              backgroundColor: MaterialStatePropertyAll(
                                appMainColor,
                              )),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text(
                                " Add Files",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Folders",
                    style: TextStyle(
                        color: notifier.getMainText,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PublicSansBold",
                        letterSpacing: 1),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    itemCount: folders.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size < 210
                          ? 1
                          : size < 600
                              ? 1
                              : size < 800
                                  ? 2
                                  : 4,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 80,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      Folders data = folders[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (checkBoxFolders.contains(index) == true) {
                              checkBoxFolders.remove(index);
                            } else {
                              checkBoxFolders.add(index);
                            }
                          });
                        },
                        onHover: (val) {
                          setState(() {
                            if (val == false) {
                              isHoverFolders.remove(index);
                            } else {
                              isHoverFolders.add(index);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(microseconds: 200),
                          padding: const EdgeInsets.all(10),
                          width: 360,
                          decoration: BoxDecoration(
                            color: notifier.getcontiner,
                            border: isHoverFolders.contains(index)
                                ? Border.all(color: appMainColor, width: 1)
                                : checkBoxFolders.contains(index)
                                    ? Border.all(color: appMainColor, width: 1)
                                    : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Checkbox(
                              //   checkColor: notifier.getcontiner,
                              //   activeColor: appMainColor,
                              //   side: BorderSide(
                              //       color: notifier.getMaingey, width: 1.7),
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(4),
                              //     side: BorderSide(
                              //         color: notifier.getMaingey, width: 1.7),
                              //   ),
                              //   value:
                              //       checkBoxFolders.contains(index) ? true : false,
                              //   onChanged: (bool? value) {
                              //     setState(() {
                              //       if (checkBoxFolders.contains(index) == true) {
                              //         checkBoxFolders.remove(index);
                              //       } else {
                              //         checkBoxFolders.add(index);
                              //       }
                              //     });
                              //   },
                              // ),

                              const SizedBox(width: 4),
                              SvgPicture.asset("assets/Folder.svg", height: 35),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.name,
                                    style: TextStyle(
                                        color: notifier.getMainText,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "PublicSansMedium"),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${data.count} Files",
                                    style: TextStyle(
                                        color: notifier.getMaingey,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "PublicSansMedium"),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Icon(Icons.more_vert,
                                  color: notifier.getMainText, size: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Files",
                    style: TextStyle(
                        color: notifier.getMainText,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PublicSansBold",
                        letterSpacing: 1),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    itemCount: files.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size < 210
                          ? 1
                          : size < 600
                              ? 1
                              : size < 800
                                  ? 2
                                  : size < 1200
                                      ? 3
                                      : 4,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 180,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      Files data = files[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (checkBoxFiles.contains(index) == true) {
                              checkBoxFiles.remove(index);
                            } else {
                              checkBoxFiles.add(index);
                            }
                          });
                        },
                        onHover: (val) {
                          setState(() {
                            if (val == false) {
                              isHoverFiles.remove(index);
                            } else {
                              isHoverFiles.add(index);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(microseconds: 200),
                          padding: const EdgeInsets.all(10),
                          width: 360,
                          decoration: BoxDecoration(
                            color: notifier.getcontiner,
                            border: isHoverFiles.contains(index)
                                ? Border.all(color: appMainColor, width: 1)
                                : checkBoxFiles.contains(index)
                                    ? Border.all(color: appMainColor, width: 1)
                                    : Border.all(
                                        color: Colors.grey.shade200, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Checkbox(
                                    checkColor: notifier.getcontiner,
                                    activeColor: appMainColor,
                                    side: BorderSide(
                                        color: notifier.getMaingey, width: 1.7),
                                    shape: const CircleBorder(),
                                    value: checkBoxFiles.contains(index)
                                        ? true
                                        : false,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (checkBoxFiles.contains(index) ==
                                            true) {
                                          checkBoxFiles.remove(index);
                                        } else {
                                          checkBoxFiles.add(index);
                                        }
                                      });
                                    },
                                  ),
                                  Icon(Icons.more_vert,
                                      color: notifier.getMaingey, size: 20),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(data.image, height: 55),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.name,
                                      style: TextStyle(
                                          color: notifier.getMainText,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "PublicSansMedium"),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${data.count} Files",
                                      style: TextStyle(
                                          color: notifier.getMaingey,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "PublicSansMedium"),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  "assets/user-circle.svg",
                                  height: 30,
                                  width: 30,
                                  color: notifier.getMaingey,
                                ),
                              ]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Folders {
  String name;
  String count;

  Folders({
    required this.name,
    required this.count,
  });
}

List<Folders> folders = [
  Folders(name: "Design Collections", count: "15"),
  Folders(name: "Figma Systems", count: "10"),
  Folders(name: "How to Build Brand", count: "20"),
  Folders(name: "Flutter", count: "5"),
];

class Files {
  String name;
  String count;
  String image;

  Files({
    required this.name,
    required this.count,
    required this.image,
  });
}

List<Files> files = [
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Doc.png", name: "2nd Meeting MOM", count: "100"),
  Files(image: "assets/Doc.png", name: "Brainstorming", count: "300"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Doc.png", name: "Third Meeting MOM", count: "400"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Doc.png", name: "2nd Meeting MOM", count: "100"),
  Files(image: "assets/Doc.png", name: "Brainstorming", count: "300"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Doc.png", name: "Third Meeting MOM", count: "400"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Doc.png", name: "2nd Meeting MOM", count: "100"),
  Files(image: "assets/Doc.png", name: "Brainstorming", count: "300"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Doc.png", name: "Third Meeting MOM", count: "400"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Doc.png", name: "2nd Meeting MOM", count: "100"),
  Files(image: "assets/Doc.png", name: "Brainstorming", count: "300"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Doc.png", name: "Third Meeting MOM", count: "400"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Pdf.png", name: "New Wireframe", count: "200"),
  Files(image: "assets/Doc.png", name: "2nd Meeting MOM", count: "100"),
  Files(image: "assets/Doc.png", name: "Brainstorming", count: "300"),
  Files(image: "assets/Pdf.png", name: "Requirement", count: "150"),
  Files(image: "assets/Doc.png", name: "Third Meeting MOM", count: "400"),
];
