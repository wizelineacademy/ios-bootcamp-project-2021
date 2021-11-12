//
//  ExtraInfoCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class ExtraInfoCell: BaseCell {
  
  static let identifier = "ExtraInfoCell"
  
  var movieDetails: MovieDetails? {
    didSet {
      setupData()
    }
  }
  
  let titleOriginalLanguage = LabelBuilder()
    .fontStyle(textStyle: .caption, weight: .bold)
    .setColor(color: .darkGray)
    .setText(text: "Original Language")
    .build()
  
  let titleStatus = LabelBuilder()
    .fontStyle(textStyle: .caption, weight: .bold)
    .setColor(color: .darkGray)
    .setText(text: "Status")
    .build()
  
  let titleBudget = LabelBuilder()
    .fontStyle(textStyle: .caption, weight: .bold)
    .setColor(color: .darkGray)
    .setText(text: "Budget                                                      ")
    .build()
  
  let titleRevenue = LabelBuilder()
    .fontStyle(textStyle: .caption, weight: .bold)
    .setColor(color: .darkGray)
    .setText(text: "Revenue                                                     ")
    .build()
  
  var languageLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .setColor(color: .gray)
    .setText(text: "Original Language")
    .build()
  
  var statusLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .setColor(color: .gray)
    .setText(text: "Status")
    .build()
  
  var budgetLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .setColor(color: .gray)
    .setText(text: "Budget")
    .build()
  
  var revenueLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .setColor(color: .gray)
    .setText(text: "Revenue")
    .build()
    
  override func setupView() {
    
    let languageStack = VerticalStackView(arrangedSubviews: [titleOriginalLanguage, languageLabel], spacing: UIStackView.spacingUseSystem)
    let statusStack = VerticalStackView(arrangedSubviews: [titleStatus, statusLabel], spacing: UIStackView.spacingUseSystem)
    let budgetStack = VerticalStackView(arrangedSubviews: [titleBudget, budgetLabel], spacing: UIStackView.spacingUseSystem)
    let revenueStack = VerticalStackView(arrangedSubviews: [titleRevenue, revenueLabel], spacing: UIStackView.spacingUseSystem)
    
    [languageStack, statusStack, budgetStack, revenueStack].forEach { stack in
      stack.backgroundColor = DesignColor.whiteDirt.color
      stack.isLayoutMarginsRelativeArrangement = true
      stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      stack.distribution = .fillEqually
      stack.layer.cornerRadius =  10
    }
    
    let languageStatusStack = VerticalStackView(arrangedSubviews: [languageStack, statusStack], spacing: UIStackView.spacingUseSystem)
    let budgetRevenueStack = VerticalStackView(arrangedSubviews: [budgetStack, revenueStack], spacing: UIStackView.spacingUseSystem)
    
    languageStatusStack.distribution = .fillEqually
    budgetRevenueStack.distribution = .fillEqually
    budgetRevenueStack.alignment = .leading
        
    let allStack = HorizontalStackView(arrangedSubviews: [languageStatusStack, budgetRevenueStack], spacing: UIStackView.spacingUseSystem)
    allStack.distribution = .fillEqually
    addSubview(allStack)
    allStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    
  }
  
  override func setupData() {
    guard let budget = movieDetails?.getNumberFormat(dollars: movieDetails?.budget ?? 0),
          let revenue = movieDetails?.getNumberFormat(dollars: movieDetails?.revenue ?? 0),
          let status = movieDetails?.status,
          let language = movieDetails?.originalLanguage
    else { return }
    
    self.budgetLabel.text = budget
    self.revenueLabel.text = revenue
    self.statusLabel.text = status
    self.languageLabel.text = language.capitalized
    
  }
  
}
