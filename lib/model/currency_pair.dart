import 'package:currency_exchange/service/abstract_api_service.dart';
import 'package:currency_picker/currency_picker.dart';

class CurrencyPair {

  Currency baseCurrency;
  Currency quoteCurrency;
  double exchangeRate ;

  CurrencyPair(
    {
      required this.baseCurrency,
      required this.quoteCurrency,
      required this.exchangeRate
    }
  );

  setBaseCurrency(Currency currency){
    baseCurrency = currency;
  }

  setQuoteCurrency(Currency currency){
    quoteCurrency = currency;
  }

  setExchangeRate() async{
    AbstractApiService _abstractApi = AbstractApiService();
    exchangeRate = await _abstractApi.getExchangeRate(baseCurrency, quoteCurrency);  
  }

  @override
  String toString() {
    return "1.0 ${baseCurrency.code} = ${exchangeRate.toStringAsPrecision(5)} ${quoteCurrency.code}";
  }
}