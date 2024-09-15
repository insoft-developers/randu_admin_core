// ignore_for_file: deprecated_member_use

import 'package:buzz/appstaticdata/staticdata.dart';
import 'package:buzz/provider/proviercolors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Widgets/comuntitle.dart';
import '../Widgets/sizebox.dart';
import '../comunbottombar.dart';

class NewAddProjectPage extends StatefulWidget {
  const NewAddProjectPage({super.key});

  @override
  State<NewAddProjectPage> createState() => _NewAddProjectPageState();
}

class _NewAddProjectPageState extends State<NewAddProjectPage> {

  ColorNotifire notifire = ColorNotifire();

  final List<String> genderItems = [
    'Under18',
    '18+',
  ];

  final List<String> genderItems1 = [
    'Male',
    'Female',
  ];

  // ignore: non_constant_identifier_names
  final List<String> SizeItems = [
    '28',
    '30',
    '32',
    '34',
    '36',
    '38',
    '40'
  ];

  bool status = false;
  bool status1 = false;
  bool value = false;
  bool value1 = false;

  String? selectedValue;
  String? selectedValue1;
  String? selectedValue2;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context,listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Column(
                children: [
                  const ComunTitle(title: 'Create New',path: "Project"),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Container(
                      decoration: BoxDecoration(
                          color: notifire.getcontiner,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          buildProduct(),
                          buildDiscount(),
                          buildVariat(),
                          const SizedBox(height: 15,),
                          buildSave(),
                          const SizedBox(height: 12,),
                        ],
                      ),
                    ),
                  ),
                  const SizeBoxx(),
                  const ComunBottomBar(),
                ],
              );
            } else if (constraints.maxWidth < 1200) {
              return Column(
                children: [
                  const ComunTitle(title: 'Create New',path: "Project"),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Container(
                        decoration: BoxDecoration(
                          color: notifire.getcontiner,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: buildProduct1(size: constraints.maxWidth)),
                  ),
                  const SizeBoxx(),
                  const ComunBottomBar(),
                ],
              );
            } else {
              return Column(
                children: [
                  const ComunTitle(title: 'Create New',path: "Project"),
                  Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Container(
                      decoration: BoxDecoration(
                        color: notifire.getcontiner,
                       borderRadius: BorderRadius.circular(12),
                      ),
                        child: buildProduct1(size: constraints.maxWidth)),
                  ),
                  const SizeBoxx(),
                  const ComunBottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildProduct() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 20,
                width: 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.3)),
              ),
              const SizedBox(width: 5),
              Text(
                "Product Informations",
                style: TextStyle(
                    color: notifire.getbacktextcolors,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18),
              )
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Product name",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 2),
                Text(
                  "Do not exceed 20 characters when entering the product name.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, right: 20),
              child: TextField(
                  style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                      ),
                      labelText: 'Enter product name',
                      labelStyle: mediumGreyTextStyle,
                  )),
            ),
            const SizedBox(height: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  "SKU",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 5),
                Text(
                  "SKU is a scannable barcode and is the unit of measure in which the\nstock of a product is managed",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 20),
              child: TextField(
                  style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                      ),
                      labelText: 'Enter SKU',
                      labelStyle: mediumGreyTextStyle
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Price",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, right: 20),
              child: TextField(
                  style: TextStyle(
                      color: notifire.getbacktextcolors
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                      ),
                      border: const OutlineInputBorder(),
                      labelText: '000',
                      labelStyle: mediumGreyTextStyle,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: notifire.getdolorcolors),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, top: 5),
                            child: Text("\$",
                                style: TextStyle(
                                    color: notifire.getbacktextcolors,
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Category",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 5),
                Text(
                  "Please select your product category from the list provided.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 20),
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                  // the menu padding when button's width is not specified.
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // Add more decoration..
                ),
                hint: Text(
                  'Select Your Category',
                  style: mediumGreyTextStyle
                ),

                items: genderItems.map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select Category.';
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: notifire.getbacktextcolors,
                  ),
                  iconSize: 24,
                ),
                style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: notifire.getcontiner,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Gender",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 5),
                Text(
                  "Set the gender for this product.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 20),
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                  // the menu padding when button's width is not specified.
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // Add more decoration..
                ),
                hint: Text(
                  'Select Your Gender',
                  maxLines: 1,
                  style:mediumGreyTextStyle,
                ),
                items: genderItems1
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select Gender.';
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved: (value) {
                  selectedValue1 = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: notifire.getbacktextcolors,
                  ),
                  iconSize: 24,
                ),
                style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: notifire.getcontiner,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Photo Product",
                  style: TextStyle(color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 5),
                Text(
                  "Recommended minimum with 1080pxX1080px.with a max size of\n5MB only*.png*.png.*.jpg.and*.jpeg image files are accepted.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: DottedBorder(
                    radius: const Radius.circular(30),
                    color: Colors.grey.withOpacity(0.3),
                    child: SizedBox(
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Icon(Icons.file_upload_outlined,
                                  size: 30, color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: Container(
                                height: 37,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff5e59ff)),
                                child: const Center(
                                    child: Text(
                                      "Add image",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text(
                                "or Drop image to\n        Upload",
                                style: TextStyle(color: notifire.getsubcolors,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Status",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 2),
                Text(
                  "Set a status for your product to determine whenther\nyour product is displayed or not.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  height: 50,
                  width: 80,
                  child: Switch(
                    activeColor: appMainColor,
                    value: status,
                    onChanged: (value) {
                    setState(() {
                    status = value;
                    });
                  },),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Product description",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 2),
                Text(
                  "Set a description on product to detail your product and better visibility.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, right: 20),
              child: TextField(
                  style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                  maxLines: null,
                  minLines: 5,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                      ),
                      labelText: 'Enter Product description',
                      labelStyle: mediumGreyTextStyle,
                  )),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget buildProduct1({required double size}) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 20,
              width: 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.grey.withOpacity(0.3)),

            ),
            const SizedBox(width: 5),
            Text(
              "Product Informations",
              style: TextStyle(
                  color: notifire.getbacktextcolors,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18),
            ),
          ]),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product name",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Do not exceed 20 characters when\nentering the product name.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 23, left: 50, right: 20),
                  child:  TextField(
                      style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                          ),
                          labelText: 'Enter product name',
                          labelStyle: mediumGreyTextStyle,
                      )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "SKU",
                    style: TextStyle(color: notifire.getbacktextcolors, fontWeight: FontWeight.w800, overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "SKU is a scannable barcode and is the\nunit of measure in which the stock of a\nproduct is managed",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 33, left: 47, right: 20),
                  child: TextField(
                      style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                          ),
                          labelText: 'Enter SKU',
                          labelStyle: mediumGreyTextStyle,
                      )),
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Price",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 33, left: 230, right: 20),
                  child: TextField(
                      style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                          ),
                          border: const OutlineInputBorder(),
                          hintText: '000',
                          hintStyle: mediumGreyTextStyle,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: notifire.getdolorcolors),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, top: 5),
                                child: Text("\$",
                                    style: TextStyle(color: notifire.getbacktextcolors, fontSize: 25, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ))),
                ),
              )
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Category",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please select your product category\nfrom the list provided.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 33, left: 45, right: 20),
                    child: DropdownButtonFormField2<String>(
                      style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                      isExpanded: true,
                      decoration: InputDecoration(
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // Add more decoration..
                      ),
                      hint: Text(
                        'Select Your Category',
                        maxLines: 1,
                        style: TextStyle(
                            color: notifire.getbacktextcolors,
                            fontSize: 14, overflow: TextOverflow.ellipsis),
                      ),
                      items: genderItems
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Category.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //Do something when selected item is changed.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: notifire.getbacktextcolors,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: notifire.getcontiner,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ))
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Gender",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Set the gender for this product.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 33, left: 74, right: 20),
                    child: DropdownButtonFormField2<String>(
                      style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                      isExpanded: true,
                      decoration: InputDecoration(
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // Add more decoration..
                      ),
                      hint: Text(
                        'Select Your Gender',
                        maxLines: 1,
                        style: TextStyle(
                            color: notifire.getbacktextcolors,
                            fontSize: 14, overflow: TextOverflow.ellipsis),
                      ),
                      items: genderItems1
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Gender.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //Do something when selected item is changed.
                      },
                      onSaved: (value) {
                        selectedValue1 = value.toString();
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: notifire.getbacktextcolors,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          color: notifire.getcontiner,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ))
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Photo Product",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Recommended minimum with\n1080pxX1080px.with a max size of\n5MB only*.png*.png.*.jpg.and*.jpeg\nimage files are accepted.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                          size: 30,color: notifire.getsubcolors,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 31),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                            size: 30, color: Colors.grey),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else if (constraints.maxWidth < 800) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                            size: 30, color: Colors.grey),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                            size: 30, color: Colors.grey),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                            size: 30, color: Colors.grey),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                          size: 30,color: notifire.getsubcolors,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                          size: 30,color: notifire.getsubcolors,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                          size: 30, color: notifire.getsubcolors,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30,left: 50),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: SizedBox(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                          size: 30, color: notifire.getsubcolors,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Container(
                                          height: 37,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              color: const Color(0xff5e59ff)),
                                          child: const Center(
                                              child: Text(
                                                "Add image",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "or Drop image to\n        Upload",
                                          style:
                                          TextStyle(color: notifire.getsubcolors,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Status",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Set a status for your product to\ndetermine whenther your product\nis displayed or not.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              const SizedBox(width: 35,),
              SizedBox(
                height: 50,
                width: 80,
                child: Switch(
                  activeColor: appMainColor,
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                  },),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Product description",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Set a description on product to detail\nyour product and better visibility.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 13, left: 42),
                  child: TextField(
                      minLines: 5,
                      maxLines: null,
                      style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                          ),
                          labelText: 'Enter Product description',
                          labelStyle: mediumGreyTextStyle
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50,),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 20,
              width: 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: notifire.getbacktextcolors),
            ),
            const SizedBox(width: 5),
            Text(
              "Discount",
              style: TextStyle(
                  color: notifire.getbacktextcolors,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18),
            )
          ]),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Discount type",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Set your discount type. you can\nchoose the type of discount\nwith a percent or cash discount.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 73),
                  child: DropdownButtonFormField2<String>(
                    style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                    isExpanded: true,
                    decoration: InputDecoration(
                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                      // the menu padding when button's width is not specified.
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // Add more decoration..
                    ),

                    hint: Text(
                      'Select type',
                      maxLines: 1,
                      style:
                      TextStyle(
                          color: notifire.getbacktextcolors,
                          fontSize: 14, overflow: TextOverflow.ellipsis),
                    ),
                    items: genderItems
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select type.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when selected item is changed.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: notifire.getbacktextcolors,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: notifire.getcontiner,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Set Discount",
                    style: TextStyle(
                        color: notifire.getbacktextcolors,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Please fill in how many discount\nyou will give for this products.",
                    style: TextStyle(
                        color: notifire.getsubcolors,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 13, left: 75),
                  child:  TextField(
                      style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                          ),
                          labelText: 'Enter nominal discount',
                          labelStyle: mediumGreyTextStyle,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
              mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              height: 20,
              width: 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: notifire.getbacktextcolors),
            ),
            const SizedBox(width: 5),
            Text(
              "Variant",
              style: TextStyle(
                  color: notifire.getbacktextcolors,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 18),
            ),
            const Spacer(),
            const Text(
              "Delete all variant",
              style: TextStyle(
                  color: Colors.red, overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 10),
            Container(
              width: 100,
              height: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xff5e59ff))),
              child:  Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon(Icons.add, color: Color(0xff5e59ff), size: 15),
                    SvgPicture.asset("assets/plus.svg",height: 18,width: 18,color:const Color(0xff5e59ff) ),
                    const SizedBox(width: 2),
                    const Text("Add variant", style: TextStyle(color: Color(0xff5e59ff), fontSize: 12),),
                  ],
                ),
              ),
            )
          ]),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 200,
              width: size+200,
              child: Row(
                children: [
                  Expanded(
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(50),
                        1: FixedColumnWidth(100),
                        2: FixedColumnWidth(100),
                        3: FixedColumnWidth(100),
                        4: FixedColumnWidth(100),
                        5: FixedColumnWidth(100),
                        6: FixedColumnWidth(100),
                        7: FixedColumnWidth(100),
                      },
                      children: [
                        TableRow(children: [
                          Checkbox(
                            activeColor: const Color(0xff5e59ff),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: notifire.getbacktextcolors)
                            ),
                            value: value,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = value!;
                              });
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "VARIANT IMAGE",
                              style: TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("COLOR NAME",
                                style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                            child: Text("SIZE",
                                style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                            child: Text("STOCK",
                                style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                            child: Text("SKU",
                                style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 50.0, right: 8.0, bottom: 8.0),
                            child: Text("STATUS",
                                style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                            child: Text("ACTION",
                                style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ),
                        ]),
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              activeColor: const Color(0xff5e59ff),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(color: notifire.getsubcolors)
                              ),
                              value: value1,
                              onChanged: (bool? value) {
                                setState(() {
                                  value1 = value!;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DottedBorder(
                              radius: const Radius.circular(30),
                              color: Colors.grey.withOpacity(0.3),
                              child: const SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Icon(Icons.file_upload_outlined,
                                            size: 20, color: Colors.grey),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Center(
                                            child: Text(
                                              "Add image",
                                              style: TextStyle(
                                                  color: Color(0xff5e59ff),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  TextField(
                                style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                                    ),
                                    labelText: 'Color name',
                                    labelStyle: mediumGreyTextStyle
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField2<String>(
                              style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                              isExpanded: true,
                              decoration: InputDecoration(
                                // Add Horizontal padding using menuItemStyleData.padding so it matches
                                // the menu padding when button's width is not specified.
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                // Add more decoration..
                              ),
                              hint: Text(
                                'Select ',
                                maxLines: 1,
                                style: TextStyle(
                                    color: notifire.getbacktextcolors,fontSize: 14, overflow: TextOverflow.ellipsis),
                              ),
                              items: SizeItems.map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              )).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select size.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                //Do something when selected item is changed.
                              },
                              onSaved: (value) {
                                selectedValue2 = value.toString();
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color:notifire.getbacktextcolors,
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  color: notifire.getcontiner,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  TextField(
                                style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                                    ),
                                    labelText: 'Enter Stock',
                                    labelStyle: mediumGreyTextStyle
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                                style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                                    ),
                                    labelText: 'Enter SKU',
                                    labelStyle: mediumGreyTextStyle
                                )),
                          ),
                          SizedBox(
                            height: 50,
                            width: 80,
                            child: Switch(
                              activeColor: appMainColor,
                              value: status,
                              onChanged: (value) {
                                setState(() {
                                  status = value;
                                });
                              },),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 20,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.red)),
                              child: Center(child: SvgPicture.asset("assets/trash.svg",height: 18,width: 18,color: Colors.red)),
                            ),
                          )
                        ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/seen.png",color: Colors.grey[500],width: 20,height: 20,),
              const SizedBox(width: 3),
              Text("last saved",style: TextStyle(
                  color: notifire.getsubcolors,overflow: TextOverflow.ellipsis
              ),),
              const SizedBox(width: 3),
              Text("Nov 9,2022-17.09",style: TextStyle(color: notifire.getbacktextcolors,),overflow: TextOverflow.ellipsis),
              const Spacer(),
              const Text("cancel",style: TextStyle(color: Color(0xff5e59ff),fontSize: 16,overflow: TextOverflow.ellipsis),),
              const SizedBox(width: 10),
              Container(
                height: 35,
                width: 125,
                decoration: const BoxDecoration(
                    color: Color(0xff5e59ff),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/download.svg",height: 18,width: 18,color: Colors.white),
                    const SizedBox(width: 8),
                    const Center(child: Text("Save Product",style: TextStyle(fontSize: 13,color: Colors.white,overflow: TextOverflow.ellipsis),))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
        ),
      ),
    );
  }

  Widget buildDiscount() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 20,
                width: 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.3)),
              ),
              const SizedBox(width: 5),
              Text(
                "Discount",
                style: TextStyle(
                    color: notifire.getbacktextcolors,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18),
              )
            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Discount type",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 5),
                Text(
                  "Set your discount type. you can choose the type of discount with a percent or cash discount.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 20),
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  // Add Horizontal padding using menuItemStyleData.padding so it matches
                  // the menu padding when button's width is not specified.
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // Add more decoration..
                ),
                hint: Text(
                  'Select type',
                  maxLines: 1,
                  style:
                  mediumGreyTextStyle,
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select type.';
                  }
                  return null;
                },
                onChanged: (value) {
                  //Do something when selected item is changed.
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: notifire.getbacktextcolors,
                  ),
                  iconSize: 24,
                ),
                style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: notifire.getcontiner,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Set Discount",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 2),
                Text(
                  "Please fill in how many discount you will give for this products.",
                  style: TextStyle(
                      color: notifire.getsubcolors,
                      fontSize: 13,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13, right: 20),
              child: TextField(
                  style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                      ),
                      labelText: 'Enter nominal discount',
                      labelStyle: mediumGreyTextStyle,
                  )),
            ),
            // const SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  Widget buildVariat() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  height: 20,
                  width: 7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: notifire.getbacktextcolors),
                ),
                const SizedBox(width: 5),
                Text(
                  "Variant",
                  style: TextStyle(
                      color: notifire.getbacktextcolors,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18),
                ),
               const SizedBox(width: 500,),
                const Padding(
                  padding: EdgeInsets.only(left: 0, right: 8, top: 8),
                  child: Text(
                    "Delete all variant",
                    style: TextStyle(
                        color: Colors.red, overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  width: 94,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xff5e59ff))),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(Icons.add, color: Color(0xff5e59ff), size: 12),
                        SizedBox(width: 2),
                        Text(
                          "Add variant",
                          style:
                          TextStyle(color: Color(0xff5e59ff), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 15,),
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(100),
                  1: FixedColumnWidth(100),
                  2: FixedColumnWidth(100),
                  3: FixedColumnWidth(100),
                  4: FixedColumnWidth(100),
                  5: FixedColumnWidth(100),
                  6: FixedColumnWidth(100),
                  7: FixedColumnWidth(100),
                },
                children: [
                  TableRow(children: [
                    Checkbox(
                      activeColor: const Color(0xff5e59ff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: notifire.getsubcolors)
                      ),
                      value: value,
                      onChanged: (bool? value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "VARIANT IMAGE",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("COLOR NAME",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                      child: Text("SIZE",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                      child: Text("STOCK",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                      child: Text("SKU",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                      child: Text("STATUS",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, left: 18.0, right: 8.0, bottom: 8.0),
                      child: Text("ACTION",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Checkbox(
                        activeColor: const Color(0xff5e59ff),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: notifire.getsubcolors)
                        ),
                        value: value1,
                        onChanged: (bool? value) {
                          setState(() {
                            value1 = value!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DottedBorder(
                        radius: const Radius.circular(30),
                        color: Colors.grey.withOpacity(0.3),
                        child: const SizedBox(
                          height: 60,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 7),
                                  child: Icon(Icons.file_upload_outlined,
                                      size: 20, color: Colors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Add image",
                                        style: TextStyle(
                                            color: Color(0xff5e59ff),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  TextField(
                          style: mediumBlackTextStyle.copyWith(color: notifire.getMainText,),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                              ),
                              labelText: 'Color name',
                              labelStyle: mediumGreyTextStyle
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        style: mediumBlackTextStyle.copyWith(color: notifire.getTextColor1),
                        decoration: InputDecoration(
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          // Add more decoration..
                        ),
                        hint: Text(
                          'Select ',
                          maxLines: 1,
                          style: mediumGreyTextStyle,
                        ),
                        items: SizeItems.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14,),
                          ),
                        )).toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select size.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          //Do something when selected item is changed.
                        },
                        onSaved: (value) {
                          selectedValue2 = value.toString();
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: appGreyColor,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: notifire.getcontiner,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                              ),
                              labelText: 'Enter Stock',
                              labelStyle: mediumGreyTextStyle
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          style: mediumBlackTextStyle.copyWith(color: notifire.getMainText),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3),)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                              ),
                              labelText: 'Enter SKU',
                              labelStyle: mediumGreyTextStyle
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      width: 80,
                      child: Switch(
                        activeColor: appMainColor,
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                          });
                        },),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 20,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.red)),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildSave(){
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/seen.png",color: Colors.grey[500],width: 20,height: 20,),
          const SizedBox(width: 3),
          Flexible(
            child: Text("last saved",style: TextStyle(
                color: notifire.getsubcolors,overflow: TextOverflow.ellipsis
            ),),
          ),
          const SizedBox(width: 3),
          Text("Nov 9,2022-17.09",style:TextStyle(color: notifire.getbacktextcolors,),overflow: TextOverflow.ellipsis),
          const Spacer(),
          const Flexible(child: Text("cancel",style: TextStyle(color: Color(0xff5e59ff),fontSize: 16,overflow: TextOverflow.ellipsis),)),
          const SizedBox(width: 10),
          Container(
            height: 35,
            width: 125,
            decoration: const BoxDecoration(
                color: Color(0xff5e59ff),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_outlined,color: Colors.white,size: 20),
                SizedBox(width: 8),
                Center(child: Text("Save Product",style: TextStyle(fontSize: 13,color: Colors.white,overflow: TextOverflow.ellipsis),))
              ],
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
