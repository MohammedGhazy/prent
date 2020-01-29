import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prent/model/cartItemModel.dart';
import 'package:prent/provider.dart';
import 'package:prent/screens/cart_screen.dart';
import 'package:prent/screens/descreption_screen.dart';
import 'package:provider/provider.dart';
import 'package:prent/model/category_model.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:prent/screens/product_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SubCategory extends StatefulWidget {
  final String title;
  final List<Models> models;
  final int id;

  SubCategory({this.title, this.models, this.id});

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  void showAlertDialogOnOkCallback(String title, String msg,
      DialogType dialogType, BuildContext context, VoidCallback onOkPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      tittle: title,
      desc: msg,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Color(0xffF7B600),
      btnOkOnPress: onOkPress,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Logic>(context, listen: false).cartList == null) {
      return Center(child: Text(''));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Localizations.localeOf(context).languageCode == 'ar'
                    ? Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).tr(
                              'home_page.printers',
                            ),
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(widget.title),
                        ],
                      )
                    : Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.title),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            AppLocalizations.of(context).tr(
                              'home_page.printers',
                            ),
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                InkWell(
                  onTap: () {
                    print('::::::::id:::::::${widget.id}');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductScreen(widget.id)));
                  },
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).tr(
                            'home_page.more',
                          ),
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              color: Color(0xffF7B600),
                              fontSize: 17.5),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xffF7B600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              itemCount: widget.models.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                widget.id;
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DescriptionScreen(
                                subModel: widget.models[index],
                                type: 'sub',
                              )));
                    },
                    child: Container(
                      width: 240,
                      child: Card(
                        elevation: 2.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              '${widget.models[index].images[0].images}',
                              height: 110,
                              width: 110,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: Text(
                                widget.models[index].modelName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: 'Tajawal', fontSize: 14.0),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: Text(
                                widget.models[index].features[0].feature,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.grey, fontFamily: 'Tajawal'),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffFFCA37),
                                    borderRadius: BorderRadius.circular(5.0)),
                                height: MediaQuery.of(context).size.height*0.065,
                                child: FlatButton(
                                  onPressed: () async {
                                    await Provider.of<Logic>(context,
                                            listen: false)
                                        .addItemToCart(
                                      CartItemModel(
                                          id: widget.models[index].id,
                                          name: widget.models[index].modelName,
                                          image: widget
                                              .models[index].images[0].images,
                                          amount: 1),
                                    );
                                    showAlertDialogOnOkCallback(
                                      AppLocalizations.of(context).tr(
                                        'dialog.done',
                                      ),
                                      AppLocalizations.of(context).tr(
                                        'dialog.press',
                                      ),
                                      DialogType.SUCCES,
                                      context,
                                      () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CartScreen())),
                                    );
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Icon(
                                            Icons.add_shopping_cart,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            AppLocalizations.of(context).tr(
                                              'home_page.cart',
                                            ),overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Tajawal',
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
