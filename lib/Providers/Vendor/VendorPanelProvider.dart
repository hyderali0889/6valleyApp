import 'package:flutter/material.dart';
import 'package:geniouscart/CustomIcon/my_flutter_app_icons.dart' as CustomIcon;
import 'package:geniouscart/Route/Route.dart';
import 'package:geniouscart/main.dart';

class VendorPanelProvider with ChangeNotifier{
  BuildContext context;
  List<Section> sections()=>[
    /*Section(
      name: language.Vendor_Sections[0],
      route: '',
      icon: CustomIcon.MyFlutterApp.home,
      subSections: List()
    ),*/
    Section(
      name: language.Vendor_Sections[1],
      route: '',
      icon: CustomIcon.MyFlutterApp.orders,
      subSections: [
        SubSection(
          name: language.Vendor_Orders[0],
          route: ''
        )
      ]
    ),
    Section(
      name: language.Vendor_Sections[2],
      route: '',
      icon: CustomIcon.MyFlutterApp.products,
      subSections: [
        SubSection(
          name: language.Vendor_Products[0],
          route: PRODUCT_TYPE
        ),
        SubSection(
          name: language.Vendor_Products[1],
          route: VENDOR_PRODUCTS
        ),
        SubSection(
          name: language.Vendor_Products[2],
          route: ''
        ),
      ]
    ),
    Section(
      name: language.Vendor_Sections[3],
      route: '',
      icon: CustomIcon.MyFlutterApp.affiliate_product,
      subSections: [
        SubSection(
          name: language.Vendor_Affiliate_Products[0],
          route: ''
        ),
        SubSection(
          name: language.Vendor_Affiliate_Products[1],
          route: ''
        ),
      ]
    ),
    /*Section(
      name: language.Vendor_Sections[4],
      route: '',
      icon: CustomIcon.MyFlutterApp.bulk_upload,
      subSections: List()
    ),*/
    Section(
      name: language.Vendor_Sections[5],
      route: USER_WITHDRAW,
      icon: CustomIcon.MyFlutterApp.withdraws,
      subSections: List()
    ),
    Section(
      name: language.Vendor_Sections[6],
      route: VENDOR_PACKAGES,
      icon: CustomIcon.MyFlutterApp.pricing,
      subSections: List()
    ),
    Section(
      name: language.Vendor_Sections[7],
      route: '',
      icon: CustomIcon.MyFlutterApp.settings,
        subSections: [
          SubSection(
              name: language.Vendor_Settings[0],
              route: VENDOR_SERVICES
          ),
          SubSection(
              name: language.Vendor_Settings[1],
              route: VENDOR_BANNER
          ),
          SubSection(
              name: language.Vendor_Settings[2],
              route: VENDOR_SHIPPING
          ),
          SubSection(
              name: language.Vendor_Settings[3],
              route: VENDOR_PACKAGING
          ),
          SubSection(
              name: language.Vendor_Settings[4],
              route: VENDOR_SOCIAL_LINKS
          ),
        ]
    ),
  ];

  List<AnimationController>controllers=List();
  List<Animation<double>> rotation=List();
  List<bool> isExpend=List();
  Animatable<double> easeInTween = CurveTween(curve: Curves.easeIn);
  Animatable<double> halfTween = Tween<double>(begin: 0.0, end: 0.5);


  void setView(BuildContext context)=>this.context=context;

  void setAnimation(_vendorPanelState) {
    for(int i=0;i<sections().length;i++){
      controllers.add(AnimationController(duration: Duration(milliseconds: 200), vsync: _vendorPanelState));
      rotation.add(controllers[i].drive(halfTween.chain(easeInTween)));
      isExpend.add(false);
    }
  }

  void changeAnimation(int index,bool state){
    isExpend[index]=state;
    if (state) {
      controllers[index].forward();
    } else {
      controllers[index].reverse().then<void>((void value) {
        notifyListeners();
      });
    }
  }
}

class Section{
  String name,route;
  IconData icon;
  List<SubSection> subSections;
  Section({this.name, this.route, this.icon,this.subSections});
}
class SubSection{
  String name,route;
  SubSection({this.name, this.route});
}