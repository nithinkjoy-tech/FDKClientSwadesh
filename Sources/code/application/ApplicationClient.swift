
import Foundation

public class ApplicationClient {
    private let config: ApplicationConfig

    public let user: User

    public init(config: ApplicationConfig) {
        self.config = config
        
        user = User(config: config)
    }

    public func setLocationDetails(details: ApplicationConfig.LocationDetails?){
        config.locationDetails = details
    }
}
