//
//  PersonDetailViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

final class PersonDetailViewController: UIViewController {
    
    var person: Person? {
        didSet {
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
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
        
        configureUIDetailPerson()
        detailPersonID()
        
    }
    
    func detailPersonID() {
        guard let id = personID else { return }
        MovieFacade.get(endpoint: .personDetails(id: id)) { [weak self] (response: Result<Person, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let person):
                self.person = person
            case .failure(let failureResult):
                self.showErrorAlert(failureResult)
            }
        }
    }

    func configureUIDetailPerson() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupUI() {
        personName.text = person?.name
        imagePerson.setImage(path: person?.profilePath)
        idLabel.text = "ID: \(person?.id ?? 0)"
        popularityLabel.text = "Popularity: \(person?.popularity ?? 0.0)"
        knownForDepartmentLabel.text = "Known for Department: \(person?.knownForDepartment ?? "Unavailable")"
        textPerson.text = "Biography: \(person?.biography ?? "Unavailable")"
        birthdayLabel.text = "Birthday: \(person?.birthday ?? "Unavailable")"
        deathdayLabel.text = "Deathday: \(person?.deathday ?? "Alive")"
    }
}
