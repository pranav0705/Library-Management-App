//
//  EditBookViewController.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/25/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

class EditBookViewController: UIViewController {

    @IBOutlet weak var bookTagsTxtField: UITextField!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookAuthorTxtField: UITextField!
    @IBOutlet weak var bookPublisherTxtField: UITextField!
    @IBOutlet weak var bookNameTxtField: UITextField!
    
    var receivedImage: UIImage?
    var receivedName: String?
    var receivedAuthor: String?
    var receivedPublisher: String?
    var receivedTags: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        bookNameTxtField.text = receivedName!
        bookAuthorTxtField.text = receivedAuthor!
        bookPublisherTxtField.text = receivedPublisher!
        bookTagsTxtField.text = receivedTags!
        bookImage.image = receivedImage!
    }
    

    @IBAction func pressedCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
