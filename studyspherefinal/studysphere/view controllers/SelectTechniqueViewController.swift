//
//  SelectTechniqueViewController.swift
//  studysphere
//
//  Created by dark on 17/11/24.
//

import UIKit

class SelectTechniqueViewController: UIViewController {
    var topic:String?
    var date:Date?
    var subject:Subject?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func createSR(_ sender: Any) {
        var newTopic = Topics(id: "", title: topic!, subject: subject!.id, type: .flashcards,subtitle: "6 more to go",createdAt: Date(),updatedAt: Date())
        newTopic = topicsDb.create(&newTopic)
        _ = createFlashCards(topic: newTopic.id)
        let mySchedules = spacedRepetitionSchedule(startDate: Date(), title:newTopic.title,topic: newTopic.id,topicsType: TopicsType.flashcards)
        for var schedule in mySchedules{
            let _ = schedulesDb.create(&schedule)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = tabBarVC
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.makeKeyAndVisible()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let navigationVC = tabBarVC.viewControllers?.first(where: { $0 is UINavigationController }) as? UINavigationController,
                   let homeVC = navigationVC.viewControllers.first(where: { $0 is homeScreenViewController }) as? homeScreenViewController {
                    homeVC.performSegue(withIdentifier: "toSRList", sender: nil)
                } else {
                    print("Error: HomeViewController is not properly embedded in UINavigationController under TabBarController.")
                }
            }
        } else {
            print("Error: Could not instantiate TabBarController.")
        }
        
        
        
    }
    @IBAction func createAR(_ sender: Any) {
        var newTopic = Topics(id: "", title: topic!, subject: subject!.id, type: .quizzes,subtitle: "6 more to go",createdAt: Date(),updatedAt: Date())
        newTopic = topicsDb.create(&newTopic)
        for var question in ARQuestions{
            question.topic = newTopic.id
            let _ = questionsDb.create(&question)
        }
        let mySchedules = spacedRepetitionSchedule(startDate: Date(), title:newTopic.title,topic: newTopic.id,topicsType: TopicsType.quizzes)
        for var schedule in mySchedules{
            let _ = schedulesDb.create(&schedule)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = tabBarVC
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.makeKeyAndVisible()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let navigationVC = tabBarVC.viewControllers?.first(where: { $0 is UINavigationController }) as? UINavigationController,
                   let homeVC = navigationVC.viewControllers.first(where: { $0 is homeScreenViewController }) as? homeScreenViewController {
                    homeVC.performSegue(withIdentifier: "toArList", sender: nil)
                } else {
                    print("Error: HomeViewController is not properly embedded in UINavigationController under TabBarController.")
                }
            }
        } else {
            print("Error: Could not instantiate TabBarController.")
        }
    }
    
    @IBAction func createSummarizer(_ sender: Any) {
        var newTopic = Topics(id: "", title: topic!, subject: subject!.id, type: .summary,subtitle: "",createdAt: Date(),updatedAt: Date())
        newTopic = topicsDb.create(&newTopic)
        _ = createSummary(topic: newTopic.id)
        let mySchedules = spacedRepetitionSchedule(startDate: Date(), title:newTopic.title,topic: newTopic.id,topicsType: TopicsType.summary)
        for var schedule in mySchedules{
            let _ = schedulesDb.create(&schedule)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = tabBarVC
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.makeKeyAndVisible()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let navigationVC = tabBarVC.viewControllers?.first(where: { $0 is UINavigationController }) as? UINavigationController,
                   let homeVC = navigationVC.viewControllers.first(where: { $0 is homeScreenViewController }) as? homeScreenViewController {
                    homeVC.performSegue(withIdentifier: "toSummaryList", sender: nil)
                } else {
                    print("Error: HomeViewController is not properly embedded in UINavigationController under TabBarController.")
                }
            }
        } else {
            print("Error: Could not instantiate TabBarController.")
        }
        
      
        }
    private func createSummary(topic:String) -> Summary{
        var summary:Summary = Summary( id: "", topic: topic,data: "sdfasasdsadad", createdAt: Date(), updatedAt: Date())
        summary = summaryDb.create(&summary)

        return summary
    }
            
            private func createFlashCards(topic:String) -> [Flashcard]{
                let flashcards1: [Flashcard] = [
                    Flashcard(id: "", question: "What is the capital of France?", answer: "Paris",topic:topic, createdAt: Date(), updatedAt: Date()),
                    Flashcard(id: "", question: "What is the capital of Germany?", answer: "Berlin",topic: topic, createdAt: Date(), updatedAt: Date()),
                    Flashcard(id: "", question: "What is the capital of Italy?", answer: "Rome",topic: topic, createdAt: Date(), updatedAt: Date()),
                    Flashcard(id: "", question: "What is the capital of Spain?", answer: "Madrid",topic: topic, createdAt: Date(), updatedAt: Date()),
                    Flashcard(id: "", question: "What is the capital of Sweden?", answer: "Stockholm",topic: topic, createdAt: Date(), updatedAt: Date()),
                    Flashcard(id: "", question: "What is the capital of Norway?", answer: "Oslo",topic: topic, createdAt: Date(), updatedAt: Date()),
                    Flashcard(id: "", question: "What is the capital of Finland?", answer: "Helsinki",topic: topic, createdAt: Date(), updatedAt: Date()),
                ]
                for var flashcard in flashcards1{
                    let _ = flashCardDb.create(&flashcard)
                }
                return flashcards1
            }
            private func showAlert(title: String, message: String) {
                let alert = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        }
        

