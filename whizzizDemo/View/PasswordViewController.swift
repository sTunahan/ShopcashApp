
import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var verificationBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var iconClick = false
    var imageIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       buttonDisable()
        
        imageIcon.image = UIImage(named: "closeeye")
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageIcon.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
       
        imageIcon.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTapped(){
        
        if iconClick {
            iconClick = false
            imageIcon.image = UIImage(named: "eye")
            passwordTextField.isSecureTextEntry = false
        }else {
            iconClick = true
            imageIcon.image = UIImage(named: "closeeye")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if sender.text!.isEmpty != nil && sender.text!.count >= 6 {
            buttonFeature(imageName: "Continue", button: self.verificationBtn, enable: true)
            
        }else{
            buttonFeature(imageName: "ContinueG", button: self.verificationBtn, enable: false)
        }
    }
    
}
