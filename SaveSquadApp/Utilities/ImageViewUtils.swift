//
//  ImageViewUtils.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 12/4/24.
//



import Foundation
import UIKit

extension UIImageView {
    //MARK: Borrowed from: https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview
    
    func loadRemoteImage(from url: URL) {
        //  Creating a background task to load the cloud image
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
