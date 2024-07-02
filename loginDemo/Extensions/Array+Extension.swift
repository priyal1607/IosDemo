//
//  Array+Extension.swift

//
//  Created by Savan Ankola on 05/05/21.
//

import UIKit

extension Sequence where Element: Hashable {
    
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    
}

extension Array {
    
    func selectedRange(_ indexes: ClosedRange<Int>) -> [Element] {
        return indexes.compactMap({ self.indices.contains($0) ? self[$0] : nil })
    }
    
    func selectedRange(_ indexes: Range<Int>) -> [Element] {
        return indexes.compactMap({ self.indices.contains($0) ? self[$0] : nil })
    }
    
    
}
