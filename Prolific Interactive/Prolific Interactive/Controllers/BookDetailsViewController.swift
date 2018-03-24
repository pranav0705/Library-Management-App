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
    var receivedId: String?
    var receivedBookLastCheckedOutTime: String?
    
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookTags: UILabel!
    @IBOutlet weak var bookLastCheckedOut: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
        
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
//        let UTCDate = dateFormatter.date(from: receivedBookLastCheckedOutTime!)
//
//        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm a" // Output Format
//        dateFormatter.timeZone = TimeZone.current
//        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
//
//        let date = dateFormatter.date(from: receivedBookLastCheckedOutTime!) //according to date format your date string
//        print(receivedBookLastCheckedOutTime!)
//        print(UTCDate!)
//        print(date ?? "") //Convert String to Date
//        print(UTCToCurrentFormat)
//        if date != nil {
//            dateFormatter.dateFormat = "MMM d, yyyy HH:mm a" //Your New Date format as per requirement change it own
//            let newDate = dateFormatter.string(from: date!) //pass Date here
//            print(newDate) //New formatted Date string
//
//            bookLastCheckedOut.text = "\(String(describing: receivedBookLastCheckedOut)) @ \(newDate)"
//
//        }
        
        
        
    }

    func setupUI() {
        
        bookTitle.text = receivedBookTitle
        bookAuthor.text = receivedBookAuthor
        bookPublisher.text = "Publisher: \(receivedBookPublisher ?? "N/A")"
        bookTags.text = "Tags: \(receivedBookTags ?? "N/A")"
        
        if receivedBookLastCheckedOutTime == nil {
            bookLastCheckedOut.text = ""
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
            
            let utcDate = dateFormatter.date(from: receivedBookLastCheckedOutTime!)
            
            dateFormatter.dateFormat = "MMM d, yyyy hh:mm a"
            dateFormatter.timeZone = TimeZone.current
            let checkedOutTimeInLocal = dateFormatter.string(from: utcDate!)
            
            bookLastCheckedOut.text = "\(receivedBookLastCheckedOut!) @ \(checkedOutTimeInLocal)"
        }
        
    }
    
    @IBAction func pressedCheckoutBtn(_ sender: Any) {
    }
   
    @IBAction func pressedDeleteBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Book?", message: "Do you want to delete this book?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/books/\(self.receivedId!)")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else {
                    //
                    return
                }
                
                if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                    print("Book Deleted: ", utf8Representation)
                    self.popUpViewController()
                } else {
                    print("Book not deleted")
                    self.popUpViewController()
                }
            }
            task.resume()
        }))
        self.present(alert, animated: true)
       
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "openCheckoutPopUpSegue" {
            let viewController = segue.destination as! CheckoutViewController
            viewController.delegate = self
            viewController.receivedBookid = receivedId!
        }
        
    }

}

extension BookDetailsViewController: refreshBookDetails {
    func refresh() {
        
        let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/books/\(receivedId!)")!
        
        URLSession.shared.dataTask(with: url) {data,response,error in
            //checking error
            
            //checking response
            do {
                guard let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any] else { return }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
                
                let utcDate = dateFormatter.date(from: json["lastCheckedOut"]! as! String)
                
                dateFormatter.dateFormat = "MMM d, yyyy hh:mm a"
                dateFormatter.timeZone = TimeZone.current
                let checkedOutTimeInLocal = dateFormatter.string(from: utcDate!)
                
                DispatchQueue.main.async {
                    self.bookLastCheckedOut.text = "\(json["lastCheckedOutBy"]!) @ \(checkedOutTimeInLocal)"
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
            }.resume()
        
    }
    
    func popUpViewController() {
        DispatchQueue.main.async {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
