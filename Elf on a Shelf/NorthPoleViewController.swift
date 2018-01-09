//
//  NorthPoleViewController.swift
//  Elf on a Shelf
//
//  Created by Jean Lange on 1/9/18.
//  Copyright © 2018 Jean Lange. All rights reserved.
//

import UIKit

class NorthPoleViewController: UIViewController {

    @IBOutlet weak var weatherInfoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://api.wunderground.com/api/b193c8afeeecdbb2/conditions/q/AK/North_Pole.json") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared

        session.dataTask(with: request) { data, response, error in
            if error != nil {
                print("😡😡😡😡😡\(error.debugDescription)")
            } else {
                print("🤩🤩🤩🤩🤩 Made It!\(String(describing: response))")
            }

            guard let newData = data else { return }
            let jsonString = String(data: newData, encoding: String.Encoding.utf8)
            print(jsonString ?? "😱😱😱😱😱 Unable to parse data as JSON")
            }.resume()

        weatherInfoLabel.text = "Hey, it worked!"
    }

}
