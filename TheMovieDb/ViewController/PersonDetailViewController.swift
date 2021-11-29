//
//  PersonDetailViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit
import os.log

final class PersonDetailViewController: UIViewController {
    
    var viewModel: PersonDetailViewModel?
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
    
    init(facade: MovieService) {
        super.init(nibName: nil, bundle: nil)
        viewModel = PersonDetailViewModel(facade: facade)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllViews()
        viewModel?.loadPerson = { [weak self] in self?.setupUI() }
        setupPersonNameLabel()
        setupImagePerson()
        setupTextPerson()
        setupStackView()
        configureUIDetailPerson()
        viewModel?.detailPersonID()
        os_log("PersonDetailViewController did load!", log: OSLog.viewCycle, type: .debug)
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
        view.trailingAnchor.constraint(equalTo: personName.trailingAnchor, constant: 20).isActive = true
        personName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        personName.textAlignment = .center
        personName.numberOfLines = 2
    }
    
    private func setupImagePerson() {
        imagePerson.translatesAutoresizingMaskIntoConstraints = false
        imagePerson.topAnchor.constraint(equalTo: personName.bottomAnchor, constant: 10).isActive = true
        imagePerson.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(greaterThanOrEqualTo: imagePerson.trailingAnchor, constant: 20).isActive = true
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
    
    func configureUIDetailPerson() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupUI() {
        personName.text = viewModel?.person?.name
        imagePerson.setImage(path: viewModel?.person?.profilePath)
        idLabel.text = "ID: \(viewModel?.person?.id ?? 0)"
        let popularity = "popularity.person".localized
        popularityLabel.text = String(format: popularity, "\(viewModel?.person?.popularity ?? 0.0)")
        let knownFor = "known.for.department".localized
        knownForDepartmentLabel.text = String(format: knownFor, viewModel?.person?.knownForDepartment ?? "unavailable".localized)
        let biography = "biography".localized
        textPerson.text = String(format: biography, viewModel?.person?.biography ?? "unavailable".localized)
        let birthday = "birthday".localized
        birthdayLabel.text = String(format: birthday, viewModel?.person?.birthday ?? "unavailable".localized)
        let deathday = "deathday".localized
        deathdayLabel.text = String(format: deathday, viewModel?.person?.deathday ?? "unavailable".localized)
    }
}
