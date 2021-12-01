import Foundation

class KmoocListViewModel: NSObject {
    @IBOutlet var repository: KmoocRepository!

    private var lectureList: LectureList = LectureList.EMPTY

    func lecturesCount() -> Int {
        return lectureList.lectures.count
    }

    func lecture(at index: Int) -> Lecture {
        return lectureList.lectures[index]
    }

    func list() {
        repository.list {
            self.lectureList = $0
        }
    }

    func next() {
        repository.next(currentPage: lectureList) {
            var lectureList = $0
            lectureList.lectures.insert(contentsOf: self.lectureList.lectures, at: 0)
            self.lectureList = lectureList
        }
    }
}
