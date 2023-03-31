enum Month {
  jan,
  feb,
  march,
  apr,
  may,
  jun,
  july,
  aug,
  sep,
  oct,
  nov,
  dev
}

enum PaymentStatus {
  unpaid,
  paying,
  paid
}


class Product {
  String productName;
  double price;
  Month paymentMonth;
  PaymentStatus paymentStatus;

  Product({
    required this.productName,
    required this.price, //unit is milion
    required this.paymentMonth,
    required this.paymentStatus
  });
}