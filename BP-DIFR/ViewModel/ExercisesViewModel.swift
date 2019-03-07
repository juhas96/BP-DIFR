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
//struct WholeJsonModel: Decodable {
//    let count: Int?
//    let next: String?
//    let previous: String?
//    let results: [ExerciseApiModel]
//}

class ExercisesViewModel: UIViewController {
    
    @IBOutlet weak var exercisesTableView: UITableView!
    
    var exerciseArray = [Exercise]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    
    }
    
    
    func loadData() {
        FIRFirestoreService.shared.read(from: .exercises, returning: Exercise.self) { (exercises) in
            self.exerciseArray = exercises
            self.exercisesTableView.reloadData()
        }
    }
    
    
//    func addDataToFirestore() {
//
//        let str = """
//            [
//
//    ]
//    """
//        var id = 328
//        do {
//            let json = try JSONSerialization.jsonObject(with:str.data(using:.utf8)!, options: []) as! [[String: Any]]
//            for var i in 0...json.count - 1
//            {
//                db.collection("exercises").document(String(id)).setData(json[i])
//                print("ID JE: \(id)")
//                id = id + 1
//            }
//        } catch  {
//            print("Pridavanie dat " + error.localizedDescription)
//        }
//
//    }
}



extension ExercisesViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        let exercise = exerciseArray[indexPath.row]
        
        cell.setLabel(label: exercise.name)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED ROW: \(indexPath.row)")
        let exercise = exerciseArray[indexPath.row]
        print("Exercise name: \(exercise.name)")
        print("Exercise id: \(exercise.id)")
        print("EXERCISE category: \(exercise.category)")
        print("EXERCISE category: \(exercise.description)")
//        print("Exercise: \(exercise.dictionary[])")
    }
    
}
