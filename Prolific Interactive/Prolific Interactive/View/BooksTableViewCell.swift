//
//  BooksTableViewCell.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/22/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

class BooksTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookCheckedOutBy: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
