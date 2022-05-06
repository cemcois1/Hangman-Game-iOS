import UIKit

class StartSceneViewController: UIViewController {

    @IBOutlet weak var monPopupButton: UIButton!
    var languageTitle:String = "TR"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CreatePopupMenu()
    }
    @IBAction func CreatePopupMenu(){
        let optionClosure = {(action : UIAction) in
            self.languageTitle = action.title
        }
        
        monPopupButton.menu = UIMenu (children : [
            UIAction(title: "TR", state: .on ,handler: optionClosure),
            UIAction(title: "EN", handler: optionClosure),
            
        ])
      
       
        
        
    }

    @IBAction func Play() {
        ChangeDataSet(languageTitle)
        
    }
     func ChangeDataSet(_ language:String){
        let controller = storyboard?.instantiateViewController(withIdentifier: "GamePage")
         as! GamePageViewController
        
        controller.language = language
        print(language)
    }
 
    

}

