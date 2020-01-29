import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:prent/provider.dart';
import 'package:provider/provider.dart';
import 'package:prent/screens/complete_transaction_form.dart';
import '../model/cartItemModel.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget buildItem(BuildContext context, int index, List<CartItemModel> items) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 12.0, left: 12, top: 8.0, bottom: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: <Widget>[
            InkWell(
              onTap: () {
                Provider.of<Logic>(context, listen: false).removeItem(index);
                setState(() {});
              },
              child: Container(
                  height: 25.0,
                  width: 25.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25.0)),
                  alignment: Alignment.topRight,
                  child: Center(
                      child: Text('X', style: TextStyle(color: Colors.white)))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(width: 150, child: Text(items[index].name)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      items[index].image,
                      height: 120.0,
                      width: 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.green),
                            child: InkWell(
                                onTap: () {
                                  Provider.of<Logic>(context, listen: false)
                                      .addItemToCart(
                                    CartItemModel(
                                      id: items[index].id,
                                      image: items[index].image,
                                      amount: items[index].amount,
                                      name: items[index].name,
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                    child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white),
                            child: Center(
                              child: Text(items[index].amount.toString()),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            onTap: () {
                              Provider.of<Logic>(context, listen: false)
                                  .removeAmount(items[index].id);
                              setState(() {});
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.red),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> getItems() async {
    Provider.of<Logic>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    getItems();
    final List<CartItemModel> items =
        Provider.of<Logic>(context, listen: false).cartList;
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        appBar: AppBar(
          backgroundColor: Color(0xffFFCA37),
          title: Text(
            AppLocalizations.of(context).tr(
              'cart.cart',
            ),
            style: TextStyle(fontFamily: 'Tajawal', color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: items.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Image.asset('assets/images/cart.png',height: 150.0,width: 150.0,)),
            SizedBox(height: 10.0,),
          ],
        )
            : ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white),
                          child: Center(
                            child: Text(items.length.toString()),
                          ),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          AppLocalizations.of(context).tr(
                            'cart.prod',
                          ),
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return buildItem(context, index, items);
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => CompleteTransactionScreen(
                                      name: items,
                                    )));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.green,
                                    size: 10.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                AppLocalizations.of(context).tr(
                                  'cart.done',
                                ),
                                style: TextStyle(
                                    fontFamily: 'Tajawal', color: Colors.white),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ));
  }
}
