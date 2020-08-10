import UIKit

// URLSession

// 1. URLSessionConfiguration
// 2. URLSession
// 3. URLSessionTask를 이용해서 서버와 네트워킹

// URLSessionTask

// - updateTask
// - uploadTask
// - downloadTask


let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

// URL
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
let termQuery = URLQueryItem(name: "term", value: "이하이")
urlComponents.queryItems?.append(mediaQuery)
urlComponents.queryItems?.append(entityQuery)
urlComponents.queryItems?.append(termQuery)

let requestURL = urlComponents.url!

struct Response : Codable {
    let resultCount : Int
    let tracks : [Track]
    
    // 실제 Json과 직접 제작한 struct와 데이터의 이름을 같도록 맞추는 작업
    enum CodingKeys : String, CodingKey {
        case resultCount
        case tracks = "results"
    }
}

struct Track : Codable {
    let title : String
    let artistName : String
    let thumbnailPath : String
    
    // 실제 Json과 직접 제작한 struct와 데이터의 이름을 같도록 맞추는 작업
    enum CodingKeys : String, CodingKey {
        case title = "trackName"
        case artistName
        case thumbnailPath = "artworkUrl30"
    }
}


let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    guard error == nil else { return }
    
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200..<300
    
    guard successRange.contains(statusCode) else {
        // handle response error
        return
    }
    
    guard let resultData = data else { return }
    let resultString = String(data: resultData, encoding: .utf8)
    
    // 목표 : 트랙리ㅡ트 오브젝트로 가져오기
    
    // 하고 싶은 욕구 목록
    // - Data -> Track 목록으로 가져오고 싶다 [Track]
    // - Track 오브젝트를 만들어야겠다
    // - Data에서 struct로 파싱하고 싶다 > Codable 이용해서 만들자
    //   - json 파일, 데이터 -> 오브젝트로 만들 때 (Codable 이용하겠다)
    //   - Response ( [Track] ) 이렇게 두 개를 만들어야겠다
    
    // 해야할 일
    // - Response, Track, Struct
    // - struct의 프로퍼티 이름과 실제 데ㅣ터의 키와 맞추기 (Codable 디코딩 가능하게 하기 위해서)
    // - 파싱하기 (Decoding)
    // - 트랙리스트 가져오기
    
    // 파싱 및 트랙 가져오기
    do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response.self, from: resultData)
        
        let tracks = response.tracks
        print("\(tracks.count)")
    } catch let error {
        print("error : \(error.localizedDescription)") // error에 대한 설명이 나옴
    }
    
    
//    print("---> \(resultData)")
}

dataTask.resume()
