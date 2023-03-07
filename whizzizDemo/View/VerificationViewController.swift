

import UIKit
import OTPFieldView

class VerificationViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var verificationTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var verificationBtnClick: UIButton!
    @IBOutlet weak var otpFieldView: OTPFieldView!
    @IBOutlet weak var sendAgainBtnClick: UIButton!
    //SegueVariable
    var userInformation:UserInformation?
    //API
     var smsOtpSendAll:SmsOtpSendAll!
    var otpV:String = ""
    
    
    
    //MARK:-----
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        implementOtpView()
        
        counter = 1
        buttonDisable()
        
        postDataAlamofire()
        //postData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeRun) , userInfo: nil, repeats: true)
        
    }
    
    
    //MARK: TextFieldDidChange
    /*
    @IBAction func textFieldBtnClick(_ sender: UITextField) {
        if sender.text!.isEmpty {
            buttonFeature(imageName: "VerificationG", button: self.verificationBtnClick, enable: false)
        }else{
            buttonFeature(imageName: "Verification", button: self.verificationBtnClick, enable: true)
            request = requestSmsOtpVerificationSend(id:data!, code:sender.text!) // OTP DEĞERİNİN GİRİLDİĞİ YER CODE yeri...
        }
    }
    */
    
    //OTP SECREEN
    func implementOtpView(){
        
        self.otpFieldView.fieldsCount = 6
        self.otpFieldView.fieldBorderWidth = 3
        self.otpFieldView.filledBorderColor = UIColor.green
        self.otpFieldView.defaultBorderColor = UIColor.black
        self.otpFieldView.cursorColor = UIColor.green
        self.otpFieldView.displayType = .underlinedBottom
        self.otpFieldView.fieldSize = 50
        self.otpFieldView.separatorSpace = 15
        self.otpFieldView.shouldAllowIntermediateEditing = false
        self.otpFieldView.secureEntry = false 
       
        self.otpFieldView.initializeUI()
        self.otpFieldView.delegate = self
    }
    
    
    
    
    
    @IBAction func sendAgainBtnClick(_ sender: Any) {
        counter += 1
        counterTime = -1
        if counter < 4 {
            postDataAlamofire()
            //postData()
        }else {
            
            buttonDisable()
            myTimer.invalidate()
            counterTime = 0
            timeLabel.text = "Kodun Süresi Dolacak: \(counterTime)"
            self.makeAlert2(title: "Daha Sonra Tekrar Deneyiniz", msg: "Çok fazla deneme yapıldı tekrar denemek için 3 dk bekleyiniz...")
            
            
        }
        
    }
    
    @IBAction func verificationOtpBtnClick(_ sender: Any) {
        
        
        AlamofirePostOtpVerification()
        //FOR URLSession
         //postOtpVerification()
         counterTime = 0
        }
    
    @objc func timeRun(){
        counterTime += 1
        timeLabel.text = "Kodun Süresi Dolacak: \(counterTime)"
        if counterTime == 61 {
            stopWatchStop(myTimer: myTimer, counterTime: counterTime, timeLabel: timeLabel)
            buttonFeature(imageName: "sendAgain", button: self.sendAgainBtnClick, enable: true,title: "Kod Ulaşmadı Tekrar Yolla")
        }
        
    }
    
    @objc func timeRun2(){
        counterTime += 1
        timeLabel.text = "Kodun Süresi Dolacak: \(counterTime)"
        
        if counterTime == 180 {
            buttonFeature(imageName: "sendAgain", button: self.sendAgainBtnClick, enable: true,title: "Kod Ulaşmadı Tekrar Yolla")
            stopWatchStop(myTimer: myTimer, counterTime: counterTime, timeLabel: timeLabel)
        }
        
    }
}


