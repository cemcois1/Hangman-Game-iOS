import UIKit

class GamePageViewController: UIViewController {

    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var displayWorldLabel: UILabel!
    @IBOutlet weak var gameEndImage: UIImageView!
    @IBOutlet weak var hangmanImage: UIImageView!
    

    //data sonra kelimeleri xml dosyasından çekeceğim
    var wordArray = ["DENEMEK","HAVUZ","TESTERE"]
    
    var word:String = ""
    
    var wrongLettersArray = [Character]()
    
    var usedLetters = [Character]()
    
    var displayWord = ""
    
    var displayWordArray = [Character]()
    
    var guess:Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        word=wordArray.randomElement()!
        
        usedLetters = Array(word)
        
        print(word)
        for _ in 1...word.count {
            displayWord+="?"
            
            displayWorldLabel.text = displayWord
            displayWordArray=Array(displayWord)
        }
    }
    
    @IBAction func guessButton(_ sender: UIButton) {
        let valueChanged = guessTextField.resignFirstResponder()
        
        let guess1 = guessTextField.text
        if guess1 == "" {
            guessTextField.placeholder="Enter a letter"
        } else if guess1!.count > 1 {
            guessTextField.placeholder="Enter a one letter"
        }
        else {
            guess = Character(guessTextField.text!.capitalized)
            checkForLetter()
            displayWord = String(displayWordArray)
            displayWorldLabel.text = displayWord
            guessTextField.text=""
            checkForWin()
        }

    }
    func checkForLetter(){
        if usedLetters.contains(guess){
            for i in 0...word.count-1
            {
                if guess == usedLetters[i] {
                    displayWordArray[i] = guess
                }
            }
            
        } else{
            wrongLettersArray.append(guess)
            wrongLetters.text = String(wrongLettersArray)
            placeImage()
        }
        
        
    }
    func placeImage(){
        print( "Çopadam  asılıyor")
        let p1 = UIImage(named: "pic1")
        let p2 = UIImage(named: "pic2")
        let p3 = UIImage(named: "pic3")
        let p4 = UIImage(named: "pic4")
        let p5 = UIImage(named: "pic5")
        let p6 = UIImage(named: "pic6")
        let p7 = UIImage(named: "pic7")
        let p8 = UIImage(named: "pic8")
        
        let imageArray = [p1,p2,p3,p4,p5,p6,p7,p8]
        
        hangmanImage.image=imageArray[wrongLettersArray.count-1]
        
    }
    @IBAction func resetButton(_ sender: UIButton) {
        guessTextField.text = ""
        hangmanImage.image = UIImage(contentsOfFile: "")
        gameEndImage.image = UIImage(contentsOfFile: "")
        wrongLettersArray = []
        wrongLetters.text = ""
        displayWord = ""
        displayWordArray = []
        
        word = wordArray.randomElement()!
        usedLetters = Array(word)
        
        for _ in 1...word.count {
            displayWord+="?"
            
            displayWorldLabel.text = displayWord
            displayWordArray=Array(displayWord)
        }
    }
    func checkForWin(){
        if wrongLettersArray.count==8 {
            gameEndImage.image = UIImage(named: "gameOver")
        } else if displayWord.contains("?"){
            
        } else {
            gameEndImage.image = UIImage(named: "youWin")
        }
        
    }
    
}
