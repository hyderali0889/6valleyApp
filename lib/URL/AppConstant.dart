import 'package:flutter/material.dart';
import 'package:geniouscart/Language/AppLocalizations.dart';
import 'package:geniouscart/Language/EN.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main.dart';

class AppConstant {
  static String AppName = 'geniouscart';
  static String font_poppins = "Poppins";
  static String currencySymbol = "\$";
  static String Share_Auth = 'auth';
  static String Share_User = 'user';
  static String Share_Product = 'product';
  static String Share_Currency = 'currency';
  static String Error = 'error';
  static String Asset_Image = 'asset_image';
  static String File_Image = 'file_image';
  static String Android = 'ANDROID';
  static String iOS = 'IOS';
  static String Default_Language = 'en';
  static String Default_Phone_Code = '+880';
  static String fcm_default_channel = 'fcm_default_channel';
  static AppLocale Default_Locale = AppLocale.EN;
  static Function Default_Language_Function = EN();

  static int AnimationDelay = 375;
  static int ProductMaxImageUpload = 5;

  static String heroTagUpcomingRequest = 'Upcomming';
  static String heroTagAddProduct = 'Add Product';
  static var swipeIndicator = WaterDropMaterialHeader(
    backgroundColor: Themes.Primary,
  );
  static var tabSwipeIndicator = WaterDropHeader(
    waterDropColor: Themes.Primary,
    complete: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.done,
          color: Colors.grey,
        ),
        Container(
          width: 15.0,
        ),
        Text(
          language.Complete,
          style: TextStyle(color: Colors.grey),
        )
      ],
    ),
  );

  static var Bearer = 'Bearer';
  static String id = 'id';
  static String store_id = 'store_id';
  static String Email = 'email';
  static String password = 'password';
  static String password_confirmation = 'password_confirmation';
  static String device_type = 'device_type';
  static String salt_key = 'salt_key';
  static String title = 'title';
  static String details = 'details';
  static String Unauthorized = 'Unauthenticated.';
  static String message = 'message';
  static String subject = 'subject';
  static String responseData = 'responseData';
  static String addon_name = 'addon_name';
  static String addon_status = 'addon_status';
  static String active = 'active';
  static List<int> Category_Status_value = [1, 0];
  static List<int> Product_Status_value = [1, 0];
  static List<String> All_Discount_Type_Value = ['PERCENTAGE', 'AMOUNT'];
  static String The_given_data_was_invalid = 'The given data was invalid.';
  static String OK = "OK";
  static var store_category_name = 'store_category_name';
  static var store_category_description = 'store_category_description';
  static var store_category_status = 'store_category_status';
  static var user = 'user';
  static var store_category_id = 'store_category_id';
  static var item_description = 'item_description';
  static var item_discount_type = 'item_discount_type';
  static var item_discount = 'item_discount';
  static var item_stock = 'item_stock';
  static var item_name = 'item_name';
  static var item_price = 'item_price';
  static var picture = 'picture';
  static var addon = 'addon';
  static var addon_price = 'addon_price';
  static List<String> Product_veg_type_value = ['Pure Veg', 'Non Veg'];
  static List<String> Week_value = [
    'SAT',
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI'
  ];
  static String Day_ALL = 'ALL';
  static var store_order_id = 'store_order_id';
  static var delivery_date = 'delivery_date';
  static var user_id = 'user_id';

  static String Language = 'language';

  static String cooking_time = 'cooking_time';

  static String device_token = 'device_token';

  static String contact_number = 'contact_number';

  static String counrty_code = 'country_code';

  static String country_code = 'country_code';

  static String email = 'email';
  static String store_name = 'store_name';
  static String store_type_id = 'store_type_id';
  static String is_veg = 'is_veg';
  static String estimated_delivery_time = 'estimated_delivery_time';
  static String store_location = 'store_location';
  static String latitude = 'latitude';
  static String longitude = 'longitude';
  static String store_zipcode = 'store_zipcode';
  static String contact_person = 'contact_person';
  static String store_packing_charges = 'store_packing_charges';
  static String store_gst = 'store_gst';
  static String offer_min_amount = 'offer_min_amount';
  static String offer_percent = 'offer_percent';
  static String description = 'description';
  static String country_id = 'country_id';
  static String city_id = 'city_id';
  static String commission = 'commission';
  static String zone_id = 'zone_id';
  static String free_delivery = 'free_delivery';
  static String cuisine_id = 'cuisine_id';

  ///this is array
  static String day = 'day';

  ///this is array
  static String hours_opening = 'hours_opening';

  ///this is array
  static String hours_closing = 'hours_closing';

  ///this is array

  static String PM = 'PM';
  static String AM = 'AM';

  static String Unprocessable_Entity = 'Unprocessable Entity';

  static String status = 'status';

  static String add = 'add';
  static String highlight = 'highlight';
  static String type = 'type';
  static String product_type_License = 'License';
  static String featuredHighlight = 'featured';
  static String bestHighlight = 'best';
  static String topHighlight = 'top';
  static String bigHighlight = 'big';
  static String isDiscountHighlight = 'is_discount';
  static String hotHighlight = 'hot';
  static String latestHighlight = 'latest';
  static String trendingHighlight = 'trending';
  static String saleHighlight = 'sale';
  static String PhysicalType = 'Physical';
  static String DigitalType = 'Digital';
  static String LicenseType = 'License';
  static String normalProductType = 'normal';
  static String affiliateProductType = 'affiliate';
  static String BannerTypeTopSmall = 'TopSmall';
  static String BannerTypeBottomSmall = 'BottomSmall';
  static String BannerTypeLarge = 'Large';
  static String product_id = 'product_id';

  static String New = 'New';

  static String phone = 'phone';
  static String address = 'address';
  static String fullname = 'fullname';

  static String data = 'data';

  static String paginate = 'paginate';

  static String name = 'name';

  static String HeroTag = 'HeroTag';

  static String max = 'max';
  static String min = 'min';
  static String sort = 'sort';
  static List<String> sortList = [
    'date_desc',
    'date_asc',
    'price_desc',
    'price_asc'
  ];
  static List<String> Product_Condition = ['New', 'Used'];
  static String term = 'term';

  static String HeroTagSearch = 'Hero Search';

  static String rating = 'rating';
  static String comment = 'comment';
  static String comment_id = 'comment_id';

  static String reply = 'reply';

  static var access_token = 'access_token';

  static String fax = 'fax';

  static String city = 'city';

  static String country = 'country';
  static String zip = 'zip';
  static String photo = 'photo';

  static String current_password = 'current_password';
  static String new_password = 'new_password';
  static String renew_password = 'renew_password';

  static String vendor_id = 'vendor_id';
  static List<String> Create_Product_Type_Value = [
    'Physical',
    'Digital',
    'License'
  ];

  static String subtitle = 'subtitle';
  static String price = 'price';
  static String value = 'value';

  static String Pending = 'Pending';

  static String Success = 'Success';

  static String Type_Vendor = 'Vendor';

  static String Type_User = 'User';

  static String success = 'success';
  static String category_id = 'category_id';
  static String sku = 'sku';
  static String product_type = 'product_type';

  static String conversation_id = 'conversation_id';

  static String sent_user = 'sent_user';
  static String recieved_user = 'recieved_user';

  static String Ticket = 'Ticket';
  static String Dispute = 'Dispute';

  static String order_number = 'order_number';

  static String f_check = 'f_check';

  static String t_check = 't_check';

  static String l_check = 'l_check';

  static String g_check = 'g_check';

  static String facebook = 'facebook';

  static String google = 'google';

  static String twitter = 'twitter';

  static String linkedin = 'linkedin';

  static List<String> Product_Measurement = [
    'None',
    'Gram',
    'Kilogram',
    'Litre',
    'Pound',
    'Custom'
  ];

  static String currency_code = 'currency_code';

  static String items = 'items';

  static String state = 'state';

  static String customer_country = 'customer_country';

  static String shipping_state = 'shipping_state';

  static String shipping_name = 'shipping_name';

  static String shipping_email = 'shipping_email';

  static String shipping_phone = 'shipping_phone';

  static String shipping_address = 'shipping_address';

  static String shipping_country = 'shipping_country';

  static String shipping_city = 'shipping_city';

  static String shipping_zip = 'shipping_zip';

  static String totalQty = 'totalQty';

  static String total = 'total';

  static String shipping = 'shipping';

  static String pickup_location = 'pickup_location';

  static String shipping_cost = 'shipping_cost';

  static String packing_cost = 'packing_cost';

  static String shipping_title = 'shipping_title';

  static String packing_title = 'packing_title';

  static String tax = 'tax';

  static String order_notes = 'order_notes';

  static String coupon_code = 'coupon_code';

  static String coupon_discount = 'coupon_discount';

  static String dp = 'dp';

  static String vendor_shipping_id = 'vendor_shipping_id';

  static String vendor_packing_id = 'vendor_packing_id';

  static String wallet_price = 'wallet_price';

  static String affilate_user = 'affilate_user';

  static String qty = 'qty';

  static String size = 'size';

  static String size_qty = 'size_qty';

  static String size_key = 'size_key';

  static String size_price = 'size_price';

  static String color = 'color';

  static String keys = 'keys';

  static String values = 'values';

  static String prices = 'prices';

  static String url = 'url';

  static String error = 'error';

  static String pending = 'pending';

  static String amount = 'amount';

  static String affilate_income = 'affilate_income';

  static String payment_url = 'payment_url';

  static String confirm_password='confirm_password';
  static String reset_token='reset_token';

  static String methods='methods';

  static String Completed='Completed';

  static String attributes='attributes';
}
