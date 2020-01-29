import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scroll_gallery/flutter_scroll_gallery.dart';
import 'package:prent/components/cart_button.dart';
import 'package:prent/model/product_model.dart';
import 'package:prent/model/category_model.dart';
import 'package:prent/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import '../provider.dart';
import 'package:prent/model/search_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../model/cartItemModel.dart';

class DescriptionScreen extends StatefulWidget {
  final MyData productModel;
  final Models subModel;
  final DataSearch dataSearch;
  final String type;

  DescriptionScreen(
      {this.subModel, this.productModel, this.type, this.dataSearch});

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  Widget feature(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.info,
          color: Color(0xffFFCA37),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.70,
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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

    List<NetworkImage> viewedImages = [];
    List<Widget> features = [];
    if (widget.type == 'sub') {
      for (var image in widget.subModel.images) {
        final NetworkImage imageProvider = NetworkImage(image.images);
        viewedImages.add(imageProvider);
      }
      for (var index in widget.subModel.features) {
        final item = feature(index.feature);
        features.add(item);
      }
    } else if (widget.type == 'search') {
      for (var image in widget.dataSearch.images) {
        final NetworkImage imageProvider = NetworkImage(image.images);
        viewedImages.add(imageProvider);
      }
      for (var index in widget.dataSearch.features) {
        final item = feature(index.feature);
        features.add(item);
      }
    } else {
      for (var image in widget.productModel.images) {
        final NetworkImage imageProvider = NetworkImage(image.images);
        viewedImages.add(imageProvider);
      }
      for (var index in widget.productModel.features) {
        final item = feature(index.feature);
        features.add(item);
      }
    }
    return widget.type == 'sub'
        ? Scaffold(
            backgroundColor: Color(0xfff4f4f4),
            appBar: AppBar(
              backgroundColor: Color(0xffFFCA37),
              title: Text(
                widget.subModel.modelName,
                style: TextStyle(fontFamily: "Tajawal"),
              ),
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              actions: <Widget>[
                shoppingCartIconButton(context),
              ],
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: ScrollGallery(
                    viewedImages,
                    borderColor: Color(0xffFFCA37),
                    thumbnailSize: 40.0,
                  ),
                ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.subModel.modelName,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context).tr(
                      'desc_page.desc',
                    ),
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      widget.subModel.description,
                      style:
                          TextStyle(color: Colors.black, fontFamily: "Tajawal"),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context).tr(
                      'desc_page.adv',
                    ),
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.black,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: features,
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF7B600),
                        borderRadius: BorderRadius.circular(5.0)),
                    height: 40.0,
                    child: FlatButton(
                      onPressed: () {
                        Provider.of<Logic>(context, listen: false)
                            .addItemToCart(
                          CartItemModel(
                            id: widget.subModel.id,
                            name: widget.subModel.modelName,
                            amount: 1,
                            image: widget.subModel.images[0].images,
                          ),
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
                            () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen())));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).tr(
                              'home_page.cart',
                            ),
                            style: TextStyle(
                                fontFamily: 'Tajawal',
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : widget.type == 'search'
            ?
            //search---------------------------------
            Scaffold(
                backgroundColor: Color(0xfff4f4f4),
                appBar: AppBar(
                  backgroundColor: Color(0xffFFCA37),
                  title: Text(
                    widget.dataSearch.modelName,
                    style: TextStyle(fontFamily: "Tajawal"),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  actions: <Widget>[
                    shoppingCartIconButton(context),
                  ],
                ),
                body: ListView(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ScrollGallery(
                        viewedImages,
                        borderColor: Color(0xffFFCA37),
                        thumbnailSize: 40.0,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.dataSearch.modelName,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).tr(
                          'desc_page.desc',
                        ),
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                      child: Container(
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          widget.dataSearch.description,
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Tajawal"),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).tr(
                          'desc_page.adv',
                        ),
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: Colors.black,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: features,
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffF7B600),
                            borderRadius: BorderRadius.circular(5.0)),
                        height: 40.0,
                        child: FlatButton(
                          onPressed: () {
                            Provider.of<Logic>(context, listen: false)
                                .addItemToCart(
                              CartItemModel(
                                  id: widget.dataSearch.id,
                                  name: widget.dataSearch.modelName,
                                  amount: 1,
                                  image: widget.dataSearch.images[0].images),
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
                                        builder: (context) => CartScreen())));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).tr(
                                  'home_page.cart',
                                ),
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    color: Colors.white,
                                    fontSize: 18.0),
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: Color(0xfff4f4f4),
                appBar: AppBar(
                  backgroundColor: Color(0xffFFCA37),
                  title: Text(
                    widget.productModel.modelName,
                    style: TextStyle(fontFamily: "Tajawal"),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  actions: <Widget>[
                    shoppingCartIconButton(context),
                  ],
                ),
                body: ListView(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ScrollGallery(
                        viewedImages,
                        borderColor: Color(0xffFFCA37),
                        thumbnailSize: 40.0,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.productModel.modelName,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).tr(
                          'desc_page.desc',
                        ),
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 12.0),
                      child: Container(
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          widget.productModel.description,
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Tajawal"),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).tr(
                          'desc_page.adv',
                        ),
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: Colors.black,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: features,
                              )
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffF7B600),
                            borderRadius: BorderRadius.circular(5.0)),
                        height: 40.0,
                        child: FlatButton(
                          onPressed: () {
                            Provider.of<Logic>(context, listen: false)
                                .addItemToCart(
                              CartItemModel(
                                  id: widget.productModel.id,
                                  name: widget.productModel.modelName,
                                  amount: 1,
                                  image: widget.productModel.images[0].images),
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
                                        builder: (context) => CartScreen())));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).tr(
                                  'home_page.cart',
                                ),
                                style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    color: Colors.white,
                                    fontSize: 18.0),
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
