//
//  ReviewDetailViewUI.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 22/11/21.
//

import SwiftUI

struct ReviewDetailViewUI: View {
   @ObservedObject var presenter: ReviewDetailPresenter
    var body: some View {
        ScrollView {
            Text(presenter.review?.content ?? "")
        }.padding(
            EdgeInsets(
                top: InterfaceConst.initZeroValue,
                leading: InterfaceConst.secondaryPadding,
                bottom: InterfaceConst.initZeroValue,
                trailing: InterfaceConst.secondaryPadding)
        )
        .navigationTitle(presenter.review?.author ?? "")
    }
    
}
