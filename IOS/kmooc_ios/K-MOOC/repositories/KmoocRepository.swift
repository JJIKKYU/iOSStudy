import Foundation

class KmoocRepository: NSObject {
    /**
     * 국가평생교육진흥원_K-MOOC_강좌정보API
     * https://www.data.go.kr/data/15042355/openapi.do
     */

    private let httpClient = HttpClient(baseUrl: "http://apis.data.go.kr/B552881/kmooc")
    private let serviceKey =
        "LwG%2BoHC0C5JRfLyvNtKkR94KYuT2QYNXOT5ONKk65iVxzMXLHF7SMWcuDqKMnT%2BfSMP61nqqh6Nj7cloXRQXLA%3D%3D"

    func list(completed: @escaping (LectureList) -> Void) {
        httpClient.getJson(path: "/courseList",
                           params: ["serviceKey": serviceKey, "Mobile": 1]
        ) { result in
            if let json = try? result.get() {
                let data = json.data(using: .utf8)!
                let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let lectureList = LectureListParse().parseLectureList(jsonObejct: jsonObject)
                
                completed(lectureList)
            }
        }
    }

    func next(currentPage: LectureList, completed: @escaping (LectureList) -> Void) {
        let nextPageUrl = currentPage.next
        httpClient.getJson(path: nextPageUrl, params: [:]) { result in
            if let json = try? result.get() {
                completed(LectureListParse.EMPTY)
            }
        }
    }

    func detail(courseId: String, completed: @escaping (Lecture) -> Void) {
        httpClient.getJson(path: "/courseDetail",
                           params: ["CourseId": courseId, "serviceKey": serviceKey]) { result in
            if let json = try? result.get() {
                completed(Lecture.EMPTY)
            }
        }
    }
}
