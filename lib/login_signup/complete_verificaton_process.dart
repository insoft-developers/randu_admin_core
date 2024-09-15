// ignore_for_file: deprecated_member_use


import 'package:buzz/login_signup/singup.dart';
import 'package:buzz/provider/proviercolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../appstaticdata/staticdata.dart';
import 'email_verification.dart';



class CompleteVerification extends StatefulWidget {
  const CompleteVerification({super.key});

  @override
  State<CompleteVerification> createState() => _CompleteVerificationState();
}

class _CompleteVerificationState extends State<CompleteVerification> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ColorNotifire>(
          builder: (context, value, child) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: notifire!.getprimerycolor,
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth < 600) {
                    // Mobile layout
                    return Container(
                      color: notifire!.getbgcolor,
                      height: 900,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildverification(width: constraints.maxWidth)
                          ],
                        ),
                      ),
                    );
                  } else if (constraints.maxWidth < 1200) {
                    return  Container(
                      color: constraints.maxWidth<860?notifire!.getbgcolor:notifire!.getprimerycolor,
                      height: 1000,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            constraints.maxWidth<860?Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 80),
                              child: _buildverification(width: constraints.maxWidth),
                            ): Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28,vertical: 80),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 782,
                                        decoration:  BoxDecoration(
                                          color: notifire!.getbgcolor,
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(37)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child:_buildverification(width: constraints.maxWidth),
                                            ),
                                            Expanded(
                                              child: buildqrcode(),

                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    // Website layout
                    return SizedBox(
                      height: 1000,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80,vertical: 80),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 782,
                                        decoration:  BoxDecoration(
                                          color: notifire!.getbgcolor,
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(37)),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child:_buildverification(width: constraints.maxWidth),
                                            ),
                                            Expanded(
                                              child: buildqrcode(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildverification({required double width}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: Container(
          height: 734,
          decoration:  BoxDecoration(
            color: notifire!.getprimerycolor,
            borderRadius: const BorderRadius.all(Radius.circular(37)),
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: width<600?20:50.0,vertical:50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(
                  height: 110,
                  child: TabBarView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let’s Confrim it’s you!",
                          style: mainTextStyle.copyWith(overflow: TextOverflow.ellipsis,color: notifire!.getMainText),
                          maxLines: 2,
                        ),
                        Text('Complete verificaton process',
                            style: mediumGreyTextStyle.copyWith(fontSize: 16),
                            maxLines: 2),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Let’s Confrim it’s you!",
                            style: mainTextStyle.copyWith(overflow: TextOverflow.ellipsis,color: notifire!.getMainText),
                            maxLines: 2),
                        const SizedBox(height: 3,),
                        Text('Complete verificaton process',
                            style: mediumGreyTextStyle.copyWith(fontSize: 16),
                            maxLines: 2),
                      ],
                    )
                  ]),
                ),
                 Text('select  confirming method:',style: mediumBlackTextStyle.copyWith(fontSize: 16,color: notifire!.getMainText)),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: 180,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: notifire!.getbgcolor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xff0059E7),
                      ),
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: notifire!.getMainText,
                      tabs: const [
                        Text('System'),
                        Text('Google',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                      ]),
                ),
                const SizedBox(
                  height: 26.8,
                ),
                Flexible(
                  child: TabBarView(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 79,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: notifire!.isDark?   notifire!.geticoncolor  :Colors.grey.shade200)
                              ),
                              child:  Center(
                                child: ListTile(
                                  leading: Transform.scale(
                                    scale: 1.2,
                                  child: Radio<SingingCharacter>(
                                    activeColor: appMainColor,
                                    materialTapTargetSize: MaterialTapTargetSize.padded,
                                    value: SingingCharacter.sms,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                  ),
                                  title:  Text("Get the code by email at :",style: mediumBlackTextStyle.copyWith(color: notifire!.getMainText)),
                                  subtitle:  Text("Er*****de@gmail.com", style: mediumGreyTextStyle),
                                ),
                              ),
                            ),

                            const SizedBox(height: 21,),

                            Container(
                              height: 79,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.grey.shade300)
                              ),
                              child:  Center(
                                child: ListTile(
                                  leading:    Transform.scale(
                                    scale: 1.2,
                                    child: Radio<SingingCharacter>(
                                      activeColor: appMainColor,
                                      materialTapTargetSize: MaterialTapTargetSize.padded,
                                      value: SingingCharacter.email,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),


                                  title:  Text("Get The code by  (SMS) at :",style:mediumBlackTextStyle.copyWith(color: notifire!.getMainText)),
                                  subtitle:  Text("+1 202 ****0151",style: mediumGreyTextStyle),
                                ),
                              ),
                            ),


                            const SizedBox(
                              height: 55,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(const EmailVerification());
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24)),
                                    backgroundColor: appMainColor,


                                    elevation: 0,
                                    fixedSize: const Size.fromHeight(60)),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        child: SizedBox(
                                          width: 10,
                                        )),
                                     Text(
                                      "Continue",
                                      style: mediumGreyTextStyle.copyWith(color: Colors.white),
                                    ),
                                    const Expanded(
                                        child: SizedBox(
                                          width: 10,
                                        )),
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Center(
                                          child: SvgPicture.asset(
                                            "assets/arrow-right-small.svg",
                                            width: 12,
                                            height: 12,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                )),

                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 79,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.grey.shade300)
                              ),
                              child:  Center(
                                child: ListTile(
                                  leading:    Transform.scale(
                                    scale: 1.2,
                                    child: Radio<SingingCharacter>(
                                      activeColor: appMainColor,

                                      materialTapTargetSize: MaterialTapTargetSize.padded,
                                      value: SingingCharacter.email,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),


                                  title:  Text("Get the code by email at :",style: mediumBlackTextStyle.copyWith(color: notifire!.getMainText)),
                                  subtitle:  Text("Er*****de@gmail.com",style: mediumGreyTextStyle,),
                                ),
                              ),
                            ),

                            const SizedBox(height: 21,),

                            Container(
                              height: 79,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.grey.shade300)
                              ),
                              child:  Center(
                                child: ListTile(
                                  leading:    Transform.scale(
                                    scale: 1.2,
                                    child: Radio<SingingCharacter>(
                                      activeColor: appMainColor,

                                      materialTapTargetSize: MaterialTapTargetSize.padded,
                                      value: SingingCharacter.sms,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),


                                  title:  Text("Get The code by  (SMS) at :",style: mediumBlackTextStyle.copyWith(color: notifire!.getMainText)),
                                  subtitle:  Text("+1 202 ****0151",style: mediumGreyTextStyle),
                                ),
                              ),
                            ),


                            const SizedBox(
                              height: 55,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(const EmailVerification());
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24)),
                                    backgroundColor: appMainColor,
                                    elevation: 0,
                                    fixedSize: const Size.fromHeight(60)),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        child: SizedBox(
                                          width: 10,
                                        )),
                                     Text(
                                      "Continue",
                                      style: mediumGreyTextStyle.copyWith(color: Colors.white),
                                    ),
                                    const Expanded(
                                        child: SizedBox(
                                          width: 10,
                                        )),
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Center(
                                          child: SvgPicture.asset(
                                            "assets/arrow-right-small.svg",
                                            width: 12,
                                            height: 12,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ]
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
enum SingingCharacter { sms , email }

SingingCharacter? _character = SingingCharacter.sms;