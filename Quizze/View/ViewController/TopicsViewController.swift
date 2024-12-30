import UIKit

class TopicsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var topicIndex:Int?
    var subjectIndex:Int?

    private var viewModel = TopicsViewModel()
    
    var titleLabelText: String = ""
    var allTopics:[TopicModel] = []
    var allData: [[String:Any]]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        print("Subject Index : \(subjectIndex!)")
        if let progressData = UserDefaults.standard.array(forKey: Constants.userDefaultKey) as? [[String: Any]] {
            allData = progressData
        }else{
            return
        }
        
        self.titleLabel.text = titleLabelText
        navigationItem.hidesBackButton = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = nil
        tableView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        viewModel.loadTopics(topics: allTopics)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let progressData = UserDefaults.standard.array(forKey: Constants.progressString) as? [[String: Any]] {
            allData = progressData
            print("Updated progress data: \(allData ?? [])")
        } else {
            allData = []
        }
        
        viewModel.loadTopics(topics: allTopics)
        tableView.reloadData()
    }

    
    @IBAction func goBack(_ sender: UIButton) {
        if self.navigationController != nil {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constants.showQuestionSegueIdentifier {
            if !viewModel.hasSufficientQuestions() {
                let alert = UIAlertController(title: Constants.alertTitle,
                                              message: Constants.alertMessage,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false
            } else {
                if let viewController = storyboard?.instantiateViewController(withIdentifier: Constants.viewControllerIdentifier) as? ViewController {
                    viewController.questions = viewModel.getSelectedTopic()?.quiz ?? []
                    viewController.index = topicIndex
                    viewController.subjectIndex = subjectIndex
                    navigationController?.pushViewController(viewController, animated: true)
                }
                return false
            }
        }
        return true
    }
}


extension TopicsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTopics()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TopicsCell
        let topic = viewModel.allTopics[indexPath.row]
        cell.titleLabel.text = topic.topic
        cell.descriptionLabel.text = topic.description
        
        if let progressData = allData {
            if let progressEntry = progressData.first(where: {
                $0[Constants.subjectString] as? Int == subjectIndex && $0[Constants.chapterString] as? Int == indexPath.row
            }), let progress = progressEntry[Constants.progressString] as? Float {
                cell.progressView.progress = CGFloat(progress)
            } else {
                cell.progressView.progress = 0
            }
        } else {
            cell.progressView.progress = 0
        }
        cell.layer.cornerRadius = 20
        return cell
    }

    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        viewModel.setSelectedIndex(index: indexPath.row)
        topicIndex = indexPath.row
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
}


