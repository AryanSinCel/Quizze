import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var option1Label: UIButton!
    @IBOutlet weak var option2Label: UIButton!
    @IBOutlet weak var option3Label: UIButton!
    @IBOutlet weak var option4Label: UIButton!
    
    @IBOutlet weak var mainStackView: UIStackView!
    var viewModel = ViewControllerModel()
    var questions:[QuizModel] = []
    var index:Int?
    var subjectIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        print(index!)
        print("Subject Index : \(subjectIndex!)")
        
        setupUI()
        prepareQuestions()
        loadQuestion()
    }
    
    private func setupUI() {
        mainStackView.layer.cornerRadius = 20
        mainStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
        mainStackView.isLayoutMarginsRelativeArrangement = true
        
        [option1Label, option2Label, option3Label, option4Label].forEach { button in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
            button?.layer.cornerRadius = 10
        }
    }
    
    private func prepareQuestions() {
        viewModel.prepareQuestions(questions: questions)
    }
    
    private func loadQuestion() {
        guard let question = viewModel.loadCurrentQuestion() else { return }
        
        titleLabel.text = question.question
        option1Label.setTitle(question.options[0], for: .normal)
        option2Label.setTitle(question.options[1], for: .normal)
        option3Label.setTitle(question.options[2], for: .normal)
        option4Label.setTitle(question.options[3], for: .normal)
        self.title = "Question \(viewModel.getCurrentQuestionIndex())"
    }
    
    @IBAction func OptionClicked(_ sender: UIButton) {
        guard let question = viewModel.loadCurrentQuestion() else { return }
        
        let selectedAnswer = question.options[sender.tag - 1]
        viewModel.addAnswer(selectedAnswer: selectedAnswer)
        
        viewModel.nextQuestion()
        
        if viewModel.isQuizFinished() {
            navigateToResults()
        } else {
            loadQuestion()
        }
    }
    
    private func navigateToResults() {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.resultViewControllerIdentifier) as! ResultViewController
        nextVC.delegate = self
        nextVC.answered = viewModel.answered
        nextVC.question = viewModel.currentQuestionSet
        nextVC.resultIndex = index
        nextVC.subjectIndex = subjectIndex
        navigationController?.pushViewController(nextVC, animated: true)
    }
   
}


extension ViewController: ResultViewControllerDelegate{
 
    func didTapReplay() {
        viewModel.resetQuiz()
        loadQuestion()
    }
    
}
