//
//  Feed.swift
//  BP-DIFR
//
//  Created by jkbjhs on 03/05/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation

struct Feed {
    let authorOfPost: String
    let postText: String
    let timeOfPost: String
    let workoutDate: String
    let workoutDuration: String
    let workoutKgLifted: String
    let workoutNumberOfExercises: String
    
    init(authorOfPost: String, postText: String, timeOfPost: String, workoutDate: String, workoutDuration: String, workoutKgLifted: String, workoutNumberOfExercises: String) {
        self.authorOfPost = authorOfPost
        self.postText = postText
        self.timeOfPost = timeOfPost
        self.workoutDate = workoutDate
        self.workoutDuration = workoutDuration
        self.workoutKgLifted = workoutKgLifted
        self.workoutNumberOfExercises = workoutNumberOfExercises
    }
}
