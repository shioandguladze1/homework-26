//
//  NoteTableViewCell.swift
//  homeWork26 (shio andghuladze)
//
//  Created by shio andghuladze on 25.08.22.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    var onDelete: ()-> Void = {}
    private var onAddToFavorites: ()-> Void = {}
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func setUp(note: Note){
        titleLabel.text = note.title
        configureFavButton(isFavorite: note.isFavorite)

        onAddToFavorites = {
            note.isFavorite = !note.isFavorite
            do {
                try self.context?.save()
                self.configureFavButton(isFavorite: note.isFavorite)
            } catch {
                print(error)
            }
        }
    }
    
    func configureFavButton(isFavorite: Bool){
        let image: UIImage?
        
        if !isFavorite{
            image = UIImage(systemName: "star")
        }else {
            image = UIImage(systemName: "star.fill")
        }
        
        guard let image = image else {
            print("no image")
            return
        }
        
        favoritesButton.setImage(image, for: .normal)
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        onDelete()
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        onAddToFavorites()
    }
}
