import UIKit
import SwiftUI

class VC_SwiftUIContainer: UIViewController {
    
    @IBOutlet var containerView: UIView!
    var mySwiftUIView: AnyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if a SwiftUI view is provided
        guard let mySwiftUIView = mySwiftUIView else {
            return
        }
        
        // Set up container view
        let hostingController = UIHostingController(rootView: mySwiftUIView)
        addChild(hostingController)
        containerView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
