//
//  PrimaryButton.swift
//  TCABeta
//
//  Created by ibaikaa on 24/9/23.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(8)
    }
}
