import UIKit
import WebKit

class KmoocDetailViewController: UIViewController {
    @IBOutlet var viewModel: KmoocDetailViewModel!

    @IBOutlet var lectureImage: UIImageView!
    @IBOutlet var lectureNumber: UILabel!
    @IBOutlet var lectureType: UILabel!
    @IBOutlet var lectureOrg: UILabel!
    @IBOutlet var lectureTeachers: UILabel!
    @IBOutlet var lectureDue: UILabel!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var loading: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.detail()
    }
}
