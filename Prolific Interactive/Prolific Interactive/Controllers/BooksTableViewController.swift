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
        
        let url = URL(string: "http://prolific-interview.herokuapp.com/5ab048aac98af80009c78420/books")!
        
        URLSession.shared.dataTask(with: url) {data,response,error in
            //checking error
            
            //checking response
            do {
                self.bookDetails = try JSONDecoder().decode([BookDetails].self, from: data!)
                DispatchQueue.main.async { // Correct
                    self.tableView.reloadData()
                }
                
                
                
            } catch let jsonError {
                print("Error parsing jsonData :- \(jsonError)")
            }
            
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "books", for: indexPath) as! BooksTableViewCell

        // Configure the cell...
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let viewController = segue.destination as! BookDetailsViewController
        
        viewController.receivedBookTitle = bookDetails[(indexPath?.row)!].title
        
    }
 

}
