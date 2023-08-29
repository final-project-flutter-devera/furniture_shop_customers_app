extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^[a-zA-Z0-9]+[._\-]*[a-zA-Z0-9]*@[a-zA-Z0-9]{2,}[.][a-zA-Z0-9]{2,6}[.]*[a-zA-Z]{0,6}$')
        .hasMatch(this);
  }

}
extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*.*)|(0.))([0-9]{1,2}))$').hasMatch(this);
  }
}

extension DiscountValidator on String {
  bool isValidDiscount() {
    return RegExp(r'^([0-9]*)$').hasMatch(this);
  }
}
