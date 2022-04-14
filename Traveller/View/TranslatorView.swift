//
//  TranslatorView.swift
//  Traveller
//
//  Created by Clément FLORET on 05/04/2022.
//

import SwiftUI

struct TranslatorView: View {
    @StateObject var googleTranslation = GoogleTranslationVM()
    @StateObject var textEditorManager = TextEditorManager(charLimit: 150)
    
    let characterLimit: Int = 150
    @State private var textTarget: String = ""
    @State private var totalChars = 0
    
    @State private var selectionSrcLang: String = "Unknown"
    @State private var selectionTgtLang: String = "Unknown"
    @Binding var srcLangCode: String
    @Binding var tgtLangCode: String
    
    @State var isTranslated: Bool = false
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                VStack {
                    HStack {
                        Image(systemName: "chevron.compact.down")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                    }.padding(geometry.size.width/25)
                    HStack {
                        Picker(selectionSrcLang, selection: $selectionSrcLang) {
                            AvailableLanguagesList()
                        }.onChange(of: selectionSrcLang, perform: { selection in
                            if let key = getLangCodeWithSelection(selection: selection) {
                                self.srcLangCode = key
                            }
                        }).pickerStyle(.menu)
                        Text("to")
                            .foregroundColor(.accentColor)
                        Picker(selectionTgtLang, selection: $selectionTgtLang) {
                            AvailableLanguagesList()
                        }.onChange(of: selectionTgtLang, perform: { selection in
                            if let key = getLangCodeWithSelection(selection: selection) {
                                self.tgtLangCode = key
                            }
                        }).pickerStyle(.menu)
                        Button {
                            // swap variables
                            (selectionSrcLang, selectionTgtLang) = (selectionTgtLang, selectionSrcLang)
                            (srcLangCode, tgtLangCode) = (tgtLangCode, srcLangCode)
                            textEditorManager.textInput = textTarget
                            textTarget = ""
                        } label: {
                            Image(systemName: "arrow.left.arrow.right")
                                .font(.title2)
                        }
                    }
                    TextEditorWithBackground(text: $textEditorManager.textInput, color: Color("SdColor"))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.accentColor)
                        .padding(.horizontal, 8)
                        .cornerRadius(10)
                        .frame(minHeight: 130 , maxHeight: .infinity, alignment: .center)
                        .onChange(of: textEditorManager.textInput, perform: { text in
                            self.totalChars = textEditorManager.textInput.count
                        }).onTapGesture {
                            isTranslated = false
                        }
                    ProgressView(value: Double(totalChars), total: Double(characterLimit)) {
                        HStack {
                            Spacer()
                            Text("\(totalChars) / \(characterLimit) chars")
                                .foregroundColor(.white)
                                .accentColor(.accentColor)
                            
                        }
                    }
                    .padding(.horizontal, 8)
                    Button {
                        googleTranslation.requestTranslationBasic(
                            text: textEditorManager.textInput,
                            source: srcLangCode,
                            target: tgtLangCode)
                        isTranslated = true
                    } label: {
                        Text("Translate")
                            .foregroundColor(.accentColor)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                            .padding(5)
                    }
                    .disabled(textEditorManager.textInput.isBlank)
                    .padding(.vertical, geometry.size.height/80)
                }
                if isTranslated {
                    VStack {
                        TextEditorWithBackground(text: $textTarget, color: Color("SdColor"))
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.accentColor)
                            .padding(.horizontal, 8)
                            .cornerRadius(10)
                            .frame(minHeight: 150, maxHeight: 300, alignment: .center)
                            .disabled(true)
                    }
                    .padding(.bottom, 20).ignoresSafeArea(.keyboard, edges: .bottom)
                }
                Spacer()
            }
            .background(Color("BackgroundColor"))
            .onChange(of: googleTranslation.basicTranslatedTexts, perform: { newValue in
                self.textTarget = newValue.first ?? "..."
            })
            .onAppear {
                self.selectionSrcLang = langAvlbleGgleTransl[srcLangCode] ?? "English"
                self.selectionTgtLang = langAvlbleGgleTransl[tgtLangCode] ?? "English"
            }
            .onTapGesture {
                hideKeyboard()
        }
        }
    }
    
    func getLangCodeWithSelection(selection: String) -> String? {
        if let langCode = langAvlbleGgleTransl.someKey(forValue: selection) {
            return langCode
        } else {
            return nil
        }
    }
}

struct TranslatorView_Previews: PreviewProvider {
    static var previews: some View {
        TranslatorView(srcLangCode: .constant("en"), tgtLangCode: .constant("fr"))
    }
}
