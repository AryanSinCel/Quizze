import UIKit
import SVGKit

class SubjectsCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    private static var imageCache = [String: UIImage]()
    
    @IBOutlet weak var subView: UIView!
    func configureCell(with subject: LanguageModel) {
        subView.layer.cornerRadius = 20
        loadImage(from: subject.imageURL)
    }
    
    private func loadImage(from urlString: String) {
        if let cachedImage = SubjectsCell.imageCache[urlString] {
            self.imageView.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let fileExtension = url.pathExtension.lowercased()
        
        if fileExtension == Constants.imageFileExtension1 {
            loadSVGImage(from: url)
        } else if fileExtension == Constants.imageFileExtension2 {
            loadPNGImage(from: url)
        } else {
            print("Unsupported file type")
        }
    }
    
    private func loadSVGImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let svgImage = SVGKImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = svgImage.uiImage
                    SubjectsCell.imageCache[url.absoluteString] = svgImage.uiImage
                }
            } else {
                print("Failed to load SVG image")
            }
        }
    }
    
    private func loadPNGImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    SubjectsCell.imageCache[url.absoluteString] = image
                }
            } else {
                print("Failed to load PNG image")
            }
        }
    }
}
