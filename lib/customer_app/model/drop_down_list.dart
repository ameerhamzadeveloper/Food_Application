class OrderDropDown{
  final String namel;
  OrderDropDown({this.namel});
  static List<OrderDropDown> nameList(){
    return <OrderDropDown>[
      OrderDropDown(namel: "Track Delivery Boy"),
      OrderDropDown(namel: "Resolution Center")
    ];
  }
}