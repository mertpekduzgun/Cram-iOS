//
//  BoardViewController.swift
//  Cram
//
//  Created by Mert on 15.01.2020.
//  Copyright © 2020 Mert. All rights reserved.
//

import UIKit
import Firebase

class BoardViewController: BaseViewController {
    
    //    MARK: Outlets
    @IBOutlet weak var announceTableView: UITableView!
    @IBOutlet weak var quizTableView: UITableView!
    @IBOutlet weak var examTableView: UITableView!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var addBoardImageView: UIImageView!
    
    
    //    MARK: Properties
    internal var currentClassName = ""
    
    internal var announceArray: [String] = [] {
        didSet {
            announceTableView.reloadData()
        }
    }
    
    internal var quizArray: [String] = [] {
        didSet {
            quizTableView.reloadData()
        }
    }
    
    internal var examArray: [String] = [] {
        didSet {
            examTableView.reloadData()
        }
    }
    
    
    //    MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.closeImageView.isUserInteractionEnabled = true
        self.closeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closedPressed(animated:))))
        self.addBoardImageView.isUserInteractionEnabled = true
        self.addBoardImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addBoardButtonPressed)))
        getAnnouncements()
        getQuizDates()
        getExamDates()
    }
    
//    MARK: Setup UI
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .close, navigationBarRight: .hidden, navigationBackground: .blue)
        self.title = "Board"
        
        announceTableView.register(UINib(nibName: BoardTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        announceTableView.rowHeight = UITableView.automaticDimension
        announceTableView.estimatedRowHeight = announceTableView.rowHeight
        announceTableView.tableFooterView = UIView(frame: .zero)
        
        quizTableView.register(UINib(nibName: QuizDateTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: QuizDateTableViewCell.reuseIdentifier)
        quizTableView.rowHeight = UITableView.automaticDimension
        quizTableView.estimatedRowHeight = quizTableView.rowHeight
        quizTableView.tableFooterView = UIView(frame: .zero)
        
        examTableView.register(UINib(nibName: ExamDateTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ExamDateTableViewCell.reuseIdentifier)
        examTableView.rowHeight = UITableView.automaticDimension
        examTableView.estimatedRowHeight = examTableView.rowHeight
        examTableView.tableFooterView = UIView(frame: .zero)
    }
    
//    MARK: Add Button
    @objc
    func addBoardButtonPressed() {
        if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: AddBoardViewController.reuseIdentifier) as? AddBoardViewController {
            vc.currentClassName = self.currentClassName
            present(vc, animated: true, completion: nil)
        }
    }
    
//    MARK: Get Announcements
    func getAnnouncements() {
        let firestoreDatabase = Firestore.firestore().collection("boards").whereField("className", isEqualTo: self.currentClassName)
        
        firestoreDatabase.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    self.announceArray.removeAll()
                    for document in snapshot!.documents {
                        self.announceArray = document.get("announcements") as! [String]
                    }
                }
            }
        }
    }
    
//    MARK: Get Quiz Dates
    func getQuizDates() {
        let firestoreDatabase = Firestore.firestore().collection("boards").whereField("className", isEqualTo: self.currentClassName)
        
        firestoreDatabase.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    self.quizArray.removeAll()
                    for document in snapshot!.documents {
                        self.quizArray = document.get("quizDates") as! [String]
                    }
                }
            }
        }
    }
//    MARK: Get Exam Dates
    func getExamDates() {
        let firestoreDatabase = Firestore.firestore().collection("boards").whereField("className", isEqualTo: self.currentClassName)
        
        firestoreDatabase.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    self.examArray.removeAll()
                    for document in snapshot!.documents {
                        self.examArray = document.get("examDates") as! [String]
                    }
                }
            }
        }
    }
}

// MARK: Table View
extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == announceTableView {
            return announceArray.count
        } else if tableView == quizTableView {
            return quizArray.count
        } else {
            return examArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == announceTableView {
            let cell = announceTableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as! BoardTableViewCell
            cell.cellLabel.text = announceArray[indexPath.row]
            return cell
        }
        if tableView == quizTableView {
            let cell = quizTableView.dequeueReusableCell(withIdentifier: QuizDateTableViewCell.reuseIdentifier, for: indexPath) as! QuizDateTableViewCell
            cell.cellLabel.text = quizArray[indexPath.row]
            
            return cell
        }
        if tableView == examTableView {
            let cell = examTableView.dequeueReusableCell(withIdentifier: ExamDateTableViewCell.reuseIdentifier, for: indexPath) as! ExamDateTableViewCell
            cell.cellLabel.text = examArray[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
}
