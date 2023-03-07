
import Foundation
import Alamofire

class AlamofirePostSmsOtpVerificationService {
    
    private var myParameters:[String:Any] = [
        
          "id": 000000,
          "code": "000000"
    ]
    
    func smsOtpVerificationSend(data:Int,code:String,url:URL,onSuccess:@escaping(ModelPostSmsOtpVerificationResponse?)-> Void) {
        
        myParameters["id"] = data
        myParameters["code"] = code
        
        AF.request(url,method: .post,parameters: myParameters ,encoding: JSONEncoding.default,headers: AlamofireHeader).responseDecodable(of:ModelPostSmsOtpVerificationResponse.self ,completionHandler:{ response in

            guard let value = response.value else { return  }
         
            onSuccess(value)
            
        })

    }
    
}
