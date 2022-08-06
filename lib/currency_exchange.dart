import 'package:currency_exchange/exchange.dart';
import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyExchangeScreen extends StatefulWidget {
  const CurrencyExchangeScreen({ Key? key }) : super(key: key);

  @override
  State<CurrencyExchangeScreen> createState() => _CurrencyExchangeScreenState();
}


class _CurrencyExchangeScreenState extends State<CurrencyExchangeScreen> {
  final Color appColor = const Color(0xFF6C63FF);
  ExchangeCurrency exchangeCurrency = ExchangeCurrency();
  bool isLoading  = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),

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
              "1.00000 ${exchangeCurrency.fromCurrencyCode} = ${exchangeCurrency.rate.toStringAsPrecision(5)} ${exchangeCurrency.toCurrencyCode}",
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
              currencySymbolContainer(exchangeCurrency.fromCurrencySymbol),

              InkWell(
                onTap: (){
                  setState(() { isLoading = true; });
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) async{
                        await exchangeCurrency.setFromCurrency(currency.code, currency.symbol);
                        setState(() {});
                        await exchangeCurrency.setRate();
                        setState(() { isLoading = false; });
                    },
                  );
                },
                child: currencyCodeContainer(exchangeCurrency.fromCurrencyCode)
              ),

              const SizedBox(width: 20,),

              Expanded(
                child: appContainer(
                  child: TextField(
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
                        double val = value == '' ? 0: double.parse(value);
                        exchangeCurrency.setInput(val);
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
              currencySymbolContainer(exchangeCurrency.toCurrencySymbol),
              InkWell(
                onTap: () async{
                  setState(() { isLoading = true; });
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showCurrencyCode: true,
                    onSelect: (Currency currency) async{
                      await exchangeCurrency.setToCurrency(currency.code, currency.symbol);
                      setState(() {});
                      await exchangeCurrency.setRate();
                      setState(() { isLoading = false; });
                    },
                  );
                
                  
                },
                child: currencyCodeContainer(exchangeCurrency.toCurrencyCode)
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: appContainer(
                  child: Center(
                    child: isLoading? loadingContainer()
                    :Text(
                      exchangeCurrency.result.toStringAsPrecision(3),
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
}



