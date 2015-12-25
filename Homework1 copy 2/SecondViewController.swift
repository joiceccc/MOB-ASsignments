
import UIKit

class SecondViewController: UIViewController {
   
    var num:Int = 0
    
    @IBOutlet weak var numbertext: UITextField!
    @IBAction func addbutton(sender: AnyObject) {
        
        
        var add = Int(numbertext.text!)
        
        
        if let number = add {
            
        num = num + number
        
        resultlabel.text = String(num)
        
        
        } else { resultlabel.text = "not a number" }
        
    }
    
    
    @IBOutlet weak var resultlabel: UILabel!
    
    
  //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.
}
