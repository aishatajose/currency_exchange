import 'package:flutter/material.dart';

import 'package:currency_exchange/model/currency_pair.dart';
import 'package:currency_exchange/view/widget.dart';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyExchangeScreen extends StatefulWidget {
  const CurrencyExchangeScreen({ Key? key }) : super(key: key);

  @override
  State<CurrencyExchangeScreen> createState() => _CurrencyExchangeScreenState();
}


class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  final Color appColor = const Color(0xFF6C63FF);
  bool isLoading  = false;

  CurrencyPair currencyPair = CurrencyPair(
    baseCurrency: usd, 
    quoteCurrency: usd, 
    exchangeRate: 1.0
  );

  double input = 0.0;
  double exchangeResult = 0.0;
  TextEditingController controller  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarContainer(),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal:25.0, vertical: 20),
        children: [

          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0, top:10.0, bottom: 50),
            child: SvgPicture.asset('assets/image.svg', height: 180,),
          ),

          Center(
            child: isLoading? loadingContainer()
            :Text(
              currencyPair.toString(),
              style: TextStyle(
                fontSize: 16,
                color: appColor ,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(height: 40,),

          textContainer('From'),

          Row(
            children: [
              currencySymbolContainer(currencyPair.baseCurrency.symbol),

              InkWell(
                onTap: (){
                  setState(() { isLoading = true; });
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) async{
                        await currencyPair.setBaseCurrency(currency);
                        setState(() {});
                        await currencyPair.setExchangeRate();
                        exchangeResult = input * currencyPair.exchangeRate;
                        setState(() { isLoading = false; });
                    },
                  );
                },
                child: currencyCodeContainer(currencyPair.baseCurrency.code)
              ),

              const SizedBox(width: 20,),

              Expanded(
                child: appContainer(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(fontSize: 30,color: appColor),
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle: TextStyle(fontSize: 30,color: appColor),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0)
                    ),
                  
                    onChanged: (value){
                      setState(() {
                        input = value == '' ? 0: double.parse(value);
                        exchangeResult = input * currencyPair.exchangeRate;
                      });
                    },
                  ),
                ),
              ),
            
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SvgPicture.asset('assets/ftarrowheads.svg', height: 40),
          ),

          textContainer('To'),

          Row(
            children: [
              currencySymbolContainer(currencyPair.quoteCurrency.symbol),
              InkWell(
                onTap: () async{
                  setState(() { isLoading = true; });
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) async{
                      await currencyPair.setQuoteCurrency(currency);
                      setState(() {});
                      await currencyPair.setExchangeRate();
                      exchangeResult = input * currencyPair.exchangeRate;
                      setState(() { isLoading = false; });
                    },
                  );
                  
                },
                child: currencyCodeContainer(currencyPair.quoteCurrency.code)
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: appContainer(
                  child: Center(
                    child: isLoading? loadingContainer()
                    :Text(
                      exchangeResult.toStringAsPrecision(5),
                      style: TextStyle( fontSize: 30, color: appColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



