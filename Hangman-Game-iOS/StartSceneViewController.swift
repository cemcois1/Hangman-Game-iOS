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

    @IBAction func test() {
        ChangeDataSet(languageTitle)
        
    }
    func ChangeDataSet(_ language:String){
        print(language)
    }
 
    
}

