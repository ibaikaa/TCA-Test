//
//  TitleView.swift
//  TCABeta
//
//  Created by ibaikaa on 24/9/23.
//

import SwiftUI

struct TitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(
                .system(
                    size: 24,
                    weight: .bold
                )
                .monospacedDigit()
            )
            .foregroundColor(.black)
            .padding()
    }
}
