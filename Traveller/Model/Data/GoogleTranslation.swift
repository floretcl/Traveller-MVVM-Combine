//
//  GoogleTranslation.swift
//  Traveller
//
//  Created by Clément FLORET on 01/04/2022.
//

import Foundation
import Combine

protocol GoogleTranslation {
    func getTranslation(text: String, source: String, target: String) -> AnyPublisher<TranslationBasicResponse, APIIssue>
    func parseTranslation<TranslationBasicResponse: Decodable>(urlComponents: URLComponents) -> AnyPublisher<TranslationBasicResponse, APIIssue>
    func decode<TranslationBasicResponse: Decodable>(_ data: Data) -> AnyPublisher<TranslationBasicResponse, APIIssue>
    func getComponents(text: String, source: String, target: String) -> URLComponents
}

struct TranslationBasicResponse: Decodable {
    var data: Data
    
    struct Data: Decodable {
        var translations: [Translations]
    }
    
    struct Translations: Decodable {
        var translatedText: String
    }
}

enum NamelangAvlbleGgleTransl: String, CaseIterable {
    case Afrikaans = "Afrikaans"
    case Amharic = "Amharic"
    case Arabic = "Arabic"
    case Azerbaijani = "Azerbaijani"
    case Belarusian = "Belarusian"
    case Bulgarian = "Bulgarian"
    case Bengali = "Bengali"
    case Bosnian = "Bosnian"
    case Catalan = "Catalan"
    case Cebuano = "Cebuano"
    case Corsican = "Corsican"
    case Czech = "Czech"
    case Welsh = "Welsh"
    case Danish = "Danish"
    case German = "German"
    case Greek = "Greek"
    case English = "English"
    case Esperanto = "Esperanto"
    case Spanish = "Spanish"
    case Estonian = "Estonian"
    case Basque = "Basque"
    case Persian = "Persian"
    case Finnish = "Finnish"
    case French = "French"
    case Western_Frisian = "Western Frisian"
    case Irish = "Irish"
    case Gaelic = "Gaelic"
    case Galician = "Galician"
    case Gujarati = "Gujarati"
    case Hausa = "Hausa"
    case Hawaiian = "Hawaiian"
    case Hebrew = "Hebrew"
    case Hindi = "Hindi"
    case Hmong = "Hmong"
    case Croatian = "Croatian"
    case Haitian = "Haitian"
    case Hungarian = "Hungarian"
    case Armenian = "Armenian"
    case Indonesian = "Indonesian"
    case Igbo = "Igbo"
    case Icelandic = "Icelandic"
    case Italian = "Italian"
    case Japanese = "Japanese"
    case Javanese = "Javanese"
    case Georgian = "Georgian"
    case Kazakh = "Kazakh"
    case Khmer = "Khmer"
    case Kannada = "Kannada"
    case Korean = "Korean"
    case Kurdish = "Kurdish"
    case Kirghiz = "Kirghiz"
    case Latin = "Latin"
    case Luxembourgish = "Luxembourgish"
    case Lao = "Lao"
    case Lithuanian = "Lithuanian"
    case Latvian = "Latvian"
    case Malagasy = "Malagasy"
    case Maori = "Maori"
    case Macedonian = "Macedonian"
    case Malayalam = "Malayalam"
    case Mongolian = "Mongolian"
    case Marathi = "Marathi"
    case Malay = "Malay"
    case Maltese = "Maltese"
    case Burmese = "Burmese"
    case Nepali = "Nepali"
    case Dutch = "Dutch"
    case Norwegian = "Norwegian"
    case Chichewa = "Chichewa"
    case Oriya = "Oriya"
    case Panjabi = "Panjabi"
    case Polish = "Polish"
    case Pashto = "Pashto"
    case Portuguese = "Portuguese"
    case Romanian = "Romanian"
    case Russian = "Russian"
    case Kinyarwanda = "Kinyarwanda"
    case Sindhi = "Sindhi"
    case Sinhala = "Sinhala"
    case Slovak = "Slovak"
    case Slovenian = "Slovenian"
    case Samoan = "Samoan"
    case Shona = "Shona"
    case Somali = "Somali"
    case Albanian = "Albanian"
    case Serbian = "Serbian"
    case Sotho = "Sotho"
    case Sundanese = "Sundanese"
    case Swedish = "Swedish"
    case Swahili = "Swahili"
    case Tamil = "Tamil"
    case Telugu = "Telugu"
    case Tajik = "Tajik"
    case Thai = "Thai"
    case Turkmen = "Turkmen"
    case Tagalog = "Tagalog"
    case Turkish = "Turkish"
    case Tatar = "Tatar"
    case Uighur = "Uighur"
    case Ukrainian = "Ukrainian"
    case Urdu = "Urdu"
    case Uzbek = "Uzbek"
    case Vietnamese = "Vietnamese"
    case Xhosa = "Xhosa"
    case Yiddish = "Yiddish"
    case Yoruba = "Yoruba"
    case Chinese = "Chinese"
    case Chinese_CN = "Chinese (CN)"
    case Chinese_TW = "Chinese (TW)"
    case Zulu = "Zulu"
    
