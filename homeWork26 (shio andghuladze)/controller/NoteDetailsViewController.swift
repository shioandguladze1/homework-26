//
//  NoteDetailsViewController.swift
//  homeWork26 (shio andghuladze)
//
//  Created by shio andghuladze on 25.08.22.
//

import UIKit

class NoteDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    weak var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = note?.title
        detailsLabel.text = note?.details
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
}
