//
//  ViewController.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: REMOVE THIS ASAP
        // Examples for data fetching, for documentation sake in this commit:
        loadWithPreviewFile()
        //        loadWithRequest()
    }
    
    private func loadWithPreviewFile() {
        let feed = try! JSONHelper().decodeFromFile("feed-preview", type: [FeedItem].self)
        for item in feed {
            print(item.title)
        }
    }
    
    private func loadWithRequest() {
        let client = HTTPClient(baseURL: URL(string: "https://mock-feed-server.herokuapp.com")!,
                                urlSession: URLSession.shared)
        let service = FeedService(client: client)
        service.getFeed { result in
            switch result {
            case .success(let feed):
                for item in feed {
                    print(item.title)
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}

