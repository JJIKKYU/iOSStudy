import Foundation

class KmoocDetailViewModel: NSObject {
    @IBOutlet var repository: KmoocRepository!

    private var lecture = Lecture.EMPTY
    
    var lectureId: String = ""

    func detail() {
        repository.detail(courseId: lectureId) { lecture in
            self.lecture = lecture
        }
    }
}
