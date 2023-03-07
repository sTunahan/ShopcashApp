

import Foundation
import Alamofire

class AlamofirePostSmsOtpService{
    
    private var myParameters:[String:Any] = [
        
        "message": "Doğrulama kodunuz ${code}.",
        "recipients": "90000000000",
        "header": 100077,
        "type": "sms",
        "encode": "numeric",
        "timeout": 60,
        "length": 6
    ]
    
   
    func smsOtpSend(phone:String,url:URL,onSuccess:@escaping(ModelPostSmsOtpResponse?)-> Void) {
        
        myParameters["recipients"] = phone
        AF.request(url,method: .post,parameters: myParameters ,encoding: JSONEncoding.default,headers: AlamofireHeader).responseDecodable(of:ModelPostSmsOtpResponse.self ,completionHandler:{ response in

            guard let value = response.value else { return  }
         
            onSuccess(value)
            
        })
        
    }

}
