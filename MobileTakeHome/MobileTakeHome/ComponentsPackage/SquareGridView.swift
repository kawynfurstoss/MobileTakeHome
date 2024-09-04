//
//  SquareGridView.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import SwiftUI

struct SquareGridView<Item, Content>: View where Item: Identifiable, Content: View {
    
    let items: [Item]
    let columns: Int
    let spacing: CGFloat
    let columnWidth: CGFloat
    let content: (Item) -> Content
    
    init(items: [Item], columns: Int = 3, spacing: CGFloat = Padding.none,columnWidth: CGFloat, @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.columns = columns
        self.spacing = spacing
        self.columnWidth = columnWidth
        self.content = content
    }
    
    
    var body: some View {
        let numColumns = Array(repeating: GridItem(.fixed(columnWidth), spacing: spacing), count: columns)
        ScrollView {
            LazyVGrid(columns: numColumns, spacing: spacing) {
                ForEach(items) { item in
                    content(item)
                }
            }
            .padding(.top, Padding.extraLarge * 5)
        }
    }
}
