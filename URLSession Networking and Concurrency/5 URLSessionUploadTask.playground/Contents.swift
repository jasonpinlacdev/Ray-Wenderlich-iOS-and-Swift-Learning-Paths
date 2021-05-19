import UIKit

class SessionDelegate: NSObject, URLSessionDataDelegate {
  func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
    let progress = round(Float(totalBytesSent)/Float(totalBytesExpectedToSend)) * 100
    print("Progress: \(progress)")
  }
}

func postRequestUsingUploadTask() {
  guard let image = UIImage(named: "mojave-day.jpeg") else { print("Could not find image mojave-day.jpeg"); return }
  guard let imageData = image.jpegData(compressionQuality: 1.0) else { print("Could not convert image to jpeg data."); return }
  
  let uploadURL = URL(string: "http://127.0.0.1:5000/upload")!
  var request = URLRequest(url: uploadURL)
  request.httpMethod = "POST"
  
  let configuration = URLSessionConfiguration.default
  configuration.waitsForConnectivity = true
  let session = URLSession(configuration: configuration, delegate: SessionDelegate(), delegateQueue: OperationQueue.main)
  let uploadTask = session.uploadTask(with: request, from: imageData) { serverResponseData, urlResponse, error in
    guard let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode == 200 else { print("Invalid URL response."); return }
    guard let serverResponseData = serverResponseData else { print(error!.localizedDescription); return }
    guard let serverResponse = String(data: serverResponseData, encoding: .utf8) else {print("Failed to convert server response data into a string."); return }
    print(serverResponse)
  }
  uploadTask.resume()
}


postRequestUsingUploadTask()


