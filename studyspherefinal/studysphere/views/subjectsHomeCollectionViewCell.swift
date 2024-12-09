//
//  subjectsHomeCollectionViewCell.swift
//  studysphere
//
//  Created by admin64 on 07/12/24.
//

import UIKit

class subjectsHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subject1: UITextView!
    @IBOutlet weak var subject2: UITextView!
    @IBOutlet weak var subject3: UITextView!
    @IBOutlet weak var chevronButton: UIButton!
    
    var onChevronTapped: (() -> Void)?

       override func awakeFromNib() {
           super.awakeFromNib()
           chevronButton.addTarget(self, action: #selector(chevronButtonTapped), for: .touchUpInside)
       }

       @objc private func chevronButtonTapped() {
           onChevronTapped?()
       }

       func configure(title: String, subjects: [String], chevronAction: @escaping () -> Void) {
           titleLabel.text = title

           // Configure subjects text views
           subject1.text = subjects.indices.contains(0) ? subjects[0] : ""
           subject2.text = subjects.indices.contains(1) ? subjects[1] : ""
           subject3.text = subjects.indices.contains(2) ? subjects[2] : ""

           // Set Chevron action
           onChevronTapped = chevronAction
       }
   }
