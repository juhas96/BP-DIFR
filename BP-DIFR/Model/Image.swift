//
//  Image.swift
//  BP-DIFR
//
//  Created by jkbjhs on 21/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import UIKit

class Image {
    var image: UIImage
    var title: String
    var category: String
    
    init(image: UIImage, title: String, category: String) {
        self.image = image
        self.title = title
        self.category = category
    }
}
