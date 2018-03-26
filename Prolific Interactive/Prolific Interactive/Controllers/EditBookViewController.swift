//
//  EditBookViewController.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/25/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

protocol updateBookDetails {
    func update()
}

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
    var receivedId: String?
    
    var delegate: updateBookDetails!
    
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
    @IBAction func pressedSaveBtn(_ sender: Any) {
        
        
        let json: [String: Any] = ["title": bookNameTxtField.text!,"author":bookAuthorTxtField.text!,"publisher":bookPublisherTxtField.text!,"categories":bookTagsTxtField.text!]
        let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/books/\(String(describing: receivedId!))")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                //
                return
            }
            
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("Edited book: ", utf8Representation)
                if let myDelegate = self.delegate {
                    myDelegate.update()
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                print("Book not edited")
                self.dismiss(animated: true, completion: nil)
            }
        }
        task.resume()
        
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
