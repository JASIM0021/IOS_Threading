
import UIKit
import Combine

class SplashViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Intialiging DispatchGroup
    var launchDataDispatchGroup: DispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().async { [weak self] in
            self?.getAppLaunchData()
        }
    }
    
    func getAppLaunchData() {
        
        // MARK: Entering DispatchGroup
        launchDataDispatchGroup.enter()
        
        NetworkManager.shared.getData(endpoint: .userPreferences, type: UserPreference.self)
            .sink { [weak self] completion in
                // MARK: leave from  DispatchGroup
                self?.launchDataDispatchGroup.leave()
                
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { userPreferences in
                print("Watchlists -> \(userPreferences.watchlist?.first ?? "")")
            }
            .store(in: &self.cancellables)
        
        launchDataDispatchGroup.enter()
        
        NetworkManager.shared.getData(endpoint: .appConfig, type: AppConfig.self)
            .sink { [weak self] completion in
                self?.launchDataDispatchGroup.leave()
                
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { config in
                print("Base URL -> \(config.baseURL ?? "")")
            }
            .store(in: &self.cancellables)
        
        
        // MARK: Using DispatchTimeoutResult We can execute a task before completing the whole task that mean --> if you want to navigate splash to next screen within 3 sec , but your api take 10 sec you can navigate it within 3 secound and the api calling happen in the queue (note that :- use this techniq whenever thos busness logic(api) is optional for thos VC )
        let waitResult: DispatchTimeoutResult = launchDataDispatchGroup.wait(timeout: .now() + .seconds(3))
        DispatchQueue.main.async { [weak self] in

            switch waitResult {
            case .success:
                print("API calls completed before timeout")
            case .timedOut:
                print("APIs timed out")
            }
            self?.activityIndicator.stopAnimating()
            self?.navigateToSignupVC()
        }
        
        
        //MARK: It work after two api calles happen thats mean when the both api calling function called --> .leave()
//        launchDataDispatchGroup.notify(queue: .main) { [weak self] in
//            print("Launch calls complete, navigate to next screen")
//            self?.activityIndicator.stopAnimating()
//            self?.navigateToSignupVC()
//        }
    }
    
    func navigateToSignupVC() {
        guard let signupVC: SignupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else { return }
        UIApplication.shared.windows.first?.rootViewController = signupVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
}
