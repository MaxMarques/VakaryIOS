//
//  HelpView.swift
//  Vakary
//
//  Created by Marques on 13/12/2022.
//

import SwiftUI

struct HelpView: View {
    @State private var selectedItem: Int? = nil
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                List {
                    ForEach(0..<faqItems.count, id: \.self) { index in
                        DisclosureGroup(
                            isExpanded: Binding(
                                get: { selectedItem == index },
                                set: { newValue in
                                    selectedItem = newValue ? index : nil
                                }
                            ),
                            content: {
                                Text(LocalizedStringKey(faqItems[index].answer))
                                    .padding()
                            },
                            label: {
                                Text(LocalizedStringKey(faqItems[index].question))
                                    .font(.headline)
                            }
                        )
                    }
                }
                .navigationBarTitle(LocalizedStringKey("helpV1"))
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}

struct FAQItem {
    var question: String
    var answer: String
}

let faqItems: [FAQItem] = [
    FAQItem(question: "helpV2", answer: "helpV3"),
    FAQItem(question: "helpV4", answer: "helpV5"),
    FAQItem(question: "helpV6", answer: "helpV7"),
    FAQItem(question: "helpV8", answer: "helpV9"),
    FAQItem(question: "helpV10", answer: "helpV11"),
    FAQItem(question: "helpV12", answer: "helpV13"),
    FAQItem(question: "helpV14", answer: "helpV15"),
    FAQItem(question: "helpV16", answer: "helpV17"),
    FAQItem(question: "helpV18", answer: "helpV19"),
    FAQItem(question: "helpV20", answer: "helpV21"),
    FAQItem(question: "helpV22", answer: "helpV23"),
    FAQItem(question: "helpV24", answer: "helpV25"),
    FAQItem(question: "helpV26", answer: "helpV27")
]

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
