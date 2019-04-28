//
//  WorkoutViewModel.swift
//  BP-DIFR
//
//  Created by jkbjhs on 05/03/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import FirebaseUI


class WorkoutViewModel: UIViewController {

    var session = WorkoutSession()
    
    // TODO: Upratat triedu
    
    @IBOutlet weak var tableView: UITableView!
    // Break Timer
    @IBOutlet weak var breakTimerLabel: UILabel!
    
    // Label Workout Name
    @IBOutlet weak var workoutName: UILabel!
    
    
    // Kliknutie na checkButton - zapnem break timer
    @IBAction func checkButtonClicked(_ sender: Any) {
        createBreakTimer()
    }
    
    var workoutNetworkService: WorkoutsNetworkService!
    
    var currentWorkout: Workout?
    var dbWorkout = String()
    
    var numberOfRowsInSection: Int!
    
    var kgTextFields = [String]()
    
    
    // Timer - duration of Workout
    var timer: Timer?
    
    // koniec timera
    var endDate: Date!
    var startDate: Date!
    
    // Timer - break between sets Timer
    var breakTimer: Timer?
    
    var secondsLeft: TimeInterval = 10
    
    var counter = 0.0
    var user: AppUser! = nil
    
    
    var exercisesSetsArray = [ExercisesSet]()
    var setsArray = [[ExercisesSet]]()
    
    var kgTextField = String()
    
    var groupedDict = [String? : [ExercisesSet]]()
    var groupedSets = [[ExercisesSet]]()
    var keys: Dictionary<String?, [ExercisesSet]>.Keys!
    
    
    
    // MARK: FINISH
    @available(iOS 12.0, *)
    @IBAction func finishButtonTapped(_ sender: Any) {
        if timer != nil {
            timer?.invalidate()
        }
        
        self.currentWorkout?.user = AppUser.shared
        self.currentWorkout?.endDate = String(Date().currentTimeMillis())
        self.currentWorkout?.duration = Int(self.counter)
        if breakTimer != nil {
           breakTimer?.invalidate()
        }
        
        convertExerciseSetsFromDictToArrayAndAssigneToWorkout(exerciseSets: self.groupedSets)
        dbWorkout = convertWorkoutToParameters(workout: self.currentWorkout!)
        
        print(dbWorkout)
        
        self.session.end()
        
        
        guard let currentWorkout = session.completeWorkout else {
            fatalError("Shouldn't be able to press the done button without a saved workout.")
        }
        
        WorkoutDataStore.save(prancerciseWorkout: currentWorkout) { (success, error) in
            if success {
                print("Workout save to healthkit")
            } else {
                print("There was error while saving workout to healthkit")
            }
        }
    
        addWorkoutToDatabase()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func addWorkoutToDatabase() {
        workoutNetworkService = WorkoutsNetworkService()
        workoutNetworkService.saveWorkout(workout: dbWorkout)
    }
    
    // Skonvertuje 2d to 1d a priradi workoutu
    func convertExerciseSetsFromDictToArrayAndAssigneToWorkout(exerciseSets: [[ExercisesSet]]) {
        var exerciseSetsArray = [ExercisesSet]()
        exerciseSetsArray = exerciseSets.reduce([], {$0 + $1})
        
        self.currentWorkout?.exercisesSets = exerciseSetsArray
    }
    
    func convertWorkoutToParameters(workout: Workout) -> String {
        var jsonString = String()
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(workout)
            jsonString = String(data: jsonData, encoding: .utf8)!
            
        }
        catch {
        }
        return jsonString
    }
 
    // Label Timera
    @IBOutlet weak var timerLabel: UILabel!
    
