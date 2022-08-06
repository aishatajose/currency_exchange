import 'package:currency_exchange/abstract_api.dart';

class ExchangeCurrency {
  String  fromCurrencyCode;
  String toCurrencyCode;

  String fromCurrencySymbol;
  String toCurrencySymbol;

  double rate ;
  double result;
  double input;

  ExchangeCurrency(
    {
      this.fromCurrencyCode = "USD",
      this.toCurrencyCode = "USD",
      this.fromCurrencySymbol = "\$",
      this.toCurrencySymbol = "\$",
      this.rate = 1.0,
      this.result = 0.0,
      this.input = 0.0,
    }
  );

  setToCurrency(String toCurrencyCode, String toCurrencySymbol) async{
    this.toCurrencyCode = toCurrencyCode;
    this.toCurrencySymbol = toCurrencySymbol;
  }

  setFromCurrency(String fromCurrencyCode, String fromCurrencySymbol) async{
    this.fromCurrencyCode = fromCurrencyCode;
    this.fromCurrencySymbol = fromCurrencySymbol;
  }

  setRate() async{
    AbstractApi _abstractApi = AbstractApi();
    var res = await _abstractApi.get(fromCurrencyCode, toCurrencyCode);    
    rate = res['exchange_rates'][toCurrencyCode].toDouble();
    result = input * rate;
    return result;
  }

  setInput(double input){
    this.input = input;
    result = input * rate;
  }
}