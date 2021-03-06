import UIKit

class GamePageViewController: UIViewController ,XMLParserDelegate  {
    
    @IBOutlet weak var displayWorldLabel: UILabel!
    @IBOutlet weak var gameEndImage: UIImageView!
    @IBOutlet weak var hangmanImage: UIImageView!
    
    var UsedButtons = [UIButton]()

    var word:String = ""
    
    @IBOutlet weak var LanguageText: UILabel!
    var wrongLettersArray = [Character]()
    
    var usedLetters = [Character]()
    
    var displayWord = ""
    
    var displayWordArray = [Character]()
    
    var guess:Character!
    var words = [String] ()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LanguageText.text = "Language :" + AppDelegate.lang
        dump(AppDelegate.lang + " is Language ")
        word = GetWordFromXML( AppDelegate.lang)
        
        usedLetters = Array(word)
        
        print(word + " is Word")
        for _ in 1...word.count {
            displayWord+="?"
            
            displayWorldLabel.text = displayWord
            displayWordArray=Array(displayWord)
        }
    }
    func GetWordFromXML(_ lang:String) -> String {
        var word : String = " "
        
        if AppDelegate.lang == "TR" {
            
            if let path = Bundle.main.url(forResource: "trwords", withExtension: "xml") {
                if let parser = XMLParser(contentsOf: path) {
                    parser.delegate = self
                    parser.parse()
                    
                    word = words.randomElement()!.uppercased()
                    
                } else {
                    print("Failed")
                }
            }        } else {
                if let path = Bundle.main.url(forResource: "words", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
                        parser.parse()
                        
                        word = words.randomElement()!.uppercased()
                        
                    } else {
                        print("Failed")
                    }
                }
            }
        print(word)
        return word
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        var randomWord = ( attributeDict.randomElement()?.value)
        randomWord = ( attributeDict.randomElement()?.value)
        
        
        if (randomWord == nil ){
            randomWord = ""
        }
        
        let myword = (randomWord)!.uppercased()
        words.append(myword)
        
    }
    
    
    @IBAction func guessButton(_ sender: UIButton) {
        if AppDelegate.isGameFinished {
            
        }
        else{
            UsedButtons.append(sender)
            
      
        if let buttonguess = sender.titleLabel?.text{
            guess = Character(buttonguess.capitalized)
            checkForLetter()
            displayWord = String(displayWordArray)
            displayWorldLabel.text = displayWord
            sender.isEnabled = false
            if !AppDelegate.isGameFinished {
                checkForWin()
            }
            else{
                print("Game over ")
            }
        }
        }
        /* let guess1 = guessTextField.text
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
         */
        
        
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
            if AppDelegate.isGameFinished {
                print(" Game over ")
            }
            else{
                wrongLettersArray.append(guess)
              
                placeImage()
            }

        }
        
        
    }
    func placeImage(){
        
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
        hangmanImage.image = UIImage(contentsOfFile: "")
        gameEndImage.image = UIImage(contentsOfFile: "")
        wrongLettersArray = []
        displayWord = ""
        displayWordArray = []
        for button in UsedButtons {
            button.isEnabled=true
        }
        AppDelegate.isGameFinished=false
        
        word = GetWordFromXML(AppDelegate.lang)
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
            AppDelegate.isGameFinished = true
        } else if displayWord.contains("?"){
            
        } else {
            gameEndImage.image = UIImage(named: "youWin")
            AppDelegate.isGameFinished = true
        }
        
    }
    
}
