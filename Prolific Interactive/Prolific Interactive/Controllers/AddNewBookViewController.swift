//
//  AddNewBookViewController.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/22/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

class AddNewBookViewController: UIViewController {

    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var bookPublisher: UITextField!
    @IBOutlet weak var bookCategories: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        submitBtn.layer.cornerRadius = 8
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedDoneBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedSubmitBtn(_ sender: Any) {
        if bookTitle.text == "" || bookAuthor.text == "" || bookPublisher.text == "" || bookCategories.text == "" {
            
            let alert = UIAlertController(title: "Field Missing", message: "You must fill all the fields in order to submit", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            let json: [String: Any] = ["author": bookAuthor.text!,
                                       "categories": bookCategories.text!,
                                       "title": bookTitle.text!,
                                       "publisher": bookPublisher.text!]

            let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/books")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
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
                    print("Added new book: ", utf8Representation)
                } else {
                    print("No response")
                }
            }
            task.resume()
        }
        
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
