import 'package:buzz/adjustment/add/index.dart';
import 'package:buzz/adjustment/add_inter/index.dart';
import 'package:buzz/adjustment/add_material/index.dart';
import 'package:buzz/adjustment/category/index.dart';
import 'package:buzz/adjustment/index.dart';
import 'package:buzz/cogs_manufactur/barang_setengah_jadi/index.dart';
import 'package:buzz/expenses/category/index.dart';
import 'package:buzz/expenses/expense/index.dart';
import 'package:buzz/manajemen_produk/category/index.dart';
import 'package:buzz/manajemen_produk/product_list/index.dart';
import 'package:buzz/cogs_manufactur/bahan_baku/index.dart';
import 'package:buzz/pembelian/beli_produk_jadi/index.dart';
import 'package:buzz/pembelian/inter_purchase/index.dart';
import 'package:buzz/pembelian/manufacture/index.dart';
import 'package:buzz/pembelian/material_purchase/index.dart';
import 'package:buzz/pengaturan/company_setting/index.dart';
import 'package:buzz/pengaturan/kas_kecil/index.dart';
import 'package:buzz/pengaturan/payment_setting/index.dart';
import 'package:get/get.dart';

import 'Users/users_cards.dart';
import 'Users/users_edit.dart';
import 'ecommercepage.dart';
import 'forms_table/validation_form.dart';
import 'generalpage.dart';
import 'newpages/newcheckboxpage.dart';
import 'newpages/newdefault_page.dart';

class AppConst extends GetxController implements GetxService {
  bool showDrawer = true;

  updateshowDrawer() {
    showDrawer = !showDrawer;
    update();
  }

  RxInt pageselecter = 0.obs;

  RxInt selectColor = 0.obs;
  RxInt selectedTile = 0.obs;

  RxInt gridcounter = 4.obs;

  RxInt newGridCounter = 4.obs;

  RxDouble size = 550.0.obs;

  RxDouble size2 = 350.0.obs;

  int selectCategory = 0;

  int gridecoumter1 = 4;
  int grideCount = 4;

  grideupdate(int value) {
    gridecoumter1 = value;
  }

  grideupdate1(int value) {
    gridecoumter1 = value;
    update();
  }

  changeCurrentIndex({int? index}) {
    selectCategory = index ?? 0;
    update();
  }

  //Switch
  RxBool switchistrue = false.obs;

  var page = [
    const ProductList(),
    const EcommercePage(),
    const GeneralPage(),
    const ProductCategory(),
    const ProductList(),
    const BahanBaku(),
    const InterProduct(),
    const BeliProduk(),
    const ProductManufacture(),
    const InterPurchase(),
    const MaterialPurchase(),
    const Adjustment(),
    const AdjustmentAdd(),
    const AdjustmentAddInterProduct(),
    const AdjustmentAddMaterial(),
    const AdjustmentCategory(),
    const ExpenseCategory(),
    const Expense(),
    const CompanySetting(),
    const KasKecil(),
    const PaymentSetting()
  ].obs;

  void changePage(int newIndex) {
    pageselecter.value = newIndex;
  }

  List prodectname = [
    "Woman T-shirt",
    "Dream Beauty Fashion",
    "VOXATI",
    "Woman T-shirt",
    "Dream Beauty Fashion",
    "VOXATI",
    "Cyclamen",
    "Woman T-shirt",
    "Dream Beauty Fashion",
    "VOXATI",
    "Cyclamen",
    "Woman T-shirt",
    "Dream Beauty Fashion",
    "Cyclamen",
    "VOXATI",
    "Cyclamen",
  ];

  List prodectdiscription = [
    "Women Full Sleeve Printed Sweatshirt",
    "Tops for Women Stylish",
    "Denim Jacket",
    "Women Full Sleeve Printed Sweatshirt",
    "Tops for Women Stylish",
    "Denim Jacket",
    "Stylish co-ord set 2 piece dress for women",
    "Women Full Sleeve Printed Sweatshirt",
    "Tops for Women Stylish",
    "Women Full Sleeve Printed Sweatshirt",
    "Denim Jacket",
    "Stylish co-ord set 2 piece dress for women",
    "Denim Jacket",
    "Stylish co-ord set 2 piece dress for women",
  ];

  List prodectprice = [
    "\$26.00",
    "\$56.00",
    "\$56.00",
    "\$16.00",
    "\$26.00",
    "\$23.00",
    "\$22.00",
    "\$16.00",
    "\$25.00",
    "\$36.00",
    "\$26.00",
    "\$95.00",
    "\$36.00",
    "\$76.00",
    "\$46.00",
    "\$27.00",
    "\$24.00",
    "\$13.00",
  ];

  List productimage = [
    "assets/full-length-portrait-happy-excited-girl-bright-colorful-clothes-holding-shopping-bags-while-standing-showing-peace-gesture-isolated.jpg",
    "assets/cheerful-shopaholic-paying-by-mobile-app.jpg",
    "assets/portrait-payment-white-happy-consumer.jpg",
    "assets/portrait-expressive-young-woman-holding-shopping-bags.jpg",
    "assets/cheerful-shopaholic-paying-by-mobile-app.jpg",
    "assets/full-length-portrait-happy-excited-girl-bright-colorful-clothes-holding-shopping-bags-while-standing-showing-peace-gesture-isolated.jpg",
    "assets/cheerful-shopaholic-paying-by-mobile-app.jpg",
    "assets/portrait-payment-white-happy-consumer.jpg",
    "assets/portrait-expressive-young-woman-holding-shopping-bags.jpg",
    "assets/cheerful-shopaholic-paying-by-mobile-app.jpg",
    "assets/full-length-portrait-happy-excited-girl-bright-colorful-clothes-holding-shopping-bags-while-standing-showing-peace-gesture-isolated.jpg",
    "assets/cheerful-shopaholic-paying-by-mobile-app.jpg",
    "assets/portrait-payment-white-happy-consumer.jpg",
    "assets/portrait-expressive-young-woman-holding-shopping-bags.jpg",
    "assets/cheerful-shopaholic-paying-by-mobile-app.jpg",
    "assets/portrait-payment-white-happy-consumer.jpg",
    "assets/portrait-expressive-young-woman-holding-shopping-bags.jpg",
    "assets/cheerful-shopaholic-paying-by-mobile-app.jpg",
  ];
}
