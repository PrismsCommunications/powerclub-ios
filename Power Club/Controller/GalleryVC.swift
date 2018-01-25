//
//  Gallery.swift
//  Power Club
//
//  Created by Prisms Communications on 11-04-2015.
//  Copyright © 2018 Prisms Communications. All rights reserved.
//

import UIKit
import WebKit

class GalleryVC: UIViewController {
    
    
    @IBOutlet weak var GalleryWebview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url =  URL(string: "http://topschooldev.prisms.in/hybrid/gallery/index.php?sid=258&fun_name=getAlbumDetailsHybrid&userId=469")
        let request = URLRequest(url: url!)
        
        GalleryWebview.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
