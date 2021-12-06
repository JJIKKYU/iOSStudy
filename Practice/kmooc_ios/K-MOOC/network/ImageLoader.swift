import UIKit

class ImageLoader {
    private static var imageCache = [String: UIImage]()
    
    static func loadImage(url: String, completed: @escaping (UIImage?) -> Void) {
        
        if url.isEmpty {
            completed(nil)
            return
        }
        
        if let image = ImageLoader.imageCache[url] {
            completed(image)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    ImageLoader.imageCache[url] = image
                    completed(image)
                }
            } else {
                DispatchQueue.main.async {
                    completed(nil)
                }
            }
        }
    }
}
