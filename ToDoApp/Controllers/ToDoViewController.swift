//
//  ToDoViewController.swift
//  ToDoApp
//
//  Created by Syimyk on 10/19/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import Firebase
import SwipeCellKit

class ToDoViewController: UIViewController {
   
    
    
    let db = Firestore.firestore()
    
    var todosArray : [Todos] = []

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var currentUser : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        title = "Manage your todo's"
        navigationItem.hidesBackButton = true
        currentUser = Auth.auth().currentUser!.email!
        loadTodos()
    }
    //reading data
    func loadTodos(){
        db.collection(currentUser)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                self.todosArray = []
                if let e = error{
                    print("error on retrieving data from firestore\(e)")
                }else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        for doc in snapshotDocuments{
                            let data = doc.data()
                            if let todoBody = data[K.FStore.bodyField] as? String, let id = data[K.FStore.docId] as? String{
                                let newElement = Todos(todoBody: todoBody, todoId: id)
                                self.todosArray.append(newElement)
                                DispatchQueue.main.async {
                                    self.table.reloadData()
                                    let indexPath = IndexPath(row: self.todosArray.count - 1, section: 0)
                                    self.table.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                        }
                    }
                }
                
        }
    }
    
    
    
    
    //adding data
    @IBAction func addPressed(_ sender: UIButton) {
        if let todoBody = textField.text, let user = Auth.auth().currentUser?.email{
            
            db.collection("\(user)").document("\(todosArray.count)").setData([K.FStore.bodyField : todoBody, K.FStore.dateField : Date().timeIntervalSince1970, K.FStore.docId : "\(todosArray.count)"]){ (error) in
                if let e = error{
                    print("There was issue in saving data to firestore\(e)")
                }else{
                    self.textField.text = ""
                }
            }
        }
    }
    
    
    //logging out a user
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
          navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - UITableViewDataSource
extension ToDoViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = "\(indexPath.row + 1). \(todosArray[indexPath.row].todoBody)"
        return cell
    }
}


//MARK: - SwipeTableViewCellDelegate
extension ToDoViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
           guard orientation == .right else { return nil }
            
              let deleteAction = SwipeAction(style: .destructive, title: "Done") { action, indexPath in
                self.db.collection(self.currentUser).document("\(self.todosArray[indexPath.row].todoId)").delete() { error in
                      if let e = error {
                          print("Error removing document: \(e)")
                      } else {
                          self.table.reloadData()
                      }
                  }
              }

              // customize the action appearance
              deleteAction.image = UIImage(named: "delete")

              return [deleteAction]
       }
}
