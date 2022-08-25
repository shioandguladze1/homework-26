//
//  FavoritesViewController.swift
//  homeWork26 (shio andghuladze)
//
//  Created by shio andghuladze on 25.08.22.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var notesTableView: UITableView!
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var notes = [Note]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpTableView()
        getNotes()
    }
    
    private func setUpTableView(){
        notesTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
    private func getNotes(){
        guard let context = context else {
            showAlertWithOkButton(title: "Error", body: "Unknown error")
            return
        }
        
        do {
            let request = Note.fetchRequest()
            let predicate = NSPredicate(format: "isFavorite = %d", true)
            request.predicate = predicate
            let notes = try context.fetch(request)
            self.notes = notes
            self.notesTableView.reloadData()
        }catch {
            showAlertWithOkButton(title: "Error", body: error.localizedDescription)
        }
    }
    

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as? NoteTableViewCell {
            let note = notes[indexPath.row]
            cell.setUp(note: note)
            cell.onDelete = {[weak self] in
                self?.context?.delete(note)
                self?.getNotes()
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailsViewController") as? NoteDetailsViewController{
            vc.note = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            navigationController?.isNavigationBarHidden = false
        }
    }
}
