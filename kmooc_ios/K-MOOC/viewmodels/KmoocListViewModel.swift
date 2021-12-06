import Foundation

class KmoocListViewModel: NSObject {
    @IBOutlet var repository: KmoocRepository!

    public var lectureList: LectureList = LectureListParse.EMPTY
    
    var loading: Bool = false
    var loadingStarted: () -> Void = { }
    var loadingEnded: () -> Void = { }
    var lectureListUpdated: () -> Void = { }

    func lecturesCount() -> Int {
        return lectureList.lectures.count
    }

    func lecture(at index: Int) -> Lecture {
        return lectureList.lectures[index]
    }

    func list() {
        loading = true
        loadingStarted()
        repository.list {
            self.lectureList = $0
            self.lectureListUpdated()
            self.loadingEnded()
            self.loading = false

        }
    }

    func next() {
        if loading { return }
        loading = true
        
        let curLectureList = self.lectureList
        
        repository.next(currentPage: lectureList) { [weak self] lectureList in
        
            self?.lectureList = lectureList
            self?.lectureList.lectures.insert(contentsOf: curLectureList.lectures, at: 0)
            self?.lectureListUpdated()
            self?.loading = false
        }
    }
}
