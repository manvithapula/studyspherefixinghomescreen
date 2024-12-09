//
//  studyTechniquesCollectionViewCell.swift
//  studysphere
//
//  Created by admin64 on 07/12/24.
//

import UIKit

class studyTechniquesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spacedRepetitionTextView: UITextView!
    @IBOutlet weak var spacedRepetitionCompletedLabel: UILabel!
    @IBOutlet weak var spacedRepetitionProgressLabel: UILabel!
    
    @IBOutlet weak var activeRecallTextView: UITextView!
    @IBOutlet weak var activeRecallCompletedLabel: UILabel!
    @IBOutlet weak var activeRecallProgressLabel: UILabel!
    
    @IBOutlet weak var summariserTextView: UITextView!
    @IBOutlet weak var summariserCompletedLabel: UILabel!
    @IBOutlet weak var summariserProgressLabel: UILabel!

    func configure(
           title: String,
           spacedRepetition: (text: String, completed: String, progress: String),
           activeRecall: (text: String, completed: String, progress: String),
           summariser: (text: String, completed: String, progress: String)
       ) {
           // Set title
           titleLabel.text = title
           
           // Configure spaced repetition
           spacedRepetitionTextView.text = spacedRepetition.text
           spacedRepetitionCompletedLabel.text = spacedRepetition.completed
           spacedRepetitionProgressLabel.text = spacedRepetition.progress
           
           // Configure active recall
           activeRecallTextView.text = activeRecall.text
           activeRecallCompletedLabel.text = activeRecall.completed
           activeRecallProgressLabel.text = activeRecall.progress
           
           // Configure summariser
           summariserTextView.text = summariser.text
           summariserCompletedLabel.text = summariser.completed
           summariserProgressLabel.text = summariser.progress
       }
   }
    

