//
//  ExchangeRate.swift
//  Traveller
//
//  Created by Clément FLORET on 07/04/2022.
//

import Foundation
import Combine

protocol ExchangeRate {
    func getCurrencyRate(sourceCurrency: String, targetCurrency: String, value: Double) -> AnyPublisher<LatestRateResponse, APIIssue>
    func parseCurrencyRate<LatestRateResponse: Decodable>(urlComponents: URLComponents) -> AnyPublisher<LatestRateResponse, APIIssue>
    func decode<LatestRateResponse: Decodable>(_ data: Data) -> AnyPublisher<LatestRateResponse, APIIssue>
    func getComponents(sourceCurrency: String, targetCurrency: String, value: Double) -> URLComponents
}

struct LatestRateResponse: Decodable {
    var result: String
    var time_last_update_unix: TimeInterval
    var base_code: String
    var target_code: String
    var conversion_rate: Double
    var conversion_result: Double
}

enum NameAvlDfltCncyCodeExchRate: String, CaseIterable {
    case AED = "UAE Dirham"
    case AFN = "Afghan Afghani"
    case ALL = "Albanian Lek"
    case AMD = "Armenian Dram"
    case ANG = "Netherlands Antillian Guilder"
    case AOA = "Angolan Kwanza"
    case ARS = "Argentine Peso"
    case AUD = "Australian Dollar"
    case AWG = "Aruban Florin"
    case AZN = "Azerbaijani Manat"
    case BAM = "Bosnia and Herzegovina Mark"
    case BBD = "Barbados Dollar"
    case BDT = "Bangladeshi Taka"
    case BGN = "Bulgarian Lev"
    case BHD = "Bahraini Dinar"
    case BIF = "Burundian Franc"
    case BMD = "Bermudian Dollar"
    case BND = "Brunei Dollar"
    case BOB = "Bolivian Boliviano"
    case BRL = "Brazilian Real"
    case BSD = "Bahamian Dollar"
    case BTN = "Bhutanese Ngultrum"
    case BWP = "Botswana Pula"
    case BYN = "Belarusian Ruble"
    case BZD = "Belize Dollar"
    case CAD = "Canadian Dollar"
    case CDF = "Congolese Franc"
    case CHF = "Swiss Franc"
    case CLP = "Chilean Peso"
    case CNY = "Chinese Renminbi"
    case COP = "Colombian Peso"
    case CRC = "Costa Rican Colon"
    case CUP = "Cuban Peso"
    case CVE = "Cape Verdean Escudo"
    case CZK = "Czech Koruna"
    case DJF = "Djiboutian Franc"
    case DKK = "Danish Krone"
    case DOP = "Dominican Peso"
    case DZD = "Algerian Dinar"
    case EGP = "Egyptian Pound"
    case ERN = "Eritrean Nakfa"
    case ETB = "Ethiopian Birr"
    case EUR = "Euro"
    case FJD = "Fiji Dollar"
    case FKP = "Falkland Islands Pound"
    case FOK = "Faroese Króna"
    case GBP = "Pound Sterling"
    case GEL = "Georgian Lari"
    case GGP = "Guernsey Pound"
    case GHS = "Ghanaian Cedi"
    case GIP = "Gibraltar Pound"
    case GMD = "Gambian Dalasi"
    case GNF = "Guinean Franc"
    case GTQ = "Guatemalan Quetzal"
    case GYD = "Guyanese Dollar"
    case HKD = "Hong Kong Dollar"
    case HNL = "Honduran Lempira"
    case HRK = "Croatian Kuna"
    case HTG = "Haitian Gourde"
    case HUF = "Hungarian Forint"
    case IDR = "Indonesian Rupiah"
    case ILS = "Israeli New Shekel"
    case IMP = "Manx Pound"
    case INR = "Indian Rupee"
    case IQD = "Iraqi Dinar"
    case IRR = "Iranian Rial"
    case ISK = "Icelandic Króna"
    case JEP = "Jersey Pound"
    case JMD = "Jamaican Dollar"
    case JOD = "Jordanian Dinar"
    case JPY = "Japanese Yen"
    case KES = "Kenyan Shilling"
    case KGS = "Kyrgyzstani Som"
    case KHR = "Cambodian Riel"
    case KID = "Kiribati Dollar"
    case KMF = "Comorian Franc"
    case KRW = "South Korean Won"
    case KWD = "Kuwaiti Dinar"
    case KYD = "Cayman Islands Dollar"
    case KZT = "Kazakhstani Tenge"
    case LAK = "Lao Kip"
    case LBP = "Lebanese Pound"
    case LKR = "Sri Lanka Rupee"
    case LRD = "Liberian Dollar"
    case LSL = "Lesotho Loti"
    case LYD = "Libyan Dinar"
    case MAD = "Moroccan Dirham"
    case MDL = "Moldovan Leu"
    case MGA = "Malagasy Ariary"
    case MKD = "Macedonian Denar"
    case MMK = "Burmese Kyat"
    case MNT = "Mongolian Tögrög"
    case MOP = "Macanese Pataca"
    case MRU = "Mauritanian Ouguiya"
    case MUR = "Mauritian Rupee"
    case MVR = "Maldivian Rufiyaa"
    case MWK = "Malawian Kwacha"
    case MXN = "Mexican Peso"
    case MYR = "Malaysian Ringgit"
    case MZN = "Mozambican Metical"
    case NAD = "Namibian Dollar"
    case NGN = "Nigerian Naira"
    case NIO = "Nicaraguan Córdoba"
    case NOK = "Norwegian Krone"
    case NPR = "Nepalese Rupee"
    case NZD = "New Zealand Dollar"
    case OMR = "Omani Rial"
    case PAB = "Panamanian Balboa"
    case PEN = "Peruvian Sol"
    case PGK = "Papua New Guinean Kina"
    case PHP = "Philippine Peso"
    case PKR = "Pakistani Rupee"
    case PLN = "Polish Złoty"
    case PYG = "Paraguayan Guaraní"
    case QAR = "Qatari Riyal"
    case RON = "Romanian Leu"
    case RSD = "Serbian Dinar"
    case RUB = "Russian Ruble"
    case RWF = "Rwandan Franc"
    case SAR = "Saudi Riyal"
    case SBD = "Solomon Islands Dollar"
    case SCR = "Seychellois Rupee"
    case SDG = "Sudanese Pound"
    case SEK = "Swedish Krona"
    case SGD = "Singapore Dollar"
    case SHP = "Saint Helena Pound"
    case SLL = "Sierra Leonean Leone"
    case SOS = "Somali Shilling"
    case SRD = "Surinamese Dollar"
    case SSP = "South Sudanese Pound"
    case STN = "São Tomé and Príncipe Dobra"
    case SYP = "Syrian Pound"
    case SZL = "Eswatini Lilangeni"
    case THB = "Thai Baht"
    case TJS = "Tajikistani Somoni"
    case TMT = "Turkmenistan Manat"
    case TND = "Tunisian Dinar"
    case TOP = "Tongan Paʻanga"
    case TRY = "Turkish Lira"
    case TTD = "Trinidad and Tobago Dollar"
    case TVD = "Tuvaluan Dollar"
    case TWD = "New Taiwan Dollar"
    case TZS = "Tanzanian Shilling"
    case UAH = "Ukrainian Hryvnia"
    case UGX = "Ugandan Shilling"
    case USD = "United States Dollar"
    case UYU = "Uruguayan Peso"
    case UZS = "Uzbekistani So'm"
    case VES = "Venezuelan Bolívar Soberano"
    case VND = "Vietnamese Đồng"
    case VUV = "Vanuatu Vatu"
    case WST = "Samoan Tālā"
    case XAF = "Central African CFA Franc"
    case XCD = "East Caribbean Dollar"
    case XDR = "Special Drawing Rights"
    case XOF = "West African CFA franc"
    case XPF = "CFP Franc"
    case YER = "Yemeni Rial"
    case ZAR = "South African Rand"
    case ZMW = "Zambian Kwacha"
    case ZWL = "Zimbabwean Dollar"
    