    var name: String { self.rawValue }
}

var langAvlbleGgleTransl: [String:String] = [
    "af":"Afrikaans",
    "am":"Amharic",
    "ar":"Arabic",
    "az":"Azerbaijani",
    "be":"Belarusian",
    "bg":"Bulgarian",
    "bn":"Bengali",
    "bs":"Bosnian",
    "ca":"Catalan",
    "ceb":"Cebuano",
    "co":"Corsican",
    "cs":"Czech",
    "cy":"Welsh",
    "da":"Danish",
    "de":"German",
    "el":"Greek",
    "en":"English",
    "eo":"Esperanto",
    "es":"Spanish",
    "et":"Estonian",
    "eu":"Basque",
    "fa":"Persian",
    "fi":"Finnish",
    "fr":"French",
    "fy":"Western Frisian",
    "ga":"Irish",
    "gd":"Gaelic",
    "gl":"Galician",
    "gu":"Gujarati",
    "ha":"Hausa",
    "haw":"Hawaiian",
    "he":"Hebrew",
    "hi":"Hindi",
    "hmn":"Hmong",
    "hr":"Croatian",
    "ht":"Haitian",
    "hu":"Hungarian",
    "hy":"Armenian",
    "id":"Indonesian",
    "ig":"Igbo",
    "is":"Icelandic",
    "it":"Italian",
    "iw":"Hebrew",
    "ja":"Japanese",
    "jw":"Javanese",
    "ka":"Georgian",
    "kk":"Kazakh",
    "km":"Khmer",
    "kn":"Kannada",
    "ko":"Korean",
    "ku":"Kurdish",
    "ky":"Kirghiz",
    "la":"Latin",
    "lb":"Luxembourgish",
    "lo":"Lao",
    "lt":"Lithuanian",
    "lv":"Latvian",
    "mg":"Malagasy",
    "mi":"Maori",
    "mk":"Macedonian",
    "ml":"Malayalam",
    "mn":"Mongolian",
    "mr":"Marathi",
    "ms":"Malay",
    "mt":"Maltese",
    "my":"Burmese",
    "ne":"Nepali",
    "nl":"Dutch",
    "no":"Norwegian",
    "ny":"Chichewa",
    "or":"Oriya",
    "pa":"Panjabi",
    "pl":"Polish",
    "ps":"Pashto",
    "pt":"Portuguese",
    "ro":"Romanian",
    "ru":"Russian",
    "rw":"Kinyarwanda",
    "sd":"Sindhi",
    "si":"Sinhala",
    "sk":"Slovak",
    "sl":"Slovenian",
    "sm":"Samoan",
    "sn":"Shona",
    "so":"Somali",
    "sq":"Albanian",
    "sr":"Serbian",
    "st":"Sotho",
    "su":"Sundanese",
    "sv":"Swedish",
    "sw":"Swahili",
    "ta":"Tamil",
    "te":"Telugu",
    "tg":"Tajik",
    "th":"Thai",
    "tk":"Turkmen",
    "tl":"Tagalog",
    "tr":"Turkish",
    "tt":"Tatar",
    "ug":"Uighur",
    "uk":"Ukrainian",
    "ur":"Urdu",
    "uz":"Uzbek",
    "vi":"Vietnamese",
    "xh":"Xhosa",
    "yi":"Yiddish",
    "yo":"Yoruba",
    "zh":"Chinese",
    "zh-CN":"Chinese (CN)",
    "zh-TW":"Chinese (TW)",
    "zu":"Zulu"]
