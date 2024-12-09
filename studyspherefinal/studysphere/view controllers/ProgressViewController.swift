//
//  ProgressViewController.swift
//  studysphere
//
//  Created by dark on 02/11/24.
//

import UIKit

class ProgressViewController: UIViewController {
    @IBOutlet weak var flashcardMainL: UILabel!
    @IBOutlet weak var questionMainL: UILabel!
    @IBOutlet weak var hourMainL: UILabel!
    @IBOutlet weak var flashcardSecondaryL: UILabel!
    @IBOutlet weak var questionSecondaryL: UILabel!
    @IBOutlet weak var timeValueL: UILabel!
    @IBOutlet weak var timeTypeL: UILabel!
    @IBOutlet weak var streakValueL: UILabel!
    @IBOutlet weak var streakTypeL: UILabel!
    
    @IBOutlet weak var flashcardP: UIProgressView!
    @IBOutlet weak var questionP: UIProgressView!
    
    @IBOutlet weak var progressT: UISegmentedControl!
    
    @IBOutlet weak var multiProgressRing: MultiProgressRingView!
    
    
    fileprivate func updateUI() {
        // Do any additional setup after loading the view.
        let timeInterval = progressT.selectedSegmentIndex == 0 ? Calendar.Component.weekOfYear: Calendar.Component.month
        let flashcardsProgress = createProgress(type: TopicsType.flashcards,timeInterval:timeInterval)
        let questionsProgress = createProgress(type: TopicsType.quizzes,timeInterval: timeInterval)
        
        multiProgressRing.setProgress(blue: hours.progress, green: questionsProgress.progress, red: flashcardsProgress.progress, animated: true)
        flashcardMainL.text = "\(flashcardsProgress.completed) Flashcards"
        questionMainL.text = "\(questionsProgress.completed) Questions"
        hourMainL.text = "\(hours.completed) Hours"
        
        flashcardSecondaryL.text = "\(flashcardsProgress.total) Flashcards reviewed"
        questionSecondaryL.text = "\(questionsProgress.total) Questions reviewed"
        
        flashcardP.setProgress(Float(flashcardsProgress.progress), animated: true)
        questionP.setProgress(Float(questionsProgress.progress), animated: true)
        updateTimeNStreak(time: weeklyTime, streak: weeklyStreak)
    }
    
    func updateTimeNStreak(time:Int,streak:Int) {
        if(time < 1000 * 60){
            timeValueL.text = "\(time/1000)"
            timeTypeL.text = "secs"
        }
        else if (time < 1000 * 60 * 60){
            let minutes = time/1000/60
            timeValueL.text = "\(minutes)"
            timeTypeL.text = "mins"
        }
        else{
            let hours = time/1000/60/60
            timeValueL.text = "\(hours)"
            timeTypeL.text = "hours"
        }
        streakValueL.text = "\(streak)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        
    }
    @IBAction func toggleAction(_ sender: UISegmentedControl) {
        updateUI()
    }
    private func getLastWeekCount(type:TopicsType,timeInterval:Calendar.Component) -> Int {
        let lastWeek = Calendar.current.date(byAdding: timeInterval, value: -1, to: Date())!
        let schedules = schedulesDb.findAll(where: ["topicType":type])
        let lastWeekSchedules = schedules.filter{
            $0.date >= lastWeek && $0.date <= Date()
        }
        return lastWeekSchedules.count
    }
    private func getLastWeekCompletedCount(type:TopicsType,timeInterval:Calendar.Component) -> Int {
        let lastWeek = Calendar.current.date(byAdding: timeInterval, value: -1, to: Date())!
        let schedules = schedulesDb.findAll(where: ["topicType":type])
        let lastWeekSchedules = schedules.filter{
            $0.date >= lastWeek && $0.date <= Date() && $0.completed != nil
        }
        return lastWeekSchedules.count
    }
    private func createProgress(type:TopicsType,timeInterval:Calendar.Component) -> ProgressType {
        let lastWeekCount = getLastWeekCount(type: type,timeInterval: timeInterval)
        let lastWeekCompletedCount = getLastWeekCompletedCount(type: type,timeInterval: .weekOfYear)
        return ProgressType(completed: lastWeekCompletedCount, total: lastWeekCount)
    }
}
