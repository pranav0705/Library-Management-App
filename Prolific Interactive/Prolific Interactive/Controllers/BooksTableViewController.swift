//
//  BooksTableViewController.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/21/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {

    var bookDetails = [BookDetails]()
    var imageNumbers = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBooks()
    }
    
    func fetchBooks() {
        let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/books")!
        
        URLSession.shared.dataTask(with: url) {data,response,error in
            guard error == nil else {
                return
            }
            
            //checking response
            do {
                self.bookDetails = try JSONDecoder().decode([BookDetails].self, from: data!)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let jsonError {
                print("Error parsing jsonData :- \(jsonError)")
            }
        }.resume()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "books", for: indexPath) as! BooksTableViewCell
        cell.bookTitle.text = bookDetails[indexPath.row].title
        cell.bookAuthors.text = bookDetails[indexPath.row].author
        
        if let checkedOutBy = bookDetails[indexPath.row].lastCheckedOutBy {
            cell.bookCheckedOutBy.text = "Last Checked out by : \(checkedOutBy)"
        } else {
            cell.bookCheckedOutBy.text = ""
        }
        
        if let imageNumExists = imageNumbers[indexPath.row] {
            let image : UIImage = UIImage(named:"Book\(imageNumExists)")!
            cell.bookImage.image = image
        } else {
            let bookNum = arc4random_uniform(5) + 1;
            imageNumbers[indexPath.row] = String(bookNum)
            let image : UIImage = UIImage(named:"Book\(String(bookNum))")!
            cell.bookImage.image = image
        }
        
        
        
        let content : UIView = cell.viewWithTag(2) as UIView!
        content.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0.0
        let myVIew : UIView = cell.viewWithTag(1) as UIView!
        myVIew.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        myVIew.layer.shadowOffset = CGSize.zero
        myVIew.layer.shadowRadius = 4
        myVIew.layer.shadowOpacity = 0.8
        myVIew.layer.shadowPath = UIBezierPath(rect: myVIew.bounds).cgPath
        myVIew.layer.masksToBounds = false
        myVIew.layer.shouldRasterize = true
        
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    @IBAction func pressedDeleteBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete all Books?", message: "Do you really want to delete all books?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/clean")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            var headers = request.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = headers
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else {
                    return
                }
                
                if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                    print("All book Deleted: ", utf8Representation)
                    self.fetchBooks()
                    
                } else {
                    print("All book not deleted")
                    self.fetchBooks()
                }
            }
            task.resume()
        }))
        self.present(alert, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "bookDetailsSegue" {
            let indexPath = tableView.indexPathForSelectedRow
            let cell = self.tableView.cellForRow(at: indexPath!) as! BooksTableViewCell
            
            let viewController = segue.destination as! BookDetailsViewController
            
            viewController.receivedBookTitle = bookDetails[(indexPath?.row)!].title
            viewController.receivedBookAuthor = bookDetails[(indexPath?.row)!].author
            viewController.receivedBookPublisher = bookDetails[(indexPath?.row)!].publisher
            viewController.receivedBookTags = bookDetails[(indexPath?.row)!].categories
            viewController.receivedBookLastCheckedOut = bookDetails[(indexPath?.row)!].lastCheckedOutBy
            viewController.receivedId = String(describing: bookDetails[(indexPath?.row)!].id!)
            viewController.receivedBookLastCheckedOutTime = bookDetails[(indexPath?.row)!].lastCheckedOut
            viewController.receivedImage = cell.bookImage.image
        }
    }
}
