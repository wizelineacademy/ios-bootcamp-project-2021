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

    let personName = UILabel()
    let imagePerson = UIImageView()
    let textPerson = UITextView()
    let knownForDepartmentLabel = UILabel()
    let idLabel = UILabel()
    let birthdayLabel = UILabel()
    let deathdayLabel = UILabel()
    let popularityLabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllViews()
        setupPersonNameLabel()
        setupImagePerson()
        setupTextPerson()
        setupStackView()
        configureUIDetailPerson()
        detailPersonID()
        
    }
    
    private func addAllViews() {
        view.addSubview(personName)
        view.addSubview(imagePerson)
        view.addSubview(textPerson)
        view.addSubview(stackView)
        view.backgroundColor = .white
    }
    
    private func setupPersonNameLabel() {
        personName.translatesAutoresizingMaskIntoConstraints = false
        personName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        personName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        personName.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 20).isActive = true
        personName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        personName.textAlignment = .center
        personName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        personName.numberOfLines = 2
    }
    
    private func setupImagePerson() {
        imagePerson.translatesAutoresizingMaskIntoConstraints = false
        imagePerson.topAnchor.constraint(equalTo: personName.bottomAnchor, constant: 10).isActive = true
        imagePerson.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        imagePerson.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20).isActive = true
        imagePerson.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imagePerson.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imagePerson.heightAnchor.constraint(equalTo: imagePerson.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    private func setupTextPerson() {
        textPerson.translatesAutoresizingMaskIntoConstraints = false
        textPerson.topAnchor.constraint(equalTo: imagePerson.bottomAnchor, constant: 10).isActive = true
        textPerson.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textPerson.trailingAnchor, constant: 20).isActive = true
        textPerson.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textPerson.isEditable = false
        textPerson.font = .systemFont(ofSize: 16)
    }
    
    private func setupStackView() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        knownForDepartmentLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        deathdayLabel.translatesAutoresizingMaskIntoConstraints = false
        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: textPerson.bottomAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20).isActive = true
        
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(knownForDepartmentLabel)
        stackView.addArrangedSubview(birthdayLabel)
        stackView.addArrangedSubview(deathdayLabel)
        stackView.addArrangedSubview(popularityLabel)
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
