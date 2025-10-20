import Foundation

extension ApplicationClient {
    
    public class User {
        
        var config: ApplicationConfig
        var relativeUrls = [String: String]()
        
        init(config: ApplicationConfig) {
            self.config = config;
            var ulrs = [String: String]()
            
            ulrs["sendOTPOnMobile"] = config.domain.appendAsPath("/service/application/user/authentication/v1.0/otp/mobile/send")
            
            ulrs["verifyMobileOTP"] = config.domain.appendAsPath("/service/application/user/authentication/v1.0/otp/mobile/verify")
            
            self.relativeUrls = ulrs
        }
        public func update(updatedUrl : [String: String]){
            for (key, value) in updatedUrl{
                self.relativeUrls[key] = value
            }
        }
        
        
        /**
         *
         * Summary: Send OTP on Mobile
         * Description: Send a one-time password to the user's mobile for verification.
         **/
        public func sendOTPOnMobile(
            platform: String?,
            body: SendMobileOtpRequestSchema,
            headers: [(key: String, value: String)]? = nil,
            onResponse: @escaping (_ response: SendOtpSuccess?, _ error: FDKError?) -> Void
        ) {
            
            var xQuery: [String: Any] = [:]
            
            if let value = platform {
                xQuery["platform"] = value
            }
            
            var xHeaders: [(key: String, value: String)] = []
            
            
            if let headers = headers {
                xHeaders.append(contentsOf: headers)
            }
            
            let fullUrl = relativeUrls["sendOTPOnMobile"] ?? ""
            
            ApplicationAPIClient.execute(
                config: config,
                method: "POST",
                url: fullUrl,
                query: xQuery,
                extraHeaders: xHeaders,
                body: body.dictionary,
                responseType: "application/json",
                onResponse: { (responseData, error, responseCode) in
                    if let _ = error, let data = responseData {
                        var err = Utility.decode(FDKError.self, from: data)
                        if err?.status == nil {
                            err?.status = responseCode
                        }
                        onResponse(nil, err)
                    } else if let data = responseData {
                        
                        let response = Utility.decode(SendOtpSuccess.self, from: data)
                        
                        onResponse(response, nil)
                    } else {
                        let userInfo: [String: Any] =  [ NSLocalizedDescriptionKey :  NSLocalizedString("Unidentified", value: "Please try after sometime", comment: "") ,
                                                  NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unidentified", value: "Something went wrong", comment: "")]
                        let err = FDKError(message: "Something went wrong", status: 502, code: "Unidentified", exception: nil, info: "Please try after sometime", requestID: nil, stackTrace: nil, meta: userInfo)
                        onResponse(nil, err)
                    }
                });
        }
        
        
        /**
         *
         * Summary: Verify mobile OTP
         * Description: Verify one-time password sent to user's mobile.
         **/
        public func verifyMobileOTP(
            platform: String?,
            body: VerifyOtpRequestSchema,
            headers: [(key: String, value: String)]? = nil,
            onResponse: @escaping (_ response: VerifyOtpSuccess?, _ error: FDKError?) -> Void
        ) {
            
            var xQuery: [String: Any] = [:]
            
            if let value = platform {
                xQuery["platform"] = value
            }
            
            var xHeaders: [(key: String, value: String)] = []
            
            
            if let headers = headers {
                xHeaders.append(contentsOf: headers)
            }
            
            let fullUrl = relativeUrls["verifyMobileOTP"] ?? ""
            
            ApplicationAPIClient.execute(
                config: config,
                method: "POST",
                url: fullUrl,
                query: xQuery,
                extraHeaders: xHeaders,
                body: body.dictionary,
                responseType: "application/json",
                onResponse: { (responseData, error, responseCode) in
                    if let _ = error, let data = responseData {
                        var err = Utility.decode(FDKError.self, from: data)
                        if err?.status == nil {
                            err?.status = responseCode
                        }
                        onResponse(nil, err)
                    } else if let data = responseData {
                        
                        let response = Utility.decode(VerifyOtpSuccess.self, from: data)
                        
                        onResponse(response, nil)
                    } else {
                        let userInfo: [String: Any] =  [ NSLocalizedDescriptionKey :  NSLocalizedString("Unidentified", value: "Please try after sometime", comment: "") ,
                                                  NSLocalizedFailureReasonErrorKey : NSLocalizedString("Unidentified", value: "Something went wrong", comment: "")]
                        let err = FDKError(message: "Something went wrong", status: 502, code: "Unidentified", exception: nil, info: "Please try after sometime", requestID: nil, stackTrace: nil, meta: userInfo)
                        onResponse(nil, err)
                    }
                });
        }
    }
}
