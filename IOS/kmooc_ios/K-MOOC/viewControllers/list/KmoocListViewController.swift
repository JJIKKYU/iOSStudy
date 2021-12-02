import UIKit

class KmoocListViewController: UITableViewController {
    @IBOutlet var viewModel: KmoocListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let activity = UIActivityIndicatorView()
        view.addSubview(activity)
        activity.tintColor = .red
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        viewModel.loadingStarted = { [weak activity] in
            activity?.isHidden = false
            activity?.startAnimating()
        }
        
        viewModel.loadingEnded = { [weak activity] in
            activity?.stopAnimating()
        }
        
        viewModel.lectureListUpdated = { [weak self]  in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
            
            
        }
        
        viewModel.list()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KmoocDetail",
           let lecture = sender as? Lecture,
           let detail = segue.destination as? KmoocDetailViewController {
            detail.viewModel.lectureId = lecture.id
        }
    }
}

extension KmoocListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("viewmodl.lectureCount = ", viewModel.lecturesCount())
        return viewModel.lecturesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KmoocListItemTableViewCell.CellIdentifier) as! KmoocListItemTableViewCell
        
        let data = viewModel.lectureList.lectures[indexPath.row]
        
        cell.name.text = data.name
        cell.orgName.text = data.orgName
        
        ImageLoader.loadImage(url: data.courseImage) { image in
            cell.thumbnail.image = image
        }
        
        
        cell.duration.text = "\(DateUtil.formatDate(data.start)) ~ \(DateUtil.formatDate(data.end))"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lecture = viewModel.lecture(at: indexPath.row)
        
        performSegue(withIdentifier: "KmoocDetail", sender: lecture)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.next()
        }
    }
    
}
