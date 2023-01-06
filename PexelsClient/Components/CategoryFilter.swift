//
//  CategoryFilter.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/5/23.
//

import SwiftUI

struct CategoryFilter: View {
    var query:Query
    var isSelected:Bool
    var body: some View {
        Text(query.rawValue.capitalized)
            .font(.caption)
            .bold()
            .foregroundColor(isSelected ? .black : .gray)
            .padding(.horizontal,12)
            .padding(.vertical, 8)
            .background(.thinMaterial)
            .cornerRadius(8)
    }
}

struct CategoryFilter_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilter(query:Query.nature,isSelected: true)
    }
}
