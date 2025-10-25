
import Foundation

public class ApplicationClient {
    private let config: ApplicationConfig
    
    public let content: Content

    public let user: User

    public init(config: ApplicationConfig) {
        self.config = config
        
        content = Content(config: config)
        
        user = User(config: config)
    }

    public func setLocationDetails(details: ApplicationConfig.LocationDetails?){
        config.locationDetails = details
    }
}
