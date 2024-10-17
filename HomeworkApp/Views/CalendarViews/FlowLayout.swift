import SwiftUI

struct FlowLayout: View {
    let items: [AnyView]
    let itemWidth: CGFloat
    let spacing: CGFloat

    private var columns: [Int] {
        var result = [Int]()
        var currentWidth: CGFloat = 0
        var currentColumn = 0

        for item in items {
            // I arbitrarily found that 78 is the length of 3 of the little circles
            if currentWidth + itemWidth + spacing > 78 {
                result.append(currentColumn)
                currentWidth = 0
                currentColumn = 1
            } else {
                currentColumn += 1
            }
            currentWidth += itemWidth + spacing
        }
        result.append(currentColumn)
        return result
    }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(0..<columns.count, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(0..<columns[rowIndex], id: \.self) { columnIndex in
                        if let item = items[safe: rowIndex * columns[rowIndex] + columnIndex] {
                            item
                        }
                    }
                }
            }
        }
    }
}

// Safe Array Extension to Avoid Out of Bounds Errors
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
