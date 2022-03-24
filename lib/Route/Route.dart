

import 'package:flutter/material.dart';
import 'package:geniouscart/Screen/AboutUs.dart';
import 'package:geniouscart/Screen/AddPhysicalProduct.dart';
import 'package:geniouscart/Screen/AllMessageTIcket.dart';
import 'package:geniouscart/Screen/Authentication/Authentication.dart';
import 'package:geniouscart/Screen/Authentication/Registration.dart';
import 'package:geniouscart/Screen/BlogDetails.dart';
import 'package:geniouscart/Screen/BlogPage.dart';
import 'package:geniouscart/Screen/Cart.dart';
import 'package:geniouscart/Screen/ContactUs.dart';
import 'package:geniouscart/Screen/FaqPage.dart';
import 'package:geniouscart/Screen/DetailsProduct/ProductDetails.dart';
import 'package:geniouscart/Screen/FavoriteSeller/FavoriteSeller.dart';
import 'package:geniouscart/Screen/FavoriteSellerProduct.dart';
import 'package:geniouscart/Screen/MessagePage.dart';
import 'package:geniouscart/Screen/MyOrderPage.dart';
import 'package:geniouscart/Screen/OrderDetails.dart';
import 'package:geniouscart/Screen/OrderTracking.dart';
import 'package:geniouscart/Screen/AddWithdraw.dart';
import 'package:geniouscart/Screen/Checkout/PlaceOrder.dart';
import 'package:geniouscart/Screen/PaymentPage.dart';
import 'package:geniouscart/Screen/ProfileUpdate.dart';
import 'package:geniouscart/Screen/ResetPassword.dart';
import 'package:geniouscart/Screen/SearchProduct.dart';
import 'package:geniouscart/Screen/ShowProduct.dart';
import 'package:geniouscart/Screen/Splash.dart';
import 'package:geniouscart/Screen/TicketPage.dart';
import 'package:geniouscart/Screen/UserDeposit.dart';
import 'package:geniouscart/Screen/UserTicket.dart';
import 'package:geniouscart/Screen/UserTransactions.dart';
import 'package:geniouscart/Screen/Vendor/ProductType.dart';
import 'package:geniouscart/Screen/Vendor/VendorBanner.dart';
import 'package:geniouscart/Screen/Vendor/VendorPackaging.dart';
import 'package:geniouscart/Screen/Vendor/VendorProducts.dart';
import 'package:geniouscart/Screen/Vendor/VendorServices.dart';
import 'package:geniouscart/Screen/Vendor/VendorShipping.dart';
import 'package:geniouscart/Screen/Vendor/VendorSocialLinks.dart';
import 'package:geniouscart/Screen/UserWithdraw.dart';
import 'package:geniouscart/Screen/VendorPackages.dart';
import 'package:geniouscart/Screen/Vendor/VendorPanel.dart';
import 'package:geniouscart/Screen/WishList.dart';
import 'package:geniouscart/Test/Test.dart';

import '../Screen/MainScreen.dart';

const String Main = "Home";
const String ONBOARD = "OnBoard";
const String SPLASH_SCREEN = "splash_screen";
const String ADDONS = "Addons";
const String AUTHENTICATION = "Authentication";
const String REGISTER = "Register";
const String TEST = "Test";
const String PRODUCT_DETAILS = "Product Details";
const String BLOG = "Blog";
const String FAQS = "Faqs";
const String BLOG_DETAILS = "Blog Details";
const String ABOUTUS = "About Us";
const String SEARCH = "Search";
const String CART = "Cart";
const String PURCHASED_ITEMS = "Purchased Items";
const String DEPOSIT = "Deposit";
const String TRANSACTIONS = "Transactions";
const String ORDERS = "Orders";
const String ORDER_TRACKING = "Order Tracking";
const String FAVORITE_SELLERS = "Favorite Sellers";
const String ALL_TICKET = "All Ticket";
const String MESSAGES = "Messages";
const String TICKETS = "Tickets";
const String DISPUTES = "Disputes";
const String EDIT_PROFILE = "Edit Profile";
const String RESET_PASSWORD = "Reset Password";
const String DASHBOARD = "Dashboard";
const String VENDOR_PACKAGES = "Vendor Packages";
const String VENDOR_PACKAGING = "Vendor Packaging";
const String VENDOR_SHIPPING = "Vendor Shipping";
const String CONTACT_US = "Contact Us";
const String VENDOR_PANEL = "Vendor Panel";
const String VENDOR_PRODUCTS = "Vendor Products";
const String VENDOR_SERVICES = "Vendor Services";
const String PRODUCT_TYPE = "Product Type";
const String USER_WITHDRAW = "User Withdraw";
const String VENDOR_BANNER = "Vendor Banner";
const String VENDOR_SOCIAL_LINKS = "Vendor Social Links";
const String WISHLIST = "Wishlist";
const String SHOW_PRODUCT = "Show Product";
const String ADD_PHYSICAL_PRODUCT = "Add physical product";
const String SELLER_PRODUCT = "Seller Product";
const String ADD_WITHDRAW = "Add Withdraw";
const String TICKET_MESSAGE = "Ticket Message";
const String CHECKOUT = "Checkout";
const String PAYMENT_PAGE = "Payment Page";
const String ORDER_DETAILS = "Order Details";

