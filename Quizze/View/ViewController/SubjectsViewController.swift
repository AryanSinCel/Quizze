import UIKit

class SubjectsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel = SubjectsViewModel()
    private let quizManager = QuizManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        navigationItem.hidesBackButton = true
        viewModel.loadLanguages(quizManager: quizManager)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showTopicSegueIdentifier {
            guard let topics = viewModel.getTopicsForSelectedLanguage() else {
                print("No topics found for selected language")
                return
            }
            let vc = segue.destination as! TopicsViewController
            vc.allTopics = topics
            vc.subjectIndex = viewModel.selectedIndex
            vc.titleLabelText = viewModel.getSelectedLanguage()!.language
        }
    }
}


extension SubjectsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfLanguages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! SubjectsCell
        let subject = viewModel.allLanguages[indexPath.row]
        cell.configureCell(with: subject)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.setSelectedIndex(index: indexPath.row)
        print("Selected index: \(viewModel.selectedIndex ?? -1)")
        performSegue(withIdentifier: Constants.showTopicSegueIdentifier, sender: self)
    }
    
}


extension SubjectsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth / 2 - 20, height: collectionWidth / 2)
    }
}


