
import Foundation


extension PasswordViewController {
    func buttonDisable(){
        buttonFeature(imageName: "VerificationG", button: self.verificationBtn, enable: false)
        //buttonFeature(imageName: "senAgain", button: self.sendAgainBtn, enable: false,title: "Kod Ulaşmadı Tekrar Yolla")
    }
}
