// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks

import 'package:buzz/provider/proviercolors.dart';
import 'package:buzz/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'appstaticdata/staticdata.dart';
import 'login_signup/complete_verificaton_process.dart';
import 'login_signup/email_verification.dart';
import 'login_signup/forgot_password.dart';
import 'login_signup/singup.dart';

class DarwerCode extends StatefulWidget {
  const DarwerCode({super.key});

  @override
  State<DarwerCode> createState() => _DarwerCodeState();
}

class _DarwerCodeState extends State<DarwerCode> {
  AppConst obj = AppConst();
  final AppConst controller = Get.put(AppConst());

  final screenwidth = Get.width;
  bool ispresent = false;

  static const breakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    if (screenwidth >= breakpoint) {
      setState(() {
        ispresent = true;
      });
    }

    return GetBuilder<AppConst>(builder: (controller) {
      return SafeArea(
        child: Consumer<ColorNotifire>(
          builder: (context, value, child) => Drawer(
            backgroundColor: notifire!.getprimerycolor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: notifire!.getbordercolor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ispresent ? 30 : 15,
                      top: ispresent ? 24 : 20,
                      bottom: ispresent ? 10 : 12),
                  child: InkWell(
                    onTap: () {
                      controller.changePage(0);
                      Get.back();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/applogo.svg",
                          height: 48,
                          width: 48,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset("assets/Buzz..svg",
                            height: 25,
                            width: 32,
                            color: notifire!.getTextColor1),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDivider(title: 'MENU UTAMA'),
                            SizedBox(
                              height: ispresent ? 10 : 8,
                            ),
                            _buildSingletile(
                                header: "Dashboards",
                                iconpath: "assets/home.svg",
                                index: 0,
                                ontap: () {
                                  controller.changePage(0);
                                  Get.back();
                                }),
                            _buildexpansiontilt(
                                index: 1,
                                children: Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: ispresent ? 12 : 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(4);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 4),
                                                _buildcomuntext(
                                                    title: 'Daftar Produk',
                                                    index: 4),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title: 'Daftar Kategori',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                      ],
                                    ),
                                  ],
                                ),
                                header: 'Manajemen Produk',
                                iconpath: 'assets/box.svg'),
                            _buildexpansiontilt(
                                index: 1,
                                children: Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: ispresent ? 12 : 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(4);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 4),
                                                _buildcomuntext(
                                                    title: 'Daftar Bahan Baku',
                                                    index: 4),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Daftar Barang Setengah Jadi',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                      ],
                                    ),
                                  ],
                                ),
                                header: 'COGS Manufaktur',
                                iconpath: 'assets/truck.svg'),
                            _buildexpansiontilt(
                                index: 1,
                                children: Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: ispresent ? 12 : 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(4);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 4),
                                                _buildcomuntext(
                                                    title:
                                                        'Transaksi Beli Produk',
                                                    index: 4),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Transaksi Buat Produk',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Transaksi Barang Setengah Jadi',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Transaksi Bahan Baku',
                                                    index: 5),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                header: 'Pembelian & Produksi',
                                iconpath: 'assets/shopping-basket.svg'),
                            _buildexpansiontilt(
                                index: 1,
                                children: Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: ispresent ? 12 : 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(4);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 4),
                                                _buildcomuntext(
                                                    title: 'Daftar Penyesuaian',
                                                    index: 4),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Penyesuaian Barang Dagang',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Penyesuaian Barang Setengah Jadi',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Penyesuaian Bahan Baku',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Kategori Penyesuaian',
                                                    index: 5),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                header: 'Penyesuaian',
                                iconpath: 'assets/sliders-horizontal-alt.svg'),
                            _buildexpansiontilt(
                                index: 1,
                                children: Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: ispresent ? 12 : 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(4);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 4),
                                                _buildcomuntext(
                                                    title: 'Daftar Pengeluaran',
                                                    index: 4),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Kategori Pengeluaran',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                      ],
                                    ),
                                  ],
                                ),
                                header: 'Biaya (Expenses)',
                                iconpath: 'assets/badge-discount.svg'),
                            _buildexpansiontilt(
                                index: 1,
                                children: Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: ispresent ? 12 : 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(4);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 4),
                                                _buildcomuntext(
                                                    title:
                                                        'Pengaturan Perusahaan',
                                                    index: 4),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Pengaturan Kas Kecil',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Pengaturan Pembayaran',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                        InkWell(
                                            onTap: () {
                                              controller.changePage(5);
                                              Get.back();
                                            },
                                            child: Row(
                                              children: [
                                                _buildcomunDesh(index: 5),
                                                _buildcomuntext(
                                                    title:
                                                        'Pengaturan Printer Kasir',
                                                    index: 5),
                                              ],
                                            )),
                                        _buildsizeboxwithheight(),
                                      ],
                                    ),
                                  ],
                                ),
                                header: 'Pengaturan Aplikasi',
                                iconpath: 'assets/settings.svg'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildsizeboxwithheight() {
    return SizedBox(
      height: ispresent ? 25 : 20,
    );
  }

  Widget _buildcomuntext({required String title, required int index}) {
    return Obx(
      () => SizedBox(
        width: MediaQuery.of(context).size.width - 173,
        child: Text(title,
            style: mediumGreyTextStyle.copyWith(
                fontSize: 13,
                color: controller.pageselecter.value == index
                    ? appMainColor
                    : notifire!.getMainText)),
      ),
    );
  }

  Widget _buildcomunDesh({required int index}) {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/minus.svg",
              color: controller.pageselecter.value == index
                  ? appMainColor
                  : notifire!.getMainText,
              width: 6),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildexpansiontilt(
      {required Widget children,
      required String header,
      required String iconpath,
      required int index}) {
    return ListTileTheme(
      horizontalTitleGap: 12.0,
      dense: true,
      child: ExpansionTile(
        title: Text(
          header,
          style: mediumBlackTextStyle.copyWith(
              fontSize: 14, color: notifire!.getMainText),
        ),
        leading: SvgPicture.asset(iconpath,
            height: 18, width: 18, color: notifire!.getMainText),
        tilePadding:
            EdgeInsets.symmetric(vertical: ispresent ? 5 : 2, horizontal: 8),
        iconColor: appMainColor,
        collapsedIconColor: Colors.grey,
        children: <Widget>[children],
      ),
    );
  }

  Widget _buildSingletile(
      {required String header,
      required String iconpath,
      required int index,
      required void Function() ontap}) {
    return Obx(() => ListTileTheme(
          horizontalTitleGap: 12.0,
          dense: true,
          child: ListTile(
            hoverColor: Colors.transparent,
            onTap: ontap,
            title: Text(
              header,
              style: mediumBlackTextStyle.copyWith(
                  fontSize: 14,
                  color: controller.pageselecter.value == index
                      ? appMainColor
                      : notifire!.getMainText),
            ),
            leading: SvgPicture.asset(iconpath,
                height: 18,
                width: 18,
                color: controller.pageselecter.value == index
                    ? appMainColor
                    : notifire!.getMainText),
            trailing: const SizedBox(),
            contentPadding: EdgeInsets.symmetric(
                vertical: ispresent ? 5 : 2, horizontal: 8),
          ),
        ));
  }

  Widget _buildDivider({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: ispresent ? 15 : 10,
            width: ispresent ? 230 : 260,
            child: Center(
                child: Divider(color: notifire!.getbordercolor, height: 1))),
        SizedBox(
          height: ispresent ? 15 : 10,
        ),
        Text(
          title,
          style: mainTextStyle.copyWith(
              fontSize: 14, color: notifire!.getMainText),
        ),
        SizedBox(
          height: ispresent ? 10 : 8,
        ),
      ],
    );
  }
}

//9c9caa