    // Button cancelWorkout
    @IBAction func cancelWorkoutTapped(_ sender: Any) {
        createAlert(title: "Cancel Workout?", message: "Do you really want cancel your workout?")
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: { (action) in
            self.currentWorkout = nil
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func addSetToArrayAndToTableView(section: Int) {
        var exerciseSet = ExercisesSet()
        exerciseSet.exercise = groupedSets[section][0].exercise
        exerciseSet.kg = 0
        exerciseSet.reps = 0
        exerciseSet.user = AppUser.shared
        groupedSets[section].append(exerciseSet)
        print(groupedSets.count)
        print(groupedSets[section].count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let profile = ProfileHelper()
//        profile.fetchUsers { (appUser) in
//            if appUser != nil {
//                self.user = appUser
//            }
//        }
    
        
        // Ziskam vsetky Sety z Workoutu
        if(self.currentWorkout != nil && self.currentWorkout?.exercisesSets.count != 0) {
            self.exercisesSetsArray = self.currentWorkout!.exercisesSets
            
            for i in 0..<self.exercisesSetsArray.count {
                self.exercisesSetsArray[i].user = AppUser.shared
            }

            // Vyfiltrujem ich podla Exercise ktore obsahuju, tym padom dostanem Key : Value kde Key je Exercise a Value je Exercise_Set
            self.groupedDict = Dictionary(grouping: self.exercisesSetsArray, by: { (exerciseSet) -> String? in
                return exerciseSet.exercise!.name
            })

            // Zoberiem kluce z dictionary
            self.keys = self.groupedDict.keys

            // Unikatne naplnim 2d pole s exerciseSets
            // tym padom viem vytvorit sekcie s Exercise a ExerciseSet ktore su spolu groupnute
            self.keys.forEach({ (key) in
                self.groupedSets.append(self.groupedDict[key]!)
            })
            self.currentWorkout?.startDate = String(Date().currentTimeMillis())
            self.tableView.reloadData()
        } else {
            self.currentWorkout = Workout(id: 0, duration: 0, startDate: String(Date().currentTimeMillis()), endDate: "", name: "", notes: "", kgLiftedOverall: 0, user: AppUser.shared, exercisesSets: self.exercisesSetsArray)
        }
        
        
        self.session.start()
        
        createTimer()
        
        // pridam observer na prijatie + - sekund z ineho View
        // pridam observer pre prijatie noveho cviku do workoutu
        NotificationCenter.default.addObserver(self, selector: #selector(updateTimer(notification:)), name: .timerUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addExerciseToWorkout(notification:)), name: .addExerciseToWorkout, object: nil)
    }
    
    @objc func addExerciseToWorkout(notification: Notification){
        var exerciseSet: ExercisesSet
        exerciseSet = notification.object as! ExercisesSet
        var sets = [ExercisesSet]()
        sets.append(exerciseSet)
        groupedSets.append(sets)
        self.tableView.reloadData()
    }
    
    func addRowToTableView(indexPath: [IndexPath], section: Int) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPath, with: .automatic)
        tableView.endUpdates()
        tableView.reloadData()
        view.endEditing(true)
    }
    
    
}

// MARK: TableView
extension WorkoutViewModel: UITableViewDataSource, UITableViewDelegate , UITextFieldDelegate{


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groupedSets[section].count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedSets.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == totalRows - 1 {
            addSetToArrayAndToTableView(section: indexPath.section)
            let index = IndexPath(row: groupedSets[indexPath.section].count - 1 , section: indexPath.section)
            addRowToTableView(indexPath: [index], section: indexPath.section)
        } else {
            print("SOM SEELEC")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // TODO: Skusit tahat PREV Z DB
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let totalRows = tableView.numberOfRows(inSection: indexPath.section)
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "staticExerciseCell") else { return UITableViewCell() }
            return cell
        } else if indexPath.row == totalRows - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addSetCell") else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "oneSetCell") as? OneSetInExerciseCell else { return UITableViewCell() }
            cell.setNumber.text = String(indexPath.row)
            let exerciseSet = groupedSets[indexPath.section][indexPath.row-1]
            cell.indexPath = indexPath
            cell.setExerciseSet(exerciseSet: exerciseSet)
            cell.delegate = self
            return cell
        }
    }
    
    // Nastavujem header pre sekciu
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let text = self.groupedSets[section][0].exercise?.name
        label.text = text
        label.backgroundColor = UIColor.blue
        return label
    }
}

extension WorkoutViewModel: OneSetInExerciseCellDelegate {
    
    func didTapCheckButton(kg: String, reps: String, index: IndexPath) {
        self.groupedSets[index.section][index.row-1].kg = Int(kg)
        self.groupedSets[index.section][index.row-1].reps = Int(reps)
        self.groupedSets[index.section][index.row-1].user = AppUser.shared
        print(self.groupedSets[index.section][index.row-1])
    }
    
    
}

// MARK: Timer
extension WorkoutViewModel {
    
    func createTimer() {
        if timer == nil {
            // Nastavim timer na sekundovy interval
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(runWorkoutDurationTimer), userInfo: nil, repeats: true)
            
            // zabranuje stopovaniu timera pri pouzivani UI
            RunLoop.current.add(timer!, forMode: .common)
            
            // Energy efficience
            timer!.tolerance = 0.1
        }
    }
    
    @objc func runWorkoutDurationTimer() {
        counter += 1
        
        // FORMAT HH:MM:SS
        // Prekonvertujem si label na user friendly zobrazenie casu
        
        // zaokruhlim si counter
        let flooredCounter = Int(floor(counter))
        let hour = flooredCounter / 3600
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }
        
        timerLabel.text = "\(hour):\(minuteString):\(secondString)"
    }
}


// MARK: BreakTimer
extension WorkoutViewModel {
    
    // MARK: - FUNKCIE UI
    
    // funkcia pre update hlavneho duration Timera
    func updateBreakTimerLabel() {
        breakTimerLabel.text = String("\(round(secondsLeft))s")
    }
    
    // vypnutie break timeru
    func stopBreakTimer() {
        if breakTimer != nil {
            print("som vynuloval")
            breakTimer?.invalidate()
            breakTimer = nil
        }
    }
    
    @objc func breakTimerTick() {
        // uberiem seconds left za kazdy tick
        if secondsLeft > 0 {
            secondsLeft -= 1
        }
        
        print("Som sa zavolal")
        NotificationCenter.default.post(name: .timer, object: secondsLeft)
        
        // updatnem UI
        updateBreakTimerLabel()
        
        // skontrolujem ci timer uz neskoncil
        if secondsLeft <= 0 {
            stopBreakTimer()
        }
    }
    
    func createBreakTimer() {
        secondsLeft = 10
        updateBreakTimerLabel()
        if breakTimer == nil {
            // zapnem timer s intervalom 1 sekunda
            breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(breakTimerTick), userInfo: nil, repeats: true)

            
            // nastavim koniec timera podla seconds left
            // TODO: TOTO POJDE DO BREAK TIMERA
            endDate = Date().addingTimeInterval(secondsLeft)
            
            // updatnem UI
            updateBreakTimerLabel()
        }
    }
    
    // Nastavi zbyvajuci cas na break ak som v druhom View pridal / ubral sekundy
    @objc func updateTimer(notification: Notification) {
        self.secondsLeft = notification.object as! TimeInterval
    }
}



// MARK: Notifikacia pre observer
extension Notification.Name {
    static let timer = Notification.Name(rawValue: "Timer")
}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

extension Date {
    func currentTimeMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
