//
//  BookDetailsViewController.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/22/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    var receivedBookTitle: String?
    var receivedBookAuthor: String?
    var receivedBookPublisher: String?
    var receivedBookTags: String?
    var receivedBookLastCheckedOut: String?
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookTags: UILabel!
    @IBOutlet weak var bookLastCheckedOut: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bookTitle.text = receivedBookTitle
        bookAuthor.text = receivedBookAuthor
        bookPublisher.text = "Publisher: \(receivedBookPublisher ?? "N/A")"
        bookTags.text = "Tags: \(receivedBookTags ?? "N/A")"
        bookLastCheckedOut.text = receivedBookLastCheckedOut
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
