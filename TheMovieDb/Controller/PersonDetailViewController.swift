//
//  PersonDetailViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    var person: Person?
    var personID: Int?
    
    @IBOutlet weak var personName: UILabel!
   
    @IBOutlet weak var imagePerson: UIImageView!
    
    @IBOutlet weak var textPerson: UITextView!
    
    @IBOutlet weak var knownForDepartmentLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var deathdayLabel: UILabel!
    
    @IBOutlet weak var popularityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = false
        
        detailPersonID()
        
    }
    
    func detailPersonID() {
        guard let id = personID else { return }
        MovieFacade.get(endpoint: .personDetails(id: id)) { [weak self] (response: Result<Person, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let person):
                self.person = person
                DispatchQueue.main.async {
                    self.personName.text = person.name
                    self.imagePerson.setImage(path: person.profilePath)
                    self.idLabel.text = "ID: \(person.id ?? 0)"
                    self.popularityLabel.text = "Popularity: \(person.popularity ?? 0.0)"
                    self.knownForDepartmentLabel.text = "Known for Department: \(person.knownForDepartment ?? "Unavailable")"
                    self.textPerson.text = "Biography: \(person.biography ?? "Unavailable")"
                    self.birthdayLabel.text = "Birthday: \(person.birthday ?? "Unavailable")"
                    self.deathdayLabel.text = "Deathday: \(person.deathday ?? "Alive")"
                }
            case .failure(let failureResult):
                print(failureResult.localizedDescription)
            }
        }
    }

}
