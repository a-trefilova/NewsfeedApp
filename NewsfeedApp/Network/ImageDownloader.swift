
import UIKit

class NetworkingManager {
    static func downloadImage(url: String, completion: @escaping (_ data: Data)->()) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        } .resume()
    }
}
