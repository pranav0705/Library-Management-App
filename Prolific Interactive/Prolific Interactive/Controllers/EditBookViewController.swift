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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
