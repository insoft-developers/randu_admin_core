import 'package:buzz/calender.dart';
import 'package:buzz/demo/toastification.dart';
import 'package:buzz/forms_table/data_table.dart';
import 'package:buzz/manajemen_produk/category/index.dart';
import 'package:buzz/manajemen_produk/product_list/index.dart';
import 'package:buzz/newpages/file_manager_page.dart';
import 'package:buzz/newpages/maps_page.dart';
import 'package:buzz/newpages/tabs_pills.dart';
import 'package:buzz/projectlistpage.dart';
import 'package:get/get.dart';

import 'Buttons/default_style.dart';
import 'Buttons/edge_style.dart';
import 'Buttons/flat_style.dart';
import 'Buttons/raised_style.dart';
import 'FAQ/faq.dart';
import 'Ui_kits/avatars.dart';
import 'Ui_kits/modal.dart';
import 'Users/users_cards.dart';
import 'Users/users_edit.dart';
import 'chartpage.dart';
import 'chat/chatscreenpages/messages.dart';
import 'ecommerce_pages/cart1.dart';
import 'ecommerce_pages/checkout.dart';
import 'ecommerce_pages/invoice.dart';
import 'ecommerce_pages/pricing.dart';
import 'ecommerce_pages/product_detils_page.dart';
import 'ecommerce_pages/product_page.dart';
import 'ecommercepage.dart';
import 'forms_table/basic_tables.dart';
import 'forms_table/datepicker.dart';
import 'forms_table/validation_form.dart';
import 'generalpage.dart';
import 'login_signup/complete_verificaton_process.dart';
import 'login_signup/email_verification.dart';
import 'login_signup/forgot_password.dart';
import 'login_signup/singup.dart';
import 'newpages/newaddtoproject.dart';
import 'newpages/newcheckboxpage.dart';
import 'newpages/newdefault_page.dart';
import 'newpages/newuserprofile.dart';

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
    const NewDefaultPage(),
    const EcommercePage(),
    const GeneralPage(),
    const ProductCategory(),
    const ProductList(),
    const NewAddProjectPage(),
    // const CreateNewPage(), //
    // const OldProductPage(),//

    const Messages(),
    // const ChatPage(),//
    const NewUserProfile(),
    // const UsersProfilePage(),//
    const UsersEditPage(),
    const UsersCardsPage(),
    const ValiDationFormPage(),
    const NewCheckboxRadioPage(),
    // const CheckboxRadioPage(),//
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
