import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'GetData.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String setCurrency ='Select Currency';

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await get_data().getData(setCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    // for (int i = 0; i < currenciesList.length; i++) {
    //   String currency = currenciesList[i];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: setCurrency,
      items: dropdownItems, //getDropDownItem()→dropdownItems
      onChanged: (value) {
        setState(() {
          setCurrency = value!;
          getData();
        });
      },
    );
  }


  CupertinoPicker iOsPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedItem) {
        getData();
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: setCurrency,
          value: (isWaiting ? '?' : coinValues[crypto]).toString(),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOsPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}


class CryptoCard extends StatelessWidget {
   final dynamic value;
  final String selectedCurrency;
  final String cryptoCurrency;

  const CryptoCard({
    required this.value,
     required this.selectedCurrency,
    required this.cryptoCurrency,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// DropdownButton<String>(
// value: setCurrency,
// items: getDropDownItem(),
// onChanged: (value) {
// setState(() {
// setCurrency = value!;
// print(value);
// });
// },
// );
//------------------------------------------------//
// List<DropdownMenuItem<String>> getDropDownItems() {
//   List<DropdownMenuItem<String>> dropdownItems = [];
//   // for (int i = 0; i < currenciesList.length; i++) {
//   //   String currency = currenciesList[i];
//   for(String currency in currenciesList){
//     var newItem = DropdownMenuItem(
//       child: Text(currency),
//       value: currency,
//     );
//     dropdownItems.add(newItem);
//   }
//   return dropdownItems;
// }
//------------------------------------------------//
// List<DropdownMenuItem<String>>? getDropDownItem() {
//
//   for (int i = 0; i < currenciesList.length; i++) {
//     String currency = currenciesList[i];
//    var newItem = DropdownMenuItem(
//       child: Text(currency), //DropdownMenuItem as Strings i.e. <DropdownMenuItem<String>>
//       value: currency,
//     );
//     dropdownItems?.add(newItem);
//   }
//   return getDropDownItem();
// }
//------------------------------------------------//

// List<Widget>getpickerItems() {
//   List<Text> pickerItems = [];
//   for (String currency in currenciesList) {
//     pickerItems.add(Text(currency));
//   }
//   return pickerItems;
// }
//------------------------------------------------//
// CupertinoPicker(
// backgroundColor: Colors.lightBlue,
// itemExtent: 32.0,
// onSelectedItemChanged: (selectedItem) {
// print(selectedItem);
// },
// children: getpickerItems(),
// )
//------------------------------------------------//
// Widget?  getPicker(){
//   if(Platform.isIOS){
//     return iOsPicker();
//   }
//   else if(Platform.isAndroid){
//     return getDropdownButton();
//   }
//   return null;
// }