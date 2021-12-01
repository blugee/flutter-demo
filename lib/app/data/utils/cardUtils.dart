import 'package:flutter/material.dart';
import 'package:mocci/app/data/constants.dart';

enum CardType {
  otherBrand,
  mastercard,
  visa,
  americanExpress,
  discover,
  Maestro
}

/// Credit Card prefix patterns as of March 2019
/// A [List<String>] represents a range.
/// i.e. ['51', '55'] represents the range of cards starting with '51' to those starting with '55'
Map<CardType, Set<List<String>>> cardNumPatterns =
    <CardType, Set<List<String>>>{
  CardType.visa: <List<String>>{
    <String>['4'],
  },
  CardType.americanExpress: <List<String>>{
    <String>['34'],
    <String>['37'],
  },
  CardType.discover: <List<String>>{
    <String>['6011'],
    <String>['622126', '622925'],
    <String>['644', '649'],
    <String>['65']
  },
  CardType.mastercard: <List<String>>{
    <String>['51', '55'],
    <String>['2221', '2229'],
    <String>['223', '229'],
    <String>['23', '26'],
    <String>['270', '271'],
    <String>['2720'],
  },
  CardType.Maestro: <List<String>>{
    <String>['500000', '509999'],
    <String>['560000', '589999'],
    <String>['600000', '699999'],
  },
};

/// This function determines the Credit Card type based on the cardPatterns
/// and returns it.
CardType detectCCType(String cardNumber) {
  //Default card type is other
  CardType cardType = CardType.otherBrand;

  if (cardNumber.isEmpty) {
    return cardType;
  }

  cardNumPatterns.forEach(
    (CardType type, Set<List<String>> patterns) {
      for (List<String> patternRange in patterns) {
        // Remove any spaces
        String ccPatternStr = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        final int rangeLen = patternRange[0].length;
        // Trim the Credit Card number string to match the pattern prefix length
        if (rangeLen < cardNumber.length) {
          ccPatternStr = ccPatternStr.substring(0, rangeLen);
        }

        if (patternRange.length > 1) {
          // Convert the prefix range into numbers then make sure the
          // Credit Card num is in the pattern range.
          // Because Strings don't have '>=' type operators
          final int ccPrefixAsInt = int.parse(ccPatternStr);
          final int startPatternPrefixAsInt = int.parse(patternRange[0]);
          final int endPatternPrefixAsInt = int.parse(patternRange[1]);
          if (ccPrefixAsInt >= startPatternPrefixAsInt &&
              ccPrefixAsInt <= endPatternPrefixAsInt) {
            // Found a match
            cardType = type;
            break;
          }
        } else {
          // Just compare the single pattern prefix with the Credit Card prefix
          if (ccPatternStr == patternRange[0]) {
            // Found a match
            cardType = type;
            break;
          }
        }
      }
    },
  );

  return cardType;
}

Widget getCardTypeIcon(String cardNumber) {
  String img = "";
  Icon icon;
  switch (detectCCType(cardNumber)) {
    case CardType.mastercard:
      img = 'mastercard.png';
      break;
    case CardType.visa:
      img = 'visa.png';
      break;
    case CardType.Maestro:
      img = 'Maestro.png';
      break;
    case CardType.americanExpress:
      img = 'american_express.png';
      break;
    case CardType.discover:
      img = 'discover.png';
      break;
    case CardType.otherBrand:
      icon = Icon(
        Icons.credit_card,
        size: 35.0,
        color: Colors.grey[600],
      );
      break;
    default:
      icon = Icon(
        Icons.warning,
        size: 40.0,
        color: Colors.grey[600],
      );
      break;
  }
  Widget widget;
  if (img.isNotEmpty) {
    widget = Image.asset(
      'assets/images/$img',
      width: 40.0,
    );
  } else {
    widget = icon;
  }
  return widget;
}

//   static getCardTypeFrmNumber(String input) {
//     CardType cardType;
//     if (input.startsWith(RegExp(
//         r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
//       cardType = CardType.Master;
//     } else if (input.startsWith(RegExp(r'[4]'))) {
//       cardType = CardType.Visa;
//     } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
//       cardType = CardType.Verve;
//     } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
//       cardType = CardType.AmericanExpress;
//     } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
//       cardType = CardType.Discover;
//     } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
//       cardType = CardType.DinersClub;
//     } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
//       cardType = CardType.Jcb;
//     } else if (input.length <= 8) {
//       cardType = CardType.Others;
//     } else {
//       cardType = CardType.Invalid;
//     }
//     return cardType;
//   }
// }
