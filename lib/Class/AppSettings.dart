class AppSetting {
  bool status;
  Data data;

  AppSetting({this.status, this.data});

  AppSetting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String logo;
  String favicon;
  String title;
  String headerEmail;
  String headerPhone;
  String footer;
  String copyright;
  String colors;
  String loader;
  String adminLoader;
  String isTalkto;
  String talkto;
  String isLanguage;
  String isLoader;
  String mapKey;
  String isDisqus;
  String disqus;
  String isContact;
  String isFaq;
  String guestCheckout;
  String stripeCheck;
  String codCheck;
  String stripeKey;
  String stripeSecret;
  String currencyFormat;
  String withdrawFee;
  String withdrawCharge;
  String tax;
  String shippingCost;
  String mailEngine;
  String smtpHost;
  String smtpPort;
  String smtpUser;
  String smtpPass;
  String fromEmail;
  String fromName;
  String isSmtp;
  String isComment;
  String isCurrency;
  String addCart;
  String outStock;
  String addWish;
  String alreadyWish;
  String wishRemove;
  String addCompare;
  String alreadyCompare;
  String compareRemove;
  String colorChange;
  String couponFound;
  String noCoupon;
  String alreadyCoupon;
  String orderTitle;
  String orderText;
  String isAffilate;
  String affilateCharge;
  String affilateBanner;
  String alreadyCart;
  String fixedCommission;
  String percentageCommission;
  String multipleShipping;
  String multiplePackaging;
  String vendorShipInfo;
  String regVendor;
  String codText;
  String paypalText;
  String stripeText;
  String headerColor;
  String footerColor;
  String copyrightColor;
  String isAdminLoader;
  String menuColor;
  String menuHoverColor;
  String isHome;
  String isVerificationEmail;
  String instamojoKey;
  String instamojoToken;
  String instamojoText;
  String isInstamojo;
  String instamojoSandbox;
  String isPaystack;
  String paystackKey;
  String paystackEmail;
  String paystackText;
  String wholesell;
  String isCapcha;
  String errorBanner;
  String isPopup;
  String popupTitle;
  String popupText;
  String popupBackground;
  String invoiceLogo;
  String userImage;
  String vendorColor;
  String isSecure;
  String isReport;
  String paypalCheck;
  String paypalClientId;
  String paypalClientSecret;
  String paypalSandboxCheck;
  String footerLogo;
  String emailEncryption;
  String paytmMerchant;
  String paytmSecret;
  String paytmWebsite;
  String paytmIndustry;
  String isPaytm;
  String paytmText;
  String paytmMode;
  String isMolly;
  String mollyKey;
  String mollyText;
  String isRazorpay;
  String razorpayKey;
  String razorpaySecret;
  String razorpayText;
  String showStock;
  String isMaintain;
  String maintainText;
  String isAuthorize;
  String authorizeLoginId;
  String authorizeTxnKey;
  String authorizeText;
  String authorizeMode;
  String isMercado;
  String mercadoToken;
  String mercadoText;
  String mercadopagoSandboxCheck;
  String isBuyNow;
  String isFlutter;
  String flutterPublicKey;
  String flutterText;
  String flutterSecret;
  String isTwocheckout;
  String twocheckoutPrivateKey;
  String twocheckoutSellerId;
  String twocheckoutPublicKey;
  String twocheckoutSandboxCheck;
  String twocheckoutText;
  String isSsl;
  String sslSandboxCheck;
  String sslStoreId;
  String sslStorePassword;
  String sslText;
  String isVoguepay;
  String vougepayMerchantId;
  String vougepayDeveloperCode;
  String voguepayText;
  String version;
  String affilateProduct;

  Data(
      {this.id,
        this.logo,
        this.favicon,
        this.title,
        this.headerEmail,
        this.headerPhone,
        this.footer,
        this.copyright,
        this.colors,
        this.loader,
        this.adminLoader,
        this.isTalkto,
        this.talkto,
        this.isLanguage,
        this.isLoader,
        this.mapKey,
        this.isDisqus,
        this.disqus,
        this.isContact,
        this.isFaq,
        this.guestCheckout,
        this.stripeCheck,
        this.codCheck,
        this.stripeKey,
        this.stripeSecret,
        this.currencyFormat,
        this.withdrawFee,
        this.withdrawCharge,
        this.tax,
        this.shippingCost,
        this.mailEngine,
        this.smtpHost,
        this.smtpPort,
        this.smtpUser,
        this.smtpPass,
        this.fromEmail,
        this.fromName,
        this.isSmtp,
        this.isComment,
        this.isCurrency,
        this.addCart,
        this.outStock,
        this.addWish,
        this.alreadyWish,
        this.wishRemove,
        this.addCompare,
        this.alreadyCompare,
        this.compareRemove,
        this.colorChange,
        this.couponFound,
        this.noCoupon,
        this.alreadyCoupon,
        this.orderTitle,
        this.orderText,
        this.isAffilate,
        this.affilateCharge,
        this.affilateBanner,
        this.alreadyCart,
        this.fixedCommission,
        this.percentageCommission,
        this.multipleShipping,
        this.multiplePackaging,
        this.vendorShipInfo,
        this.regVendor,
        this.codText,
        this.paypalText,
        this.stripeText,
        this.headerColor,
        this.footerColor,
        this.copyrightColor,
        this.isAdminLoader,
        this.menuColor,
        this.menuHoverColor,
        this.isHome,
        this.isVerificationEmail,
        this.instamojoKey,
        this.instamojoToken,
        this.instamojoText,
        this.isInstamojo,
        this.instamojoSandbox,
        this.isPaystack,
        this.paystackKey,
        this.paystackEmail,
        this.paystackText,
        this.wholesell,
        this.isCapcha,
        this.errorBanner,
        this.isPopup,
        this.popupTitle,
        this.popupText,
        this.popupBackground,
        this.invoiceLogo,
        this.userImage,
        this.vendorColor,
        this.isSecure,
        this.isReport,
        this.paypalCheck,
        this.paypalClientId,
        this.paypalClientSecret,
        this.paypalSandboxCheck,
        this.footerLogo,
        this.emailEncryption,
        this.paytmMerchant,
        this.paytmSecret,
        this.paytmWebsite,
        this.paytmIndustry,
        this.isPaytm,
        this.paytmText,
        this.paytmMode,
        this.isMolly,
        this.mollyKey,
        this.mollyText,
        this.isRazorpay,
        this.razorpayKey,
        this.razorpaySecret,
        this.razorpayText,
        this.showStock,
        this.isMaintain,
        this.maintainText,
        this.isAuthorize,
        this.authorizeLoginId,
        this.authorizeTxnKey,
        this.authorizeText,
        this.authorizeMode,
        this.isMercado,
        this.mercadoToken,
        this.mercadoText,
        this.mercadopagoSandboxCheck,
        this.isBuyNow,
        this.isFlutter,
        this.flutterPublicKey,
        this.flutterText,
        this.flutterSecret,
        this.isTwocheckout,
        this.twocheckoutPrivateKey,
        this.twocheckoutSellerId,
        this.twocheckoutPublicKey,
        this.twocheckoutSandboxCheck,
        this.twocheckoutText,
        this.isSsl,
        this.sslSandboxCheck,
        this.sslStoreId,
        this.sslStorePassword,
        this.sslText,
        this.isVoguepay,
        this.vougepayMerchantId,
        this.vougepayDeveloperCode,
        this.voguepayText,
        this.version,
        this.affilateProduct});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    favicon = json['favicon'];
    title = json['title'];
    headerEmail = json['header_email'];
    headerPhone = json['header_phone'];
    footer = json['footer'];
    copyright = json['copyright'];
    colors = json['colors'];
    loader = json['loader'];
    adminLoader = json['admin_loader'];
    isTalkto = json['is_talkto'];
    talkto = json['talkto'];
    isLanguage = json['is_language'];
    isLoader = json['is_loader'];
    mapKey = json['map_key'];
    isDisqus = json['is_disqus'];
    disqus = json['disqus'];
    isContact = json['is_contact'];
    isFaq = json['is_faq'];
    guestCheckout = json['guest_checkout'];
    stripeCheck = json['stripe_check'];
    codCheck = json['cod_check'];
    stripeKey = json['stripe_key'];
    stripeSecret = json['stripe_secret'];
    currencyFormat = json['currency_format'];
    withdrawFee = json['withdraw_fee'];
    withdrawCharge = json['withdraw_charge'];
    tax = json['tax'];
    shippingCost = json['shipping_cost'];
    mailEngine = json['mail_engine'];
    smtpHost = json['smtp_host'];
    smtpPort = json['smtp_port'];
    smtpUser = json['smtp_user'];
    smtpPass = json['smtp_pass'];
    fromEmail = json['from_email'];
    fromName = json['from_name'];
    isSmtp = json['is_smtp'];
    isComment = json['is_comment'];
    isCurrency = json['is_currency'];
    addCart = json['add_cart'];
    outStock = json['out_stock'];
    addWish = json['add_wish'];
    alreadyWish = json['already_wish'];
    wishRemove = json['wish_remove'];
    addCompare = json['add_compare'];
    alreadyCompare = json['already_compare'];
    compareRemove = json['compare_remove'];
    colorChange = json['color_change'];
    couponFound = json['coupon_found'];
    noCoupon = json['no_coupon'];
    alreadyCoupon = json['already_coupon'];
    orderTitle = json['order_title'];
    orderText = json['order_text'];
    isAffilate = json['is_affilate'];
    affilateCharge = json['affilate_charge'];
    affilateBanner = json['affilate_banner'];
    alreadyCart = json['already_cart'];
    fixedCommission = json['fixed_commission'];
    percentageCommission = json['percentage_commission'];
    multipleShipping = json['multiple_shipping'];
    multiplePackaging = json['multiple_packaging'];
    vendorShipInfo = json['vendor_ship_info'];
    regVendor = json['reg_vendor'];
    codText = json['cod_text'];
    paypalText = json['paypal_text'];
    stripeText = json['stripe_text'];
    headerColor = json['header_color'];
    footerColor = json['footer_color'];
    copyrightColor = json['copyright_color'];
    isAdminLoader = json['is_admin_loader'];
    menuColor = json['menu_color'];
    menuHoverColor = json['menu_hover_color'];
    isHome = json['is_home'];
    isVerificationEmail = json['is_verification_email'];
    instamojoKey = json['instamojo_key'];
    instamojoToken = json['instamojo_token'];
    instamojoText = json['instamojo_text'];
    isInstamojo = json['is_instamojo'];
    instamojoSandbox = json['instamojo_sandbox'];
    isPaystack = json['is_paystack'];
    paystackKey = json['paystack_key'];
    paystackEmail = json['paystack_email'];
    paystackText = json['paystack_text'];
    wholesell = json['wholesell'];
    isCapcha = json['is_capcha'];
    errorBanner = json['error_banner'];
    isPopup = json['is_popup'];
    popupTitle = json['popup_title'];
    popupText = json['popup_text'];
    popupBackground = json['popup_background'];
    invoiceLogo = json['invoice_logo'];
    userImage = json['user_image'];
    vendorColor = json['vendor_color'];
    isSecure = json['is_secure'];
    isReport = json['is_report'];
    paypalCheck = json['paypal_check'];
    paypalClientId = json['paypal_client_id'];
    paypalClientSecret = json['paypal_client_secret'];
    paypalSandboxCheck = json['paypal_sandbox_check'];
    footerLogo = json['footer_logo'];
    emailEncryption = json['email_encryption'];
    paytmMerchant = json['paytm_merchant'];
    paytmSecret = json['paytm_secret'];
    paytmWebsite = json['paytm_website'];
    paytmIndustry = json['paytm_industry'];
    isPaytm = json['is_paytm'];
    paytmText = json['paytm_text'];
    paytmMode = json['paytm_mode'];
    isMolly = json['is_molly'];
    mollyKey = json['molly_key'];
    mollyText = json['molly_text'];
    isRazorpay = json['is_razorpay'];
    razorpayKey = json['razorpay_key'];
    razorpaySecret = json['razorpay_secret'];
    razorpayText = json['razorpay_text'];
    showStock = json['show_stock'];
    isMaintain = json['is_maintain'];
    maintainText = json['maintain_text'];
    isAuthorize = json['is_authorize'];
    authorizeLoginId = json['authorize_login_id'];
    authorizeTxnKey = json['authorize_txn_key'];
    authorizeText = json['authorize_text'];
    authorizeMode = json['authorize_mode'];
    isMercado = json['is_mercado'];
    mercadoToken = json['mercado_token'];
    mercadoText = json['mercado_text'];
    mercadopagoSandboxCheck = json['mercadopago_sandbox_check'];
    isBuyNow = json['is_buy_now'];
    isFlutter = json['is_flutter'];
    flutterPublicKey = json['flutter_public_key'];
    flutterText = json['flutter_text'];
    flutterSecret = json['flutter_secret'];
    isTwocheckout = json['is_twocheckout'];
    twocheckoutPrivateKey = json['twocheckout_private_key'];
    twocheckoutSellerId = json['twocheckout_seller_id'];
    twocheckoutPublicKey = json['twocheckout_public_key'];
    twocheckoutSandboxCheck = json['twocheckout_sandbox_check'];
    twocheckoutText = json['twocheckout_text'];
    isSsl = json['is_ssl'];
    sslSandboxCheck = json['ssl_sandbox_check'];
    sslStoreId = json['ssl_store_id'];
    sslStorePassword = json['ssl_store_password'];
    sslText = json['ssl_text'];
    isVoguepay = json['is_voguepay'];
    vougepayMerchantId = json['vougepay_merchant_id'];
    vougepayDeveloperCode = json['vougepay_developer_code'];
    voguepayText = json['voguepay_text'];
    version = json['version'];
    affilateProduct = json['affilate_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['favicon'] = this.favicon;
    data['title'] = this.title;
    data['header_email'] = this.headerEmail;
    data['header_phone'] = this.headerPhone;
    data['footer'] = this.footer;
    data['copyright'] = this.copyright;
    data['colors'] = this.colors;
    data['loader'] = this.loader;
    data['admin_loader'] = this.adminLoader;
    data['is_talkto'] = this.isTalkto;
    data['talkto'] = this.talkto;
    data['is_language'] = this.isLanguage;
    data['is_loader'] = this.isLoader;
    data['map_key'] = this.mapKey;
    data['is_disqus'] = this.isDisqus;
    data['disqus'] = this.disqus;
    data['is_contact'] = this.isContact;
    data['is_faq'] = this.isFaq;
    data['guest_checkout'] = this.guestCheckout;
    data['stripe_check'] = this.stripeCheck;
    data['cod_check'] = this.codCheck;
    data['stripe_key'] = this.stripeKey;
    data['stripe_secret'] = this.stripeSecret;
    data['currency_format'] = this.currencyFormat;
    data['withdraw_fee'] = this.withdrawFee;
    data['withdraw_charge'] = this.withdrawCharge;
    data['tax'] = this.tax;
    data['shipping_cost'] = this.shippingCost;
    data['mail_engine'] = this.mailEngine;
    data['smtp_host'] = this.smtpHost;
    data['smtp_port'] = this.smtpPort;
    data['smtp_user'] = this.smtpUser;
    data['smtp_pass'] = this.smtpPass;
    data['from_email'] = this.fromEmail;
    data['from_name'] = this.fromName;
    data['is_smtp'] = this.isSmtp;
    data['is_comment'] = this.isComment;
    data['is_currency'] = this.isCurrency;
    data['add_cart'] = this.addCart;
    data['out_stock'] = this.outStock;
    data['add_wish'] = this.addWish;
    data['already_wish'] = this.alreadyWish;
    data['wish_remove'] = this.wishRemove;
    data['add_compare'] = this.addCompare;
    data['already_compare'] = this.alreadyCompare;
    data['compare_remove'] = this.compareRemove;
    data['color_change'] = this.colorChange;
    data['coupon_found'] = this.couponFound;
    data['no_coupon'] = this.noCoupon;
    data['already_coupon'] = this.alreadyCoupon;
    data['order_title'] = this.orderTitle;
    data['order_text'] = this.orderText;
    data['is_affilate'] = this.isAffilate;
    data['affilate_charge'] = this.affilateCharge;
    data['affilate_banner'] = this.affilateBanner;
    data['already_cart'] = this.alreadyCart;
    data['fixed_commission'] = this.fixedCommission;
    data['percentage_commission'] = this.percentageCommission;
    data['multiple_shipping'] = this.multipleShipping;
    data['multiple_packaging'] = this.multiplePackaging;
    data['vendor_ship_info'] = this.vendorShipInfo;
    data['reg_vendor'] = this.regVendor;
    data['cod_text'] = this.codText;
    data['paypal_text'] = this.paypalText;
    data['stripe_text'] = this.stripeText;
    data['header_color'] = this.headerColor;
    data['footer_color'] = this.footerColor;
    data['copyright_color'] = this.copyrightColor;
    data['is_admin_loader'] = this.isAdminLoader;
    data['menu_color'] = this.menuColor;
    data['menu_hover_color'] = this.menuHoverColor;
    data['is_home'] = this.isHome;
    data['is_verification_email'] = this.isVerificationEmail;
    data['instamojo_key'] = this.instamojoKey;
    data['instamojo_token'] = this.instamojoToken;
    data['instamojo_text'] = this.instamojoText;
    data['is_instamojo'] = this.isInstamojo;
    data['instamojo_sandbox'] = this.instamojoSandbox;
    data['is_paystack'] = this.isPaystack;
    data['paystack_key'] = this.paystackKey;
    data['paystack_email'] = this.paystackEmail;
    data['paystack_text'] = this.paystackText;
    data['wholesell'] = this.wholesell;
    data['is_capcha'] = this.isCapcha;
    data['error_banner'] = this.errorBanner;
    data['is_popup'] = this.isPopup;
    data['popup_title'] = this.popupTitle;
    data['popup_text'] = this.popupText;
    data['popup_background'] = this.popupBackground;
    data['invoice_logo'] = this.invoiceLogo;
    data['user_image'] = this.userImage;
    data['vendor_color'] = this.vendorColor;
    data['is_secure'] = this.isSecure;
    data['is_report'] = this.isReport;
    data['paypal_check'] = this.paypalCheck;
    data['paypal_client_id'] = this.paypalClientId;
    data['paypal_client_secret'] = this.paypalClientSecret;
    data['paypal_sandbox_check'] = this.paypalSandboxCheck;
    data['footer_logo'] = this.footerLogo;
    data['email_encryption'] = this.emailEncryption;
    data['paytm_merchant'] = this.paytmMerchant;
    data['paytm_secret'] = this.paytmSecret;
    data['paytm_website'] = this.paytmWebsite;
    data['paytm_industry'] = this.paytmIndustry;
    data['is_paytm'] = this.isPaytm;
    data['paytm_text'] = this.paytmText;
    data['paytm_mode'] = this.paytmMode;
    data['is_molly'] = this.isMolly;
    data['molly_key'] = this.mollyKey;
    data['molly_text'] = this.mollyText;
    data['is_razorpay'] = this.isRazorpay;
    data['razorpay_key'] = this.razorpayKey;
    data['razorpay_secret'] = this.razorpaySecret;
    data['razorpay_text'] = this.razorpayText;
    data['show_stock'] = this.showStock;
    data['is_maintain'] = this.isMaintain;
    data['maintain_text'] = this.maintainText;
    data['is_authorize'] = this.isAuthorize;
    data['authorize_login_id'] = this.authorizeLoginId;
    data['authorize_txn_key'] = this.authorizeTxnKey;
    data['authorize_text'] = this.authorizeText;
    data['authorize_mode'] = this.authorizeMode;
    data['is_mercado'] = this.isMercado;
    data['mercado_token'] = this.mercadoToken;
    data['mercado_text'] = this.mercadoText;
    data['mercadopago_sandbox_check'] = this.mercadopagoSandboxCheck;
    data['is_buy_now'] = this.isBuyNow;
    data['is_flutter'] = this.isFlutter;
    data['flutter_public_key'] = this.flutterPublicKey;
    data['flutter_text'] = this.flutterText;
    data['flutter_secret'] = this.flutterSecret;
    data['is_twocheckout'] = this.isTwocheckout;
    data['twocheckout_private_key'] = this.twocheckoutPrivateKey;
    data['twocheckout_seller_id'] = this.twocheckoutSellerId;
    data['twocheckout_public_key'] = this.twocheckoutPublicKey;
    data['twocheckout_sandbox_check'] = this.twocheckoutSandboxCheck;
    data['twocheckout_text'] = this.twocheckoutText;
    data['is_ssl'] = this.isSsl;
    data['ssl_sandbox_check'] = this.sslSandboxCheck;
    data['ssl_store_id'] = this.sslStoreId;
    data['ssl_store_password'] = this.sslStorePassword;
    data['ssl_text'] = this.sslText;
    data['is_voguepay'] = this.isVoguepay;
    data['vougepay_merchant_id'] = this.vougepayMerchantId;
    data['vougepay_developer_code'] = this.vougepayDeveloperCode;
    data['voguepay_text'] = this.voguepayText;
    data['version'] = this.version;
    data['affilate_product'] = this.affilateProduct;
    return data;
  }
}