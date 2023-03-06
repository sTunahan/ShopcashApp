
import Foundation

struct SmsOtpSendAll {
    
    let responseAll : ModelPostSmsOtpResponse
    
    func takeResult() -> SmsOtpSend{
        return SmsOtpSend(response: responseAll)
    }
    
}


struct SmsOtpSend{
    
    let response:ModelPostSmsOtpResponse
    
    var result:Bool {
        return self.response.result!
    }
    
    var data:Int {
        return self.response.data!
    }
}


