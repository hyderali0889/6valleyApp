import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:geniouscart/Dimension/Dimension.dart';
import 'package:geniouscart/Providers/PlaceOrderProvider.dart';
import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/Widgets/DefaultTextField.dart';
import 'package:geniouscart/Widgets/KeyboardHandler.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class OrderInfo extends StatefulWidget {
  @override
  _OrderInfoState createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
  PlaceOrderProvider provider;
  @override
  Widget build(BuildContext context) {
    if(provider==null)
      provider=Provider.of<PlaceOrderProvider>(context);
    return KeyboardHandler(
      config: provider.keyboardConfiguration(),
      child: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: Dimension.Size_10,right: Dimension.Size_10),
          children: [
            Text(language.Personal_Information,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
            SizedBox(height: Dimension.Size_10,),
            DefaultTextField(
              controller: provider.name,
              label: language.Name,
            ),
            SizedBox(height: Dimension.Size_10,),
            DefaultTextField(
              controller: provider.email,
              label: language.Email,
              textInputType: TextInputType.emailAddress
            ),
            SizedBox(height: Dimension.Size_10,),
            DefaultTextField(
              controller: provider.phone,
              label: language.Phone,
              textInputType: TextInputType.phone,
              focusNode: provider.phoneFocus
            ),
            SizedBox(height: Dimension.Size_10,),
            Text(language.Billing_Details,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
            SizedBox(height: Dimension.Size_10,),
            Container(
              padding: EdgeInsets.all(Dimension.Size_10).copyWith(top: 0,bottom: 0),
              margin: EdgeInsets.only(bottom: Dimension.Size_10),
              height: Dimension.Size_50,
              decoration: BoxDecoration(
                  color: Themes.Background,
                  borderRadius: BorderRadius.circular(Dimension.Size_5),
                  border: Border.all(width: 2,color: Themes.TexftFieldBorder)
              ),
              child: DropdownButton<String>(
                value: provider.selectedShipping,
                isExpanded: true,
                style: Theme.of(context).textTheme.bodyText1,
                underline: Container(),
                onChanged: (String newValue)=>provider.setShipping(newValue),
                hint: Text(language.Select_an_option,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
                items: provider.ways
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: Theme.of(context).textTheme.bodyText1,),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: Dimension.Size_10,),
            DefaultTextField(
                controller: provider.address,
                label: language.Address,
            ),
            SizedBox(height: Dimension.Size_10,),
            Container(
              padding: EdgeInsets.all(Dimension.Size_10).copyWith(top: 0,bottom: 0),
              margin: EdgeInsets.only(bottom: Dimension.Size_10),
              height: Dimension.Size_50,
              decoration: BoxDecoration(
                  color: Themes.Background,
                  borderRadius: BorderRadius.circular(Dimension.Size_5),
                  border: Border.all(width: 2,color: Themes.TexftFieldBorder)
              ),
              child: DropdownButton<Country>(
                value: provider.selectedCountry,
                isExpanded: true,
                style: Theme.of(context).textTheme.bodyText1,
                underline: Container(),
                onChanged: (Country newValue)=>provider.setCountry(newValue),
                hint: Text(language.Select_your_country,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
                items: provider.allCountry
                    .map<DropdownMenuItem<Country>>((Country value) {
                  return DropdownMenuItem<Country>(
                    value: value,
                    child: Text(value.name,style: Theme.of(context).textTheme.bodyText1,),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: Dimension.Size_10,),
            DefaultTextField(
                controller: provider.state,
                enableValidation: false,
                label: language.State,
            ),
            SizedBox(height: Dimension.Size_10,),
            DefaultTextField(
                controller: provider.city,
                label: language.City,
            ),
            SizedBox(height: Dimension.Size_10,),
            DefaultTextField(
                controller: provider.postalCode,
                label: language.Zip_Code,
            ),
            Row(
              children: [
                Checkbox(
                  value: provider.enableShipping,
                  onChanged: provider.changeShipping,
                ),
                Text(language.Ship_to_a_Different_Address,style: Theme.of(context).textTheme.headline1.copyWith(fontSize: Dimension.Text_Size_Small),),
              ],
            ),
            SizedBox(height: Dimension.Size_10,),
            Visibility(
              visible: provider.enableShipping,
              child: shippingDetails()
            )
          ],
        ),
      ),
    );
  }

  shippingDetails() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        DefaultTextField(
          controller: provider.shippingName,
          label: language.Name,
        ),
        SizedBox(height: Dimension.Size_10,),
        DefaultTextField(
            controller: provider.shippingEmail,
            label: language.Email,
            textInputType: TextInputType.emailAddress,
        ),
        SizedBox(height: Dimension.Size_10,),
        DefaultTextField(
            controller: provider.shippingPhone,
            label: language.Phone,
            textInputType: TextInputType.phone,
            focusNode: provider.shippingPhoneFocus
        ),
        SizedBox(height: Dimension.Size_10,),
        DefaultTextField(
          controller: provider.shippingAddress,
          label: language.Address,
        ),
        SizedBox(height: Dimension.Size_10,),
        Container(
          padding: EdgeInsets.all(Dimension.Size_10).copyWith(top: 0,bottom: 0),
          margin: EdgeInsets.only(bottom: Dimension.Size_10),
          height: Dimension.Size_50,
          decoration: BoxDecoration(
              color: Themes.Background,
              borderRadius: BorderRadius.circular(Dimension.Size_5),
              border: Border.all(width: 2,color: Themes.TexftFieldBorder)
          ),
          child: DropdownButton<Country>(
            value: provider.selectedShippingCountry,
            isExpanded: true,
            style: Theme.of(context).textTheme.bodyText1,
            underline: Container(),
            onChanged: (Country newValue)=>provider.setShippingCountry(newValue),
            hint: Text(language.Select_your_country,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Themes.Grey),),
            items: provider.allCountry
                .map<DropdownMenuItem<Country>>((Country value) {
              return DropdownMenuItem<Country>(
                value: value,
                child: Text(value.name,style: Theme.of(context).textTheme.bodyText1,),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: Dimension.Size_10,),
        DefaultTextField(
          controller: provider.shippingState,
          label: language.State,
        ),
        SizedBox(height: Dimension.Size_10,),
        DefaultTextField(
          controller: provider.shippingCity,
          label: language.City,
        ),
        SizedBox(height: Dimension.Size_10,),
        DefaultTextField(
          controller: provider.shippingPostalCode,
          label: language.Zip_Code,
        ),
      ],
    );
  }
}
