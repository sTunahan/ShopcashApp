
import Foundation
import UIKit
import OTPFieldView

extension VerificationViewController {
    
    func makeAlert(title:String,msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle:UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style:UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

extension VerificationViewController{
    
    //MARK: for URLSession 
    func postData(){
        
        if let userInformation = userInformation?.phoneNumber{
            infoLabel.text = "\(userInformation) Numaralı telefona SMS yolu ile göndermiş olduğumuz 6 haneli kodu aşağıdaki alana girmelisiniz.."
            request = requestSmsOtpSend(phoneNumber: userInformation)
            
            
            PostSmsOtpService().smsOtpSend(request: request) { [self] response in
                
                if let response = response{
                    self.smsOtpSendAll = SmsOtpSendAll(responseAll: response)
                    
                    data = smsOtpSendAll.takeResult().data
                    
                }
            }
        }

    }
    
    //MARK: FOR Alamofire
    func postDataAlamofire(){
        
        if let userInformation = userInformation?.phoneNumber {
            
            
            AlamofirePostSmsOtpService().smsOtpSend(phone: userInformation,url: postSmsOtpUrl!){ [self] response in
                
                if let response = response{
                    
                    self.smsOtpSendAll = SmsOtpSendAll(responseAll: response)
                    data = smsOtpSendAll.takeResult().data
                    
                }
                
            }
        }
      
        }
    
    
}

extension VerificationViewController{
    func postOtpVerification(){
        
        PostSmsOtpVerificationService().smsOtpVerificationSend(request:request) { response in
            
                if let response = response {
                    
                        guard case let response.result! = true else{
                            DispatchQueue.main.async {
                                self.makeAlert(title: "Error", msg: response.error!.message)
                                buttonFeature(imageName: "sendAgain", button: self.sendAgainBtnClick, enable: true,title: "Kod Ulaşmadı Tekrar Yolla")
                            }
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "passwordVC", sender: nil)
                        }

            }
            }
    }
    
    func AlamofirePostOtpVerification(){
        AlamofirePostSmsOtpVerificationService().smsOtpVerificationSend(data: data!, code: otpV, url: postSmsOtpVerificationUrl!) { [self] response in
            
            if let response = response {
                
                    guard case let response.result! = true else{
                        DispatchQueue.main.async {
                            self.makeAlert(title: "Error", msg: response.error!.message)
                            buttonFeature(imageName: "sendAgain", button: self.sendAgainBtnClick, enable: true,title: "Kod Ulaşmadı Tekrar Yolla")
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "passwordVC", sender: nil)
                    }

        }
        }
    }
}

extension VerificationViewController {
    func makeAlert2(title:String,msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle:UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style:UIAlertAction.Style.default){ (action) in
            
            
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeRun2) , userInfo: nil, repeats: true)
            
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
extension VerificationViewController {
    func buttonDisable(){
        buttonFeature(imageName: "VerificationG", button: self.verificationBtnClick, enable: false)
        buttonFeature(imageName: "senAgain", button: self.sendAgainBtnClick, enable: false,title: "Kod Ulaşmadı Tekrar Yolla")
    }
}


extension VerificationViewController:OTPFieldViewDelegate{
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        print(otp)
        buttonFeature(imageName: "Verification", button: self.verificationBtnClick, enable: true)
        otpV = otp
        //MARK: FOR URLSession
        //request = requestSmsOtpVerificationSend(id:data!, code:otp) // OTP DEĞERİNİN GİRİLDİĞİ YER CODE yeri...
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        print("has entered otp is : \(hasEnteredAll)")
        return false
    }
}
