import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

const Color appColor = Color(0xFF6C63FF);

Currency usd = Currency(
  code: "USD", 
  name: "US Dollar", 
  symbol: "\$", 
  flag: "flag", 
  number: 1, 
  decimalDigits: 1, 
  namePlural: "namePlural", 
  symbolOnLeft: true, 
  decimalSeparator: ".", 
  thousandsSeparator: ",", 
  spaceBetweenAmountAndSymbol: true
);

PreferredSizeWidget appBarContainer(){
  return AppBar(
    title: const Text(
      'Currency Exchange',
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
      )
    ),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: Colors.white,
  );
}

Widget textContainer(String text){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24,),
      ),
    );
  }

  Widget currencyCodeContainer(code){
    return appContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical:10.0),
        child: Row(
          children: [
            Text(
              code,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
      dropdown: true
    );
  }

  Widget currencySymbolContainer(String symbol){
    return appContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical:10.0),
        child: Text(
          symbol,
          style: TextStyle(fontSize: 35,color: appColor),
        ),
      ),
    );
}

  Widget loadingContainer(){
    return SizedBox(
      width: 20.0, height: 20.0,
      child: CircularProgressIndicator(color: appColor)
    );
  }
 
  Widget appContainer({required Widget child, bool dropdown = false}){
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: dropdown ? Colors.white : const Color(0xFF6C63FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(style: BorderStyle.solid, color: Colors.white, width: 0.5),
      ),
      child: child,
    );
  }