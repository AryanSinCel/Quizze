import UIKit

protocol ResultViewControllerDelegate: AnyObject {
    func didTapReplay()
}

class ResultViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var replayView: UIView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var replayBtn: UIButton!
    weak var delegate: ResultViewControllerDelegate?
    
    private var viewModel = ResultViewModel()
    var question:[QuizModel] = []
    var answered:[String] = []
    var resultIndex:Int?
    var subjectIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        replayView.layer.cornerRadius = 20
        homeView.layer.cornerRadius = 20
        
        print("Subject Index : \(subjectIndex!)")
        
        viewModel.mainIndex = resultIndex
        viewModel.subjectIndex = subjectIndex
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        navigationItem.hidesBackButton = true
        
        viewModel.loadData(questions: question, answered: answered)
        
        resultLabel.text = viewModel.resultText()
        
    }
    
   
    @IBAction func replay(_ sender: UIButton) {
        delegate?.didTapReplay()
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func homeTapped(_ sender: UIButton) {
        if self.navigationController != nil {
            popToSpecificViewController(numberOfPop: 2, animated: true)
        }
    }
    
    func popToSpecificViewController(numberOfPop: Int, animated: Bool) {
        guard let navigationController = self.navigationController else { return }
        
        let viewControllers = navigationController.viewControllers
        
        if viewControllers.count > numberOfPop {
            let targetViewController = viewControllers[viewControllers.count - numberOfPop - 1]
            navigationController.popToViewController(targetViewController, animated: animated)
        } else {
            print("Not enough view controllers in the stack to pop")
        }
    }
}


extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ResultCell
        let answerData = viewModel.getAnswer(for: indexPath.row)
        
        cell.layer.cornerRadius = 10
        cell.titleLabel.text = answerData.question
        cell.answerLabel.text = "Expected Answer: \(answerData.expectedAnswer)"
        cell.userAnswerLabel.text = "Your Answer: \(answerData.userAnswer)"
        
        cell.userAnswerLabel.textColor = answerData.isCorrect ? UIColor.green : UIColor.red
        
        return cell
    }
}
