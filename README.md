How to Run?
    Step 1 - Open Prolific Interactive.xcodeproj file from the directory after checking out from BitBucket ( https://pranav_bhandari@bitbucket.org/pranav_bhandari/prolificinteractive.git ).
    Step 2 - Run the application by pressing cmd + R or the play button.

This is an iOS Application which tracks who has which book from the library. The app is entirely
Built in swift 4. Users can add new books, checkout books, delete single book or the whole collection and can edit basic details of a book. The app tracks the user who has checked out the book by maintaining there name and checkout date timestamp.

Book’s Information : -
We are maintaining all of the book’s information by using a struct that holds the information of various books in a model class called BookDetails.swift. The structure of the struct is as follows :-

struct BookDetails: Decodable {
var author: String?
var categories: String?
var id: Int?
var lastCheckedOut: String?
var lastCheckedOutBy: String?
var publisher: String?
var title: String?
var url: String?
}

Additionally to improve the UI of the app, we tried to maintain a consistent uiview and uibutton layout throughout the app using designable class :- StyledButtons.swift & UIView+Utils.swift. We are able to control various properties such as corner radius, background color, border width etc within a single class rather than having the need to write it in every class.

StyledButtons.swift :-
@IBDesignable class StyledButtons: UIButton {
@IBInspectable var cornerRadius: CGFloat = 0 {
didSet {
self.layer.cornerRadius = cornerRadius
}
}

@IBInspectable var backgroundClr: UIColor = UIColor.clear {
didSet {
self.layer.backgroundColor = backgroundClr.cgColor
}
}

@IBInspectable var borderClr: UIColor = UIColor.clear {
didSet {
self.layer.borderColor = borderClr.cgColor
}
}

@IBInspectable var borderWidth: CGFloat = 0 {
didSet {
self.layer.borderWidth = borderWidth
}
}
}

We are using UITableView to display all the books (It is also our home screen). We are using custom UITableViewCells which has fields the fields to display Book Title, Authors, Image and check-out person name.

BooksTableiewCell.swift :-
class BooksTableViewCell: UITableViewCell {

@IBOutlet weak var bookTitle: UILabel!
@IBOutlet weak var bookAuthors: UILabel!
@IBOutlet weak var bookCheckedOutBy: UILabel!
@IBOutlet weak var bookImage: UIImageView!

override func awakeFromNib() {
super.awakeFromNib()
// Initialization code
}

}
￼

Complete book details are displayed in the BookDetailsViewController.swift class. We are displaying a pop-up view when someone wants to checkout a book or wants to edit the existing details of a book. Only book title, author, publisher and categories/tags can be changed or edited currently. While checking out a book, name is mandatory in order to track the user. The user can also share the book’s title using the share button.
￼
We can add a new book using the ‘+’ icon in the home screen. The user has to enter details like title, author, publisher and tags to add a new book. All the fields are mandatory and it will display an alert if any of the field is missing. On the other hand, if the information is filled and user accidentally presses the done button, it will display an alert message saying book not submitted.
￼
The user can delete a single book from the book’s details page or can delete all the books from the home screen by touching delete all button. An alert will be shown in either of the case.
￼

