import 'package:pocket_option/domain/models/currency_pair.dart';

const allMockPairs = [
  mockPair1,
  mockPair2,
  mockPair3,
  mockPair4,
  mockPair5,
  mockPair6,
  mockPair7,
  mockPair8,
  mockPair9
];

const mockPair1 = CurrencyPair(one: 'EUR', two: 'USD', description: 'Euros to US Dollars', free: true, koef: 1.0154);
const mockPair2 =
    CurrencyPair(one: 'AUD', two: 'USD', description: 'Australian Dollars to US Dollars', free: true, koef: 0.6874);
const mockPair3 =
    CurrencyPair(one: 'CAD', two: 'USD', description: 'Canadian Dollars to US Dollars', free: true, koef: 0.7764);
const mockPair4 =
    CurrencyPair(one: 'CHF', two: 'USD', description: 'Swiss Francs to US Dollars', free: false, koef: 1.0256);
const mockPair5 = CurrencyPair(one: 'APPL', two: 'USD', description: 'Apple to US Dollars', free: false, koef: 147.07);
const mockPair6 =
    CurrencyPair(one: 'NZD', two: 'USD', description: 'New Zealand Dollars to US Dollars', free: false, koef: 0.6264);
const mockPair7 =
    CurrencyPair(one: 'JPY', two: 'USD', description: 'Japanese Yen to US Dollars', free: false, koef: 0.0072);
const mockPair8 =
    CurrencyPair(one: 'GBP', two: 'USD', description: 'British pounds to US Dollars', free: false, koef: 1.204);
const mockPair9 = CurrencyPair(
    one: 'GE', two: 'USD', description: 'General Electric Company to US Dollars', free: false, koef: 63.689);
