

import Foundation

//METHODS

func requestSmsOtpVerificationSend (id:Int,code:String) -> URLRequest{
    let url = postSmsOtpVerificationUrl
    let headers = headers
    guard let requestUrl = url else { fatalError() }

    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers

    
    let smsOtpVerification = ModelPostSmsOtpVerificationBody(id: id,code: code)
    
    do{
        let jsonData = try? JSONEncoder().encode(smsOtpVerification)

        request.httpBody = jsonData
        
       
    }catch{
        print("Error request")
    }

    return request
}
