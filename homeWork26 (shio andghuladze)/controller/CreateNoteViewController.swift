//
//  CreateNoteViewController.swift
//  homeWork26 (shio andghuladze)
//
//  Created by shio andghuladze on 25.08.22.
//

import UIKit

class CreateNoteViewController: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var onSuccess: ()-> Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func createNote(_ sender: Any) {
        guard let title = titleTF.text else {
            showAlertWithOkButton(title: "Error", body: "Fields are empty")
            return
        }
        
        guard let description = descriptionTF.text else {
            showAlertWithOkButton(title: "Error", body: "Fields are empty")
            return
        }
        
        guard let context = context else {
            showAlertWithOkButton(title: "Error", body: "Unknown error")
            return
        }
        
        let note = Note(context: context)
        note.title = title
        note.details = description
        note.isFavorite = false
        
        do {
            try context.save()
            dismiss(animated: true)
            onSuccess()
        }catch {
            showAlertWithOkButton(title: "Error", body: error.localizedDescription)
        }
    }

}
