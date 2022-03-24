import 'package:geniouscart/URL/AppConstant.dart';

class URL {
  static String Main_Url = 'https://dev.geniusocean.net/genius_to_king/';
  static String device_type = 'ANDROID';
  static String map_api_key = 'AIzaSyBufiH5tq54UvegWnoqKt0WzLMRXckO6f4';

  static String assets = Main_Url + 'assets/images/';

  static String Section_Customization = Main_Url + 'api/front/section-customization';
  static String Settings = Main_Url + 'api/front/settings?name=generalsettings';
  static String PageSetting = Main_Url + 'api/front/settings?name=pagesettings';
  static String SocialSetting = Main_Url + 'api/front/settings?name=socialsettings';
  static String Login = Main_Url + 'api/user/login';
  static String Refresh_Token = Main_Url + 'api/user/refresh/token';
  static String Profile_Update = Main_Url + 'api/user/profile/update';
  static String Register = Main_Url + 'api/user/registration';
  static String Social_Login = Main_Url + 'api/user/social/login';
  static String Forgot_Password = Main_Url + 'api/user/forgot';
  static String Forgot_Password_Submit = Main_Url + 'api/user/forgot/submit';
  static String Logout = Main_Url + 'api/user/logout';
  static String GetUser = Main_Url + 'api/user/details';
  static String HomePageSlider = Main_Url + 'api/front/sliders';
  static String FeaturedBanners = Main_Url + 'api/front/featured-banners';
  static String Services = Main_Url + 'api/front/services';
  static String Partners = Main_Url + 'api/front/partners';
  static String ProductDetails = Main_Url + 'api/front/product/${AppConstant.product_id}/details';
  static String Banners = Main_Url +'api/front/banners?${AppConstant.type}=${AppConstant.add}${AppConstant.type}';
  static String Product = Main_Url +'api/front/products?${AppConstant.highlight}=${AppConstant.add}${AppConstant.highlight}&limit=10&${AppConstant.type}=${AppConstant.add}${AppConstant.type}&${AppConstant.product_type_License}=${AppConstant.add}${AppConstant.product_type_License}&${AppConstant.paginate}=${AppConstant.add}${AppConstant.paginate}';
  static String Blogs = Main_Url + 'api/front/blogs';
  static String Faqs = Main_Url + 'api/front/faqs';
  static String All_Details = Main_Url + 'api/front/pages';
  static String Category = Main_Url + 'api/front/categories';
  static String Search_Product = Main_Url + 'api/front/search?';
  static String Submit_Review = Main_Url + 'api/user/reviewsubmit';
  static String Submit_Comment = Main_Url + 'api/user/commentstore';
  static String Submit_Comment_Reply = Main_Url + 'api/user/replystore';
  static String Edit_Comment = Main_Url + 'api/user/commentupdate';
  static String Edit_Reply = Main_Url + 'api/user/replyupdate';
  static String Delete_Comment =Main_Url + 'api/user/comment/${AppConstant.id}/delete';
  static String Delete_Reply = Main_Url + 'api/user/reply/${AppConstant.id}/delete';
  static String ResetPassword = Main_Url + 'api/user/password/update';
  static String VendorPackages = Main_Url + 'api/user/packages';
  static String Contact_Admin = Main_Url + 'api/front/contactmail';
  static String User_Messages = Main_Url + 'api/user/messages';
  static String User_Ticket = Main_Url + 'api/user/tickets';
  static String User_Disputes = Main_Url + 'api/user/disputes';
  static String Favorite_Sellers = Main_Url + 'api/user/favorite/vendors';
  static String Remove_Favorite_Sellers = Main_Url + 'api/user/favorite/delete/';
  static String Add_Favorite_Sellers = Main_Url + 'api/user/favorite/store';
  static String Add_Favorite_Product = Main_Url + 'api/user/wishlist/add';
  static String Get_Favorite_Product = Main_Url + 'api/user/wishlists?sort=price_asc';
  static String Delete_Favorite_Product = Main_Url + 'api/user/wishlist/remove/';
  static String Store_Ticket = Main_Url + 'api/user/message/store';
  static String Store_User_Ticket = Main_Url + 'api/user/ticket-dispute/store';
  static String Delete_Ticket = Main_Url + 'api/user/message/#/delete';
  static String Delete_User_Ticket = Main_Url + 'api/user/ticket-dispute/#/delete';
  static String Deposits = Main_Url + 'api/user/deposits';
  static String Withdraw = Main_Url + 'api/user/withdraws';
  static String Withdraw_Store = Main_Url + 'api/user/withdraw/create';
  static String Deposit_Store = Main_Url + 'api/user/deposit/store';
  static String SellerProduct = Main_Url + 'api/front/vendor/products/';
  static String Message_Reply_Store = Main_Url + 'api/user/message/post';
  static String Ticket_Reply_Store = Main_Url + 'api/user/ticket-dispute/message/store';
  static String User_Dashboard = Main_Url + 'api/user/dashboard';
  static String PaymentGateways = Main_Url + 'api/user/withdraw/methods/field';
  static String Transactios = Main_Url + 'api/user/transactions';
  static String Checkout = Main_Url + 'api/front/checkout';
  static String Check_Coupon = Main_Url + 'api/front/get/coupon-code?coupon=';
  static String Orders = Main_Url + 'api/user/orders';
  static String All_Currencies = Main_Url + 'api/front/currencies';
  static String Order_Tracking = Main_Url + 'api/front/ordertrack?order_number=';

  ///Vendor Panel
  static String VendorDetails = Main_Url + 'api/vendor/details';
  static String Vendor_Dashboard = Main_Url + 'api/vendor/dashboard';

  static String VendorProducts = Main_Url + 'api/vendor/products';

  //Service
  static String VendorServices = Main_Url + 'api/vendor/services';
  static String VendorAddService = Main_Url + 'api/vendor/service/store';
  static String VendorUpdateService = Main_Url + 'api/vendor/service/update/';
  static String VendorDeleteService = Main_Url + 'api/vendor/service/delete/';

  //Packaging
  static String VendorPackaging = Main_Url + 'api/vendor/packages';
  static String VendorAddPackaging = Main_Url + 'api/vendor/package/store';
  static String VendorUpdatePackaging = Main_Url + 'api/vendor/package/update/';
  static String VendorDeletePackaging = Main_Url + 'api/vendor/package/delete/';

  //Shipping
  static String VendorShipping = Main_Url + 'api/vendor/shippings';
  static String VendorAddShipping = Main_Url + 'api/vendor/shipping/store';
  static String VendorUpdateShipping = Main_Url + 'api/vendor/shipping/update/';
  static String VendorDeleteShipping = Main_Url + 'api/vendor/shipping/delete/';

  //Withdraw
  static String VendorWithdraw = Main_Url + 'api/vendor/withdraws';
  static String VendorWithdraw_Store = Main_Url + 'api/vendor/withdraw/create';

  //Product
  static String Store_Product = Main_Url + 'api/vendor/product/store';
  static String Delete_Product = Main_Url + 'api/vendor/product/delete/';
  static String Get_Attribute =
      Main_Url + 'api/vendor/product/getattributes?id=';

  //Social
  static String Update_Social_Link = Main_Url + 'api/vendor/social/link/update';
}
