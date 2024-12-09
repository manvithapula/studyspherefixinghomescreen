//
//  AReditViewController.swift
//  studysphere
//
//  Created by Dev on 16/11/24.
//

import UIKit

class AReditViewController: UIViewController {

    @IBOutlet weak var ARedittable: UITableView!
    var datePicker: UIDatePicker?
    var activeIndexPath: IndexPath?
    var datePickerToolbar: UIToolbar?
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    fileprivate func setupTableView() {
        ARedittable.delegate = self
        ARedittable.dataSource = self
        
        ARedittable.backgroundColor = .systemGray6
        ARedittable.isScrollEnabled = false
        ARedittable.layer.cornerRadius = 12
        ARedittable.clipsToBounds = true
    }
    private func updateTableHeight() {
        // Calculate total height of all rows
        let numberOfRows = schedules.count
        var totalHeight: CGFloat = 0
        
        for _ in 0..<numberOfRows {
            totalHeight += max(ARedittable.rowHeight,43.5)
            print(ARedittable.rowHeight)
        }
        print(totalHeight)
        // Update height constraint
        tableHeightConstraint.constant = totalHeight
        
        // Force layout update
        view.layoutIfNeeded()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",style:.done, target: self, action: #selector(doneButtonTapped))
        
        setupTableView()

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeight()
    }


}

extension AReditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schedule = schedules[indexPath.row]
        let cell = ARedittable.dequeueReusableCell(withIdentifier: "ARedit", for: indexPath)
        cell.textLabel?.text = "Session \(indexPath.row + 1)"
        cell.detailTextLabel?.text = ""
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        button.setTitle(formatDateToString(date: schedule.date), for: .normal)
        
        button.tag = indexPath.row
        button.addTarget(self, action: #selector(dateButtonTapped(_:)), for: .touchUpInside)
        button.tintColor = .gray
        button.backgroundColor = .clear
        
        cell.accessoryView = button
        cell.selectionStyle = .none
        cell.backgroundColor = .systemGray6
        
        return cell
    }
    @objc func dateButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        showDatePicker(for: indexPath)
    }
    @objc func dateChanged(_ sender: UIDatePicker) {
        if let indexPath = activeIndexPath {
            schedules[indexPath.row].date = sender.date
            ARedittable.reloadRows(at: [indexPath], with: .none)
        }
    }
    func showDatePicker(for indexPath: IndexPath) {
            
            if datePicker == nil {
                setupDatePicker()
            }
            
            // Set current date
            datePicker?.date = schedules[indexPath.row].date
            activeIndexPath = indexPath
            
            // Show date picker and toolbar
            datePicker?.isHidden = false
            datePickerToolbar?.isHidden = false
        }
    
    private func setupDatePicker() {
            datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
            datePicker?.preferredDatePickerStyle = .wheels
            datePicker?.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
            
            // Create toolbar
            datePickerToolbar = UIToolbar()
            datePickerToolbar?.sizeToFit()
            
            // Done button
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDoneButtonTapped))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            datePickerToolbar?.setItems([flexSpace, doneButton], animated: false)
            
            // Add toolbar and picker to view
            if let toolbar = datePickerToolbar, let picker = datePicker {
                view.addSubview(toolbar)
                view.addSubview(picker)
                
                // Position toolbar and date picker
                toolbar.translatesAutoresizingMaskIntoConstraints = false
                picker.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    toolbar.bottomAnchor.constraint(equalTo: picker.topAnchor),
                    toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    
                    picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    picker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            }
        }
        

    @objc func doneButtonTapped() {
        performSegue(withIdentifier: "unwindToSchedule", sender: nil)
        }
    @objc func nameTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("hi")
    }
    @objc func datePickerDoneButtonTapped() {
            // Hide date picker and toolbar
            datePicker?.isHidden = true
            datePickerToolbar?.isHidden = true
            
            // Update the table if needed
            if let activeIndexPath = activeIndexPath {
                ARedittable.reloadRows(at: [activeIndexPath], with: .none)
            }
        }
    
}