Map<String, WidgetBuilder> appRoutes()=>{
  SPLASH_SCREEN: (BuildContext context) => Splash(),
  Main: (BuildContext context) => MainScreen(),
  PRODUCT_DETAILS: (BuildContext context) => ProductDetails(),
  AUTHENTICATION: (BuildContext context) => Authentication(),
  REGISTER: (BuildContext context) => Registration(),
  TEST: (BuildContext context) => SignInDemo(),
  BLOG: (BuildContext context) => BlogPage(),
  FAQS: (BuildContext context) => FaqPage(),
  BLOG_DETAILS: (BuildContext context) => BlogDetails(),
  ABOUTUS: (BuildContext context) => AboutUs(),
  SEARCH: (BuildContext context) => SearchProduct(),
  CART: (BuildContext context) => Cart(),
  EDIT_PROFILE: (BuildContext context) => ProfileUpdate(),
  RESET_PASSWORD: (BuildContext context) => ResetPassword(),
  VENDOR_PACKAGES: (BuildContext context) => VendorPackages(),
  CONTACT_US: (BuildContext context) => ContactUs(),
  MESSAGES: (BuildContext context) => MessagePage(),
  FAVORITE_SELLERS: (BuildContext context) => FavoriteSeller(),
  VENDOR_PANEL: (BuildContext context) => VendorPanel(),
  VENDOR_PRODUCTS: (BuildContext context) => VendorProducts(),
  VENDOR_SERVICES: (BuildContext context) => VendorServices(),
  PRODUCT_TYPE: (BuildContext context) => ProductType(),
  VENDOR_PACKAGING: (BuildContext context) => VendorPackaging(),
  VENDOR_SHIPPING: (BuildContext context) => VendorShipping(),
  USER_WITHDRAW: (BuildContext context) => UserWithdraw(),
  VENDOR_BANNER: (BuildContext context) => VendorBanner(),
  VENDOR_SOCIAL_LINKS: (BuildContext context) => VendorSocialLinks(),
  WISHLIST: (BuildContext context) => WishList(),
  ALL_TICKET: (BuildContext context) => AllMessageTicket(),
  SHOW_PRODUCT: (BuildContext context) => ShowProduct(),
  ADD_PHYSICAL_PRODUCT: (BuildContext context) => AddPhysicalProduct(),
  DEPOSIT: (BuildContext context) => UserDeposit(),
  TRANSACTIONS: (BuildContext context) => UserTransactions(),
  SELLER_PRODUCT: (BuildContext context) => FavoriteSellerProduct(),
  ADD_WITHDRAW: (BuildContext context) => AddWithdraw(),
  TICKETS: (BuildContext context) => UserTicket(),
  TICKET_MESSAGE: (BuildContext context) => TicketPage(),
  CHECKOUT: (BuildContext context) => PlaceOrder(),
  PAYMENT_PAGE: (BuildContext context) => PaymentPage(),
  ORDERS: (BuildContext context) => MyOrderPage(),
  ORDER_TRACKING: (BuildContext context) => OrderTracking(),
  ORDER_DETAILS: (BuildContext context) => OrderDetails(),
};