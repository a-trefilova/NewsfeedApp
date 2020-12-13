
import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var categoryLabel: UILabel! 
 
    static var arrayOfChoosenCategories = [""] {
        didSet {
            print(arrayOfChoosenCategories)
        }
    }
    var categoryIsChosen = false
    
    
    @IBAction func switchOnTapped(_ sender: UISwitch) {
        categoryIsChosen = !categoryIsChosen
        guard let category = categoryLabel.text else { return }
        if categoryIsChosen == true && !FilterCell.arrayOfChoosenCategories.contains(category)  {
         FilterCell.arrayOfChoosenCategories.append(category)
            
        } else {
         FilterCell.arrayOfChoosenCategories.removeAll { string in
                string == category
         }
        }
        
    }
    
}
