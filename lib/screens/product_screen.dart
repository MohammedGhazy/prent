import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prent/provider_service/product_service.dart';
import 'package:prent/screens/descreption_screen.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductScreen extends StatefulWidget {
  final int productID;

  ProductScreen(this.productID);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Color(0xffFFCA37),
        ),
        body: FutureBuilder(
          future: Provider.of<Category>(context, listen: false)
              .fetchProductData(widget.productID),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapShot.error != null) {
                return Center(
                  child: Image.asset('assets/images/no.png',height: 150.0,width: 150.0,color: Color(0xffF7B600)),
                );
              }
              return Consumer<Category>(
                  builder: (context, data, child) => Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.productModel.data.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, left: 15.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(1.0),
                                              spreadRadius: 1.0,
                                              blurRadius:
                                                  2, // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Image.network(
                                                  data.productModel.data[index]
                                                      .images[0].images,
                                                  width: 120,
                                                  height: 120,
                                                ),

                                              Expanded(
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                       Container(
                                                         //width: MediaQuery.of(context).size.width*0.35,
                                                         child:  Text(data
                                                             .productModel
                                                             .data[index]
                                                             .modelName,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                       ),


                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      DescriptionScreen(
                                                                        productModel: data
                                                                            .productModel
                                                                            .data[index],
                                                                        type:
                                                                            'product',
                                                                      )));
                                                        },
                                                        child: Text(
                                                          'أعرض المنتج',
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                        color: Color(0xffFFCA37),
                                                      ),
                                                    ],
                                                  ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ],
                      )));
            }
          },
        ));
  }
}
