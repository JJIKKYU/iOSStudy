import UIKit
import Kingfisher
import AVFoundation
import Firebase

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    let db = Database.database().reference().child("history")
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController : UICollectionViewDataSource {
    // 몇개 넘어오니?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // 어떻게 표현할 거니?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.item]
        let url = URL(string: movie.tumbnailPath)
        
        // imagePath(string) -> image
        // 외부 코드 가져다 쓰기 (3rd party)
        // Swift Package Manager (SPM), COcoa Pod, Carthage
        
        cell.movieThumbnail.kf.setImage(with: url)
        
        return cell
    }
    
    
}

extension SearchViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // movie
        // player vc
        // player vc + movie
        // presenting player vc
        
        let movie = movies[indexPath.item]
        let url = URL(string: movie.previewURL)!
        let item = AVPlayerItem(url: url)
        
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.modalPresentationStyle = .fullScreen
        
        vc.player.replaceCurrentItem(with: item)
        present(vc, animated: false, completion: nil)
    }
}

extension SearchViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin : CGFloat = 8
        let itemSpacing : CGFloat = 10
        
        let width = (collectionView.bounds.width - margin * 2 - itemSpacing * 2) / 3
        let height = width * 10/7
        
        return CGSize(width: width, height: height)
    }
}

class ResultCell : UICollectionViewCell {
    @IBOutlet weak var movieThumbnail : UIImageView!
}

extension SearchViewController : UISearchBarDelegate {
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder() // 첫 번째 응답자 X -> 키보드가 알아서 내려감
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색시작

        
        // 키보드가 오라와 있을 때, 내려가게 처리
        dismissKeyboard()
        
        // 검색어가 있는지
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false
        else { return }
        
        // 네트워킹을 통한 검색
        // - 목표 : searchTerm을 가지고 네트워킹을 통해서 영화 검색
        // - [x] 검색 API가 필요
        // - [x] 결과를 받아올 모델 (Movie 객체, Response)
        // - 결과를 받아와서 CollectionView로 표현해주자
        
        SearchAPI.search(searchTerm) { movies in
            // CollectionView로 표현하기
            print("몇개? ---> \(movies.count), 첫번째 제목 --> \(movies.first?.title)")
            DispatchQueue.main.async {
                self.movies = movies
                self.resultCollectionView.reloadData()
                let timeStamp : Double = Date().timeIntervalSince1970.rounded()
                self.db.childByAutoId().setValue(["term" : searchTerm, "timestamp" : timeStamp])
            }
        }
    }
}

class SearchAPI {
    static func search(_ term : String, completion : @escaping ([Movie]) -> Void) {
        let session = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: term)
        
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        let requestURL = urlComponents.url!
        
        let dataTask = session.dataTask(with: requestURL) { data, respnse, error in
            let successRange = 200..<300
            
            guard error == nil,
                let statusCode = (respnse as? HTTPURLResponse)?.statusCode,
                successRange.contains(statusCode) else {
                    return completion([])
            }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            // data -> [Movie]
            let movies = SearchAPI.parseMovies(resultData)
            completion(movies)
//            print(string)
            
        }
        dataTask.resume()
    }
    
    static func parseMovies(_ data : Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.movies
            return movies
        } catch let error {
            print("\(error.localizedDescription)");
            return []
        }
    }
}

struct Response : Codable {
    let resultCount : Int
    let movies : [Movie]
    
    enum CodingKeys : String, CodingKey {
        case resultCount
        case movies = "results"
    }
}

struct Movie : Codable {
    let title : String
    let director : String
    let tumbnailPath : String
    let previewURL : String
    
    enum CodingKeys : String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case tumbnailPath = "artworkUrl100"
        case previewURL = "previewUrl"
    }
}