    var name: String { self.rawValue }
}

var avlDfltCncyCodeExchRate: [String: String] = [
    "AED":"UAE Dirham",
    "AFN":"Afghan Afghani",
    "ALL":"Albanian Lek",
    "AMD":"Armenian Dram",
    "ANG":"Netherlands Antillian Guilder",
    "AOA":"Angolan Kwanza",
    "ARS":"Argentine Peso",
    "AUD":"Australian Dollar",
    "AWG":"Aruban Florin",
    "AZN":"Azerbaijani Manat",
    "BAM":"Bosnia and Herzegovina Mark",
    "BBD":"Barbados Dollar",
    "BDT":"Bangladeshi Taka",
    "BGN":"Bulgarian Lev",
    "BHD":"Bahraini Dinar",
    "BIF":"Burundian Franc",
    "BMD":"Bermudian Dollar",
    "BND":"Brunei Dollar",
    "BOB":"Bolivian Boliviano",
    "BRL":"Brazilian Real",
    "BSD":"Bahamian Dollar",
    "BTN":"Bhutanese Ngultrum",
    "BWP":"Botswana Pula",
    "BYN":"Belarusian Ruble",
    "BZD":"Belize Dollar",
    "CAD":"Canadian Dollar",
    "CDF":"Congolese Franc",
    "CHF":"Swiss Franc",
    "CLP":"Chilean Peso",
    "CNY":"Chinese Renminbi",
    "COP":"Colombian Peso",
    "CRC":"Costa Rican Colon",
    "CUP":"Cuban Peso",
    "CVE":"Cape Verdean Escudo",
    "CZK":"Czech Koruna",
    "DJF":"Djiboutian Franc",
    "DKK":"Danish Krone",
    "DOP":"Dominican Peso",
    "DZD":"Algerian Dinar",
    "EGP":"Egyptian Pound",
    "ERN":"Eritrean Nakfa",
    "ETB":"Ethiopian Birr",
    "EUR":"Euro",
    "FJD":"Fiji Dollar",
    "FKP":"Falkland Islands Pound",
    "FOK":"Faroese Króna",
    "GBP":"Pound Sterling",
    "GEL":"Georgian Lari",
    "GGP":"Guernsey Pound",
    "GHS":"Ghanaian Cedi",
    "GIP":"Gibraltar Pound",
    "GMD":"Gambian Dalasi",
    "GNF":"Guinean Franc",
    "GTQ":"Guatemalan Quetzal",
    "GYD":"Guyanese Dollar",
    "HKD":"Hong Kong Dollar",
    "HNL":"Honduran Lempira",
    "HRK":"Croatian Kuna",
    "HTG":"Haitian Gourde",
    "HUF":"Hungarian Forint",
    "IDR":"Indonesian Rupiah",
    "ILS":"Israeli New Shekel",
    "IMP":"Manx Pound",
    "INR":"Indian Rupee",
    "IQD":"Iraqi Dinar",
    "IRR":"Iranian Rial",
    "ISK":"Icelandic Króna",
    "JEP":"Jersey Pound",
    "JMD":"Jamaican Dollar",
    "JOD":"Jordanian Dinar",
    "JPY":"Japanese Yen",
    "KES":"Kenyan Shilling",
    "KGS":"Kyrgyzstani Som",
    "KHR":"Cambodian Riel",
    "KID":"Kiribati Dollar",
    "KMF":"Comorian Franc",
    "KRW":"South Korean Won",
    "KWD":"Kuwaiti Dinar",
    "KYD":"Cayman Islands Dollar",
    "KZT":"Kazakhstani Tenge",
    "LAK":"Lao Kip",
    "LBP":"Lebanese Pound",
    "LKR":"Sri Lanka Rupee",
    "LRD":"Liberian Dollar",
    "LSL":"Lesotho Loti",
    "LYD":"Libyan Dinar",
    "MAD":"Moroccan Dirham",
    "MDL":"Moldovan Leu",
    "MGA":"Malagasy Ariary",
    "MKD":"Macedonian Denar",
    "MMK":"Burmese Kyat",
    "MNT":"Mongolian Tögrög",
    "MOP":"Macanese Pataca",
    "MRU":"Mauritanian Ouguiya",
    "MUR":"Mauritian Rupee",
    "MVR":"Maldivian Rufiyaa",
    "MWK":"Malawian Kwacha",
    "MXN":"Mexican Peso",
    "MYR":"Malaysian Ringgit",
    "MZN":"Mozambican Metical",
    "NAD":"Namibian Dollar",
    "NGN":"Nigerian Naira",
    "NIO":"Nicaraguan Córdoba",
    "NOK":"Norwegian Krone",
    "NPR":"Nepalese Rupee",
    "NZD":"New Zealand Dollar",
    "OMR":"Omani Rial",
    "PAB":"Panamanian Balboa",
    "PEN":"Peruvian Sol",
    "PGK":"Papua New Guinean Kina",
    "PHP":"Philippine Peso",
    "PKR":"Pakistani Rupee",
    "PLN":"Polish Złoty",
    "PYG":"Paraguayan Guaraní",
    "QAR":"Qatari Riyal",
    "RON":"Romanian Leu",
    "RSD":"Serbian Dinar",
    "RUB":"Russian Ruble",
    "RWF":"Rwandan Franc",
    "SAR":"Saudi Riyal",
    "SBD":"Solomon Islands Dollar",
    "SCR":"Seychellois Rupee",
    "SDG":"Sudanese Pound",
    "SEK":"Swedish Krona",
    "SGD":"Singapore Dollar",
    "SHP":"Saint Helena Pound",
    "SLL":"Sierra Leonean Leone",
    "SOS":"Somali Shilling",
    "SRD":"Surinamese Dollar",
    "SSP":"South Sudanese Pound",
    "STN":"São Tomé and Príncipe Dobra",
    "SYP":"Syrian Pound",
    "SZL":"Eswatini Lilangeni",
    "THB":"Thai Baht",
    "TJS":"Tajikistani Somoni",
    "TMT":"Turkmenistan Manat",
    "TND":"Tunisian Dinar",
    "TOP":"Tongan Paʻanga",
    "TRY":"Turkish Lira",
    "TTD":"Trinidad and Tobago Dollar",
    "TVD":"Tuvaluan Dollar",
    "TWD":"New Taiwan Dollar",
    "TZS":"Tanzanian Shilling",
    "UAH":"Ukrainian Hryvnia",
    "UGX":"Ugandan Shilling",
    "USD":"United States Dollar",
    "UYU":"Uruguayan Peso",
    "UZS":"Uzbekistani So'm",
    "VES":"Venezuelan Bolívar Soberano",
    "VND":"Vietnamese Đồng",
    "VUV":"Vanuatu Vatu",
    "WST":"Samoan Tālā",
    "XAF":"Central African CFA Franc",
    "XCD":"East Caribbean Dollar",
    "XDR":"Special Drawing Rights",
    "XOF":"West African CFA franc",
    "XPF":"CFP Franc",
    "YER":"Yemeni Rial",
    "ZAR":"South African Rand",
    "ZMW":"Zambian Kwacha",
    "ZWL":"Zimbabwean Dollar"
]
