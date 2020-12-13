
import UIKit

class FilterViewController: UITableViewController {
    
    private let numberOfSections: Int = 1
    var arrayOfcategories: [String]? {
        didSet{
            arrayOfcategories?.append("Сбросить все")
            tableView.reloadData()
        }
    }
    
    var arrayOfCategoriesAlreadyChoosen: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @IBAction func doneButtonTapped(_sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegue" {
            let filteredCategories = FilterCell.arrayOfChoosenCategories
            let mainVC = segue.destination as! FeedItemsListViewController
            mainVC.chosenCategories = filteredCategories
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return arrayOfcategories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! FilterCell
        let category = arrayOfcategories?[indexPath.row]
        cell.categoryLabel.text = category
        if arrayOfCategoriesAlreadyChoosen?.contains(category ?? "") ?? false {
            cell.switchState.isOn = true
        }
        if cell.categoryLabel.text == "Сбросить все" && cell.switchState.isOn == true {
            arrayOfCategoriesAlreadyChoosen = []
            
        }
        if cell.switchState.isOn == true {
            arrayOfCategoriesAlreadyChoosen?.append(cell.categoryLabel.text ?? "")
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
