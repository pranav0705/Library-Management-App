//
//  DateFormatter+Util.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/23/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let displayMonthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm a"
        return dateFormatter
    }()
    
}
