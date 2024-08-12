//
//  InfoView.swift
//  CoctelApp
//
//  Created by Jose David Bustos H on 11-08-24.
//

import Foundation
import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Info")
                .font(.largeTitle)
                .padding(.bottom, 20)
        }
        .padding() 
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
