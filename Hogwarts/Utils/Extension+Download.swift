//
//  Extension+Download.swift
//  Hogwarts
//
//  Created by Maxwell Silva on 26/05/25.
//

import UIKit

extension UIImageView {

    private static var imageCache = NSCache<NSURL, UIImage>()

    func download(from url: URL, placeholder: UIImage? = nil, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        self.image = placeholder

        if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }

            UIImageView.imageCache.setObject(image, forKey: url as NSURL)

            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }
        task.resume()
    }

    func download(from link: String, placeholder: UIImage? = nil, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        download(from: url, placeholder: placeholder, contentMode: mode)
    }
}
