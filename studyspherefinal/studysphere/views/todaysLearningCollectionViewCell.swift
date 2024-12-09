//
//  todaysLearningCollectionViewCell.swift
//  studysphere
//
//  Created by admin64 on 07/12/24.
//

import UIKit

class todaysLearningCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
       @IBOutlet weak var learningLabel1: UILabel!
       @IBOutlet weak var learningLabel2: UILabel!
       @IBOutlet weak var learningLabel3: UILabel!
       @IBOutlet weak var learningLabel4: UILabel!

    func configure(
         title: String,
         learningItems: [String]
     ) {
         // Set title
         titleLabel.text = title
         
         // Configure learning labels
         learningLabel1.text = learningItems.indices.contains(0) ? learningItems[0] : ""
         learningLabel2.text = learningItems.indices.contains(1) ? learningItems[1] : ""
         learningLabel3.text = learningItems.indices.contains(2) ? learningItems[2] : ""
         learningLabel4.text = learningItems.indices.contains(3) ? learningItems[3] : ""
     }
 }
