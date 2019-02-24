//
//  ExercisesViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 24/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

// Struktura pre JSON Api ktore dotiahnem
// Ja pracuje muz len s results kde sa nachadzaju cviky
struct WholeJsonModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [ExerciseApiModel]
}

class ExercisesViewModel: UIViewController {
    
    @IBOutlet weak var exercisesTableView: UITableView!
    
    var nameArray: [String] = []
    var categorayArray: [String] = []
    var imgURLArray: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // vytvorim URL zo stringu
        let jsonUrlString = "https://wger.de/api/v2/exercise/?language=2&page=18"
        guard let url = URL(string: jsonUrlString) else { return }
        
        // vyparsujem JSON
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let exercises = try JSONDecoder().decode(WholeJsonModel.self, from: data)
                print(exercises.results)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}


extension ExercisesViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseCell
        
        return cell
    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ExerciseDetailViewController") as? ExerciseDetailViewController
//        vc?.image = UIImage(named: images[indexPath.row].title)
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
//    
}
