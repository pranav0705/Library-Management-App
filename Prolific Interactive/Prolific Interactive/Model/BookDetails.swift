//
//  BookDetails.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/21/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import Foundation
import UIKit

struct BookDetails: Decodable {
    var author: String
    var categories: String
    var id: Int
    var lastCheckedOut: String?
    var lastCheckedOutBy: String?
    var title: String
    var url: String
}
