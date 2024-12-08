//
//  ImageViewUtils.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 12/4/24.
//



import Foundation
import UIKit

extension UIImageView {
    func loadRemoteImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let currentTag = self.tag
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                if self?.tag == currentTag {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
