import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var getPostBtn: UIButton!
    let baseAddress = "https://jsonplaceholder.typicode.com/comments?postId="
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getPostBtn(_ sender: UIButton) {
        dataFetch()
        
    }
    
    func dataFetch(){
        if let postId = idTextField.text {
            let url = baseAddress + postId
            guard let requestURL = URL(string: url) else {return}
            var request = URLRequest(url: requestURL)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request){(data,response,error) in
                guard let data = data,
                      let dataString = String(data: data, encoding: .utf8),
                      (response as? HTTPURLResponse)?.statusCode == 200,
                      error == nil else {return}
                DispatchQueue.main.async {
                    self.textView.text = dataString
                }
            }
            task.resume()
        }
    }
}

