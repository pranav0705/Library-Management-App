//
//  CheckoutViewController.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/23/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

protocol refreshBookDetails {
    func refresh()
}

class CheckoutViewController: UIViewController {

    var receivedBookid: String?
    
    var delegate: refreshBookDetails!
    
    @IBOutlet weak var nameTxtField: UITextField!
    
    @IBAction func didPressedCloseBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didPressSubmitBtn(_ sender: Any) {
       
        if nameTxtField.text == "" {
            let alert = UIAlertController(title: "Field Empty", message: "Name field cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
            let dt = formatter.string(from: Date())
            
            let json: [String: Any] = ["lastCheckedOutBy": nameTxtField.text!,"lastCheckedOut":dt]
            let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/books/\(String(describing: receivedBookid!))")!
            print(url)
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
                    print("Checked out book: ", utf8Representation)
                    if let myDelegate = self.delegate {
                        myDelegate.refresh()
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    
                } else {
                    print("Book not checkedout")
                    self.dismiss(animated: true, completion: nil)
                }
            }
            task.resume()
        }
        
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
