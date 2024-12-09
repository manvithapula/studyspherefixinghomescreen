//
//  streaksCollectionViewCell.swift
//  studysphere
//
//  Created by admin64 on 07/12/24.
//

import UIKit

class streaksCollectionViewCell: UICollectionViewCell {
    @IBOutlet var streaks: UIImageView!
    @IBOutlet weak var streakLabel: UILabel!
  
        func configure(with streak: StreakDay) {
            streaks.image = streak.isCompleted ? UIImage(systemName: "flame") : UIImage(systemName: "circle.dotted")
            streaks.tintColor = streak.isCompleted ? .red : .black
            streakLabel.text = streak.dayOfWeek
        }
    }

