//
//  SectionBuilder.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class SectionBuilder {
  
  var item: NSCollectionLayoutItem?
  var group: NSCollectionLayoutGroup?
  var section: NSCollectionLayoutSection?
  
  func createItem(width: CGFloat, height: CGFloat) -> SectionBuilder {
    self.item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(width), heightDimension: .fractionalHeight(height)))
    return self
  }
  
  func itemConstraints(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> SectionBuilder {
    self.item?.contentInsets = .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    return self
  }
  
  func createGroupHorizontal(width: CGFloat, height: CGFloat) -> SectionBuilder {
    guard let item = self.item else { fatalError("you need to create first the item") }
    self.group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(width), heightDimension: .estimated(height)), subitems: [item])
    return self
  }
  
  func createGroupVertical(width: CGFloat, height: CGFloat, estimated: Bool) -> SectionBuilder {
    guard let item = self.item else { fatalError("you need to create first the item") }
    self.group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(width), heightDimension: estimated ? .estimated(height) : .fractionalHeight(height)), subitems: [item])
    return self
  }
  
  func groupConstraints(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> SectionBuilder {
    self.group?.contentInsets = .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    return self
  }
  
  func createSection() -> SectionBuilder {
    guard let group = self.group else { fatalError("you need to create first the group") }
    self.section = NSCollectionLayoutSection(group: group)
    return self
  }
  
  func sectionConstraints(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) -> SectionBuilder {
    self.section?.contentInsets = .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    return self
  }
  
  func sectionBehavior(behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> SectionBuilder {
    self.section?.orthogonalScrollingBehavior = behavior
    return self
  }
  
  func suplementaryView(width: CGFloat, height: CGFloat, elementKind: String, alignment: NSRectAlignment) -> SectionBuilder {
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(width), heightDimension: .estimated(height)), elementKind: elementKind, alignment: alignment)
    self.section?.boundarySupplementaryItems = [header]
    return self
  }
  
  func build() -> NSCollectionLayoutSection {
    guard let section = self.section else { fatalError("you need to create first the section") }
    return section
  }
  
}
