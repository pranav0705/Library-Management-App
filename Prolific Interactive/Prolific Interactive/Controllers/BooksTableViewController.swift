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
        return cell
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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "bookDetailsSegue" {
         
            let indexPath = tableView.indexPathForSelectedRow
            let viewController = segue.destination as! BookDetailsViewController
            
            viewController.receivedBookTitle = bookDetails[(indexPath?.row)!].title
            viewController.receivedBookAuthor = bookDetails[(indexPath?.row)!].author
            viewController.receivedBookPublisher = bookDetails[(indexPath?.row)!].publisher
            viewController.receivedBookTags = bookDetails[(indexPath?.row)!].categories
            viewController.receivedBookLastCheckedOut = bookDetails[(indexPath?.row)!].lastCheckedOutBy
            viewController.receivedId = String(describing: bookDetails[(indexPath?.row)!].id!)
            viewController.receivedBookLastCheckedOutTime = bookDetails[(indexPath?.row)!].lastCheckedOut
        }
    }
}
