import 'package:buzz/pengaturan/company_setting/company_setting_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Select2 extends StatelessWidget {
  List<String> items;
  String code;
  String selectedItem;
  Select2(
      {super.key,
      required this.items,
      required this.code,
      required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 2.0),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownSearch<String>(
        items: items,
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(fontSize: 16),
            dropdownSearchDecoration: InputDecoration(
              border: InputBorder.none,
            )),
        onChanged: (value) {
          if (code == 'province') {
            final CompanySettingController _controller =
                Get.put(CompanySettingController());
            int indexSelected =
                _controller.provinceDropdown.indexOf(value.toString());
            Map<String, dynamic> _selected =
                _controller.provinceList[indexSelected];
            _controller.selectedProvinceName.value =
                _selected['province_name'].toString();
            _controller.selectedProvince.value =
                _selected['province_id'].toString();
            _controller.getCityData(_selected['province_id'].toString());
          }

          if (code == 'city') {
            final CompanySettingController _controller =
                Get.put(CompanySettingController());
            int indexSelected =
                _controller.cityDropdown.indexOf(value.toString());
            Map<String, dynamic> _selected =
                _controller.cityList[indexSelected];
            _controller.selectedCityName.value =
                _selected['city_name'].toString();
            _controller.selectedCity.value = _selected['city_id'].toString();
            _controller.getDistrictData(_selected['city_id'].toString());
          }

          if (code == 'district') {
            final CompanySettingController _controller =
                Get.put(CompanySettingController());
            int indexSelected =
                _controller.districtDropdown.indexOf(value.toString());
            Map<String, dynamic> _selected =
                _controller.districtList[indexSelected];
            _controller.selectedDistrictName.value =
                _selected['subdistrict_name'].toString();
            _controller.selectedDistrict.value =
                _selected['subdistrict_id'].toString();
          }
        },
        selectedItem: selectedItem,
      ),
    );
  }
}
