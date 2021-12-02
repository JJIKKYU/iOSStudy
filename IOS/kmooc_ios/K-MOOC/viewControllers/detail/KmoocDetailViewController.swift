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
    
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    @IBOutlet var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("lectureID = ", viewModel.lectureId)
        viewModel.detail()
        self.webView.navigationDelegate = self
        
        
        viewModel.loadingListUpdated = { [weak self] in
            self?.loadDetailView()
        }
    }
    
    func loadDetailView() {
        let model = viewModel.lecture
        
        ImageLoader.loadImage(url: model.courseImage, completed: { [weak self] image in
            self?.lectureImage.image = image
        })
        lectureNumber.text = model.number
        lectureType.text = model.classfyName
        lectureOrg.text = model.orgName
        lectureTeachers.text = model.teachers
        lectureDue.text = DateUtil.formatDate(model.end)
        
        //        let request = URLREquest(URL: model.)
        let meta_java : String = "<meta name=\"viewport\" content=\"initial-scale=1, user-scalable=no, width=device-width\" />"
        webView.translatesAutoresizingMaskIntoConstraints = true
        webView.scrollView.isScrollEnabled = false
        webView.loadHTMLString(meta_java + model.overview!, baseURL: nil)
        
    }
}

extension KmoocDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish!")
        self.webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                    //                        self.containerHeight.constant = height as! CGFloat
                    
                    self.webViewHeight.constant = height as! CGFloat
                    self.webViewHeight.isActive = true
                    
                    self.view.layoutIfNeeded()
                    print(self.webView.scrollView.contentSize.height)
                    webView.invalidateIntrinsicContentSize()
                })
            }
            
        })
    }
}
