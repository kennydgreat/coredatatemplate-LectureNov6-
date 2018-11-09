//
//  ViewController.swift
//  CoreDataTest
//
//  Created by MacStudent on 2018-11-06.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // MARK: Outlets
    // ------------------------------
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var labelForshowingAllUsers: UITextView!
    
    // MARK: CoreDta variables
    // ------------------------------
    //context is the interface for the database
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup your CoreData variable
        // ----------------------------------------
        
        // 1. Mandatory - copy and paste this
        // Explanation: try to create/initalize the appDelegate variable.
        // If creation fails, then quit the app
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // 2. Mandatory - initialize the context variable
        // This variable gives you access to the CoreData functions
        self.context = appDelegate.persistentContainer.viewContext

    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Actions
    // ----------------------------
    @IBAction func signupButtonPressed(_ sender: Any) {
        print("Signup button pressed!")
        /*
         Save users to the database
         */
        //1.create a new in the database
        let name = User(context: context)
        
        //S2.set properties
        name.email = usernameField.text
        name.password = passwordField.text
        
        // 3.Save object
        do{
            try self.context.save()
        }catch{
            print("Error occured while saving")
        }
        
        //
        
    }
    
    @IBAction func fetchButtonAction(_ sender: Any) {
        //This is the same as: SELECT 
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do{
            var users = try self.context.fetch(fetchRequest)
            print(users)
            var textToDisplay :String = ""
            var counter = 0
            for user in users {
                counter = counter + 1
                textToDisplay += "User \(counter) info\n  Email: \(user.email!)\n  Password: \(user.password!)\n"
            }
            labelForshowingAllUsers.text = textToDisplay
        }catch{
            print("Error fetching from database")
        }
        
    }
}

