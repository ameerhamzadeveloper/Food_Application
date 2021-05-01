import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturant_list.dart';
import 'package:food_delivery_app/customer_app/model/resturant/resturants_providers.dart';
import 'package:food_delivery_app/customer_app/views/home/resturants/components/item_bottom_shaeet.dart';
import 'package:food_delivery_app/resturant_app/model/menu_list.dart';
import 'package:food_delivery_app/routes/routes_names.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/customer_app/views/home/resturants/components/menu_card.dart';
import 'package:scroll_to_index/scroll_to_index.dart';



class MarkeetstsDetails extends StatefulWidget {

  @override
  _MarkeetstsDetailsState createState() => _MarkeetstsDetailsState();
}

class _MarkeetstsDetailsState extends State<MarkeetstsDetails> {
  AutoScrollController _autoScrollController;
  final scrollDirection = Axis.vertical;

  bool isExpaned = true;
  bool get _isAppBarExpanded {
    return _autoScrollController.hasClients &&
        _autoScrollController.offset > (160 - kToolbarHeight);
  }

  @override
  void initState() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    )..addListener(
          () => _isAppBarExpanded
          ? isExpaned != false
          ? setState(
            () {
          isExpaned = false;
          print('setState is called');
        },
      )
          : {}
          : isExpaned != true
          ? setState(() {
        print('setState is called');
        isExpaned = true;
      })
          : {},
    );
    super.initState();
  }

  Future _scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    _autoScrollController.highlight(index);
  }

  Widget _wrapScrollTag({int index, Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: child,
      highlightColor: Colors.black.withOpacity(0.1),
    );
  }

  _buildSliverAppbar() {
    final pro = Provider.of<MenuLists>(context);
    final pr = Provider.of<NearResturantsProvider>(context);
    return SliverAppBar(
      title: Text(pr.resturantName ?? "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          )),
      brightness: Brightness.light,
      pinned: true,
      // floating: false,
      leading: Row(
        children: [
          SizedBox(width: 10,),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Center(
              child: IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(seconds: 2));
                  pr.clearRestInfo();
                  pr.clearAllCardNItm();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ],
      ),
      expandedHeight: 200.0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        centerTitle: true,
        title: Text(pr.shopInfo[0].bName ?? "",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            )),
        background: Image.network("https://tripps.live/tripp_food/${pr.shopInfo[0].resutrantSelfie}",fit: BoxFit.fill,),
        // background: BackgroundSliverAppBar(),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: isExpaned ? 0.0 : 1,
          child: DefaultTabController(
              length: pro.cardList.length,
              child: Container(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pro.cardList.length,
                  itemBuilder: (ctx,i){
                    return Padding(
                      padding: const EdgeInsets.only(left:12.0,right: 12.0,bottom: 8.0,top: 10),
                      child: InkWell(
                          onTap: (){
                            _scrollToIndex(i);
                          },
                          child: Container(

                            child: Text(pro.cardList[i].cardName,style: TextStyle(fontSize: 20),),
                          )),
                    );
                  },
                ),
              )
          ),
        ),
      ),
    );
  }
  int index;
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<MenuLists>(context);
    final pr = Provider.of<NearResturantsProvider>(context);
    final prov = Provider.of<ResturantList>(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _autoScrollController,
        slivers: [
          _buildSliverAppbar(),
          pr.shopInfo[0].card[0].cardStatus == 0 ? Container() : SliverList(
            delegate: SliverChildBuilderDelegate((context,ind){
              var list = pr.shopInfo;
              index = ind;
              print(index);
              return _wrapScrollTag(index: ind,child:
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            list[0].card[index].cardName,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pr.shopInfo[0].card[index].item != null && pr.shopInfo[0].card[index].item.length > 0 ? pr.shopInfo[0].card[index].item.length : 0,
                        shrinkWrap: true,
                        itemBuilder: (context, inde) {
                          var l = pr.shopInfo[0].card[index].item[inde];
                          if(pr.shopInfo[0].card[index].item[inde].itemStatus == 0){
                            return Center(child: Text("No Items"),);
                          }else{
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => ItemBottomSheet(l:l,pr:pr,list:list));
                                print("cartORderLsit ${pr.cartOrderList.length}");
                                print("cartItems ${pr.cartItems.length}");
                              },
                              child: ListTile(
                                leading: Container(
                                    height: 80,
                                    width: 80,
                                    child: Card(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network("https://tripps.live/tripp_food/${l.itmeImg}",fit: BoxFit.fill,),
                                    ))),
                                title: Text(l.itemName),
                                subtitle: Text(l.itemDescription),
                                trailing: Text("${l.itemPrice} SAR"),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ));
            },
              childCount: pr.shopInfo[0].card.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: pr.cartItems.length == 0 ?
      Container(height: 0,
        width: 0,):
      Container(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
            height: 50,
            color: kThemeColor,
            onPressed: () async{
              await pr.checkUserFiveOrder();
              Navigator.pushNamed(context, cartPage);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 0,
                  width: 0,
                ),
                Text("Go to cart",style: TextStyle(color:Colors.white),),
                CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.white,
                  child: Text("${pr.cartItems.length}"),
                )
              ],
            )
        ),
      ),
    );
  }
  }


