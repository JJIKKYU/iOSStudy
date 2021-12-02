import Foundation

struct LectureList: Codable {
    let count: Int
    let numPages: Int
    let previous: String
    let next: String
    var lectures: [Lecture]
    
    init(count: Int,
         numPages: Int,
         previous: String,
         next: String,
         lectures: [Lecture]) {
        self.count = count
        self.numPages = numPages
        self.previous = previous
        self.next = next
        self.lectures = lectures
    }
}

struct LectureListParse {
    static let EMPTY = LectureList(count: 0, numPages: 0, previous: "", next: "", lectures: [])
    
    public func parseLectureList(jsonObejct: [String: Any]) -> LectureList {
        let pagination = jsonObejct["pagination"] as! [String:Any]
        let results = jsonObejct["results"] as! [[String: Any]]
        
        let count = pagination["count"] as! Int
        let numPage = pagination["num_pages"] as! Int
        let previous = pagination["previous"] as? String ?? ""
        let next = pagination["next"] as? String ?? ""
        let lectures = results.map { parseLecture(jsonObject: $0 )}
        
        
        let LectureList = LectureList(count: count,
                                      numPages: numPage,
                                      previous: previous,
                                      next: next,
                                      lectures: lectures
        )
        
        return LectureList
    }
    
    public func parseLecture(jsonObject: [String: Any]) -> Lecture {
        
        let id = jsonObject["id"] as! String
        let number = jsonObject["number"] as! String
        let name = jsonObject["name"] as! String
        let classfyName = jsonObject["classfy_name"] as! String
        let middleClassfyName = jsonObject["middle_classfy"] as! String
        let courseImage = ((jsonObject["media"] as! [String: Any])["image"] as! [String: Any])["small"] as! String
        let courseImageLarge = ((jsonObject["media"] as! [String: Any])["image"] as! [String: Any])["large"] as! String
        let shortDescription = jsonObject["short_description"] as! String
        let orgName = jsonObject["org_name"] as! String
        let start = DateUtil.parseDate(jsonObject["start"] as! String)
        let end = DateUtil.parseDate(jsonObject["end"] as! String)
        let teachers = jsonObject["teachers"] as? String
        let overview = jsonObject["overview"] as? String
        
        let lecture = Lecture(id: id,
                              number: number,
                              name: name,
                              classfyName: classfyName,
                              middleClassfyName: middleClassfyName,
                              courseImage: courseImage,
                              courseImageLarge: courseImageLarge,
                              shortDescription: shortDescription,
                              orgName: orgName,
                              start: start,
                              end: end,
                              teachers: teachers,
                              overview: overview)
        
        return lecture
        
    }
}
