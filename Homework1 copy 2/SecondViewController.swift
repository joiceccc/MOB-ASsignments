
import UIKit

class SecondViewController: UIViewController {
   
    var number:Int = 0
    
    @IBOutlet weak var numbertext: UITextField!
    @IBAction func addbutton(sender: AnyObject) {
        
        
         number =  number + Int(numbertext.text!)!
        
        resultlabel.text = String(number)
        
        
        
        
    }
    
    
    @IBOutlet weak var resultlabel: UILabel!
    
    
  //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.
}
