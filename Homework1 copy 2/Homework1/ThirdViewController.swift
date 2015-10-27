
import UIKit

class ThirdViewController: UIViewController {
    
    
    
    @IBOutlet weak var evenodd: UILabel!

    @IBOutlet weak var numbertext: UITextField!
    
    
    @IBAction func calculate(sender: AnyObject) {
        var numbers:Int = Int(numbertext.text!)!
        
       
        if (numbers%2 == 0) { evenodd.text = "Even" }
        else { evenodd.text = "Odd"}
            
        
        
    }
    
  /*
  TODO six: Hook up the number input text field, button and text label to this class. When the button is pressed, a message should be printed to the label indicating whether the number is even.
  
  */
}
