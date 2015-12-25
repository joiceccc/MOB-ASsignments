
import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var clickme: UIButton!

    @IBOutlet weak var label1: UILabel!
    
    @IBAction func clickme(sender: AnyObject) {
        
        
        label1.text = "Hello World!"
    label1.textColor = UIColor .blueColor()
        clickme.hidden = true
        
    }
    
    @IBAction func enter(sender: AnyObject) {
        
        
        var name:String = nametextfield.text!
       
        
        var age =  agetextfield.text!
        
        
        
        
        
        
        
        
        
        
        
        
        resultlabel.text = "hello " + name + ", your age is " + age
        enterlabel.hidden = true
        
       
        
        
        
    
        if (age >= "21") {
            agedo.text = " You can drive, vote and drink (but not in the same time) "}
        else if ( age >= "18")
        { agedo.text = " You can drive and vote"}
        else if (age >= "16")
        { agedo.text = " you can drive"}
        else  {agedo.text = " Under aged"}
        
        
        
     
        
    }
    
    @IBOutlet weak var enterlabel: UIButton!
    @IBOutlet weak var nametextfield: UITextField!
    
    @IBOutlet weak var agetextfield: UITextField!
    
    @IBOutlet weak var resultlabel: UILabel!
    
    
    @IBOutlet weak var agedo: UILabel!
    
    
    
    
    
    
  /*
  TODO one: hook up a button in interface builder to a new action (to be written) in this class. Also hook up the label to this class. When the button is clicked, the function to be written must make a label say ‘hello world!’
  
  TODO two: Connect the ‘name’ and ‘age’ text boxes to this class. Hook up the button to a NEW action (in addition to the function previously defined). That function must look at the string entered in the text box and print out “Hello {name}, you are {age} years old!”
  TODO three: Hook up the button to a NEW action (in addition to the two above). Print “You can drink” below the above text if the user is above 21. If they are above 18, print “you can vote”. If they are above 16, print “You can drive”
  TODO four: Hook up the button to a NEW action (in additino to the three above). Print “you can drive” if the user is above 16 but below 18. It should print “You can drive and vote” if the user is above 18 but below 21. If the user is above 21, it should print “you can drive, vote and drink (but not at the same time!”.
  */
}
