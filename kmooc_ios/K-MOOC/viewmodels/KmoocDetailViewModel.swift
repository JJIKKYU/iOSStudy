import Foundation

class KmoocDetailViewModel: NSObject {
    @IBOutlet var repository: KmoocRepository!
    
    var loadingListUpdated: () -> Void = { }

    public var lecture = Lecture.EMPTY
    
    var lectureId: String = ""

    func detail() {
        repository.detail(courseId: lectureId) { lecture in
            print("lecture = ", lecture)
            self.lecture = lecture
            self.loadingListUpdated()
        }
    }
}
