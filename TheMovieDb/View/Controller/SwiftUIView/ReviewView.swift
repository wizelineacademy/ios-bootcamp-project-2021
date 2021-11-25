//
//  ReviewView.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/23/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewView: View {
  
  var review: ReviewViewModel?
  
  func getProfileImage() -> UIImage {
    let image = CacheImageView()
    image.loadImage(urlString: review?.profileImageAuthor)
    guard let uiimage = image.image else { return UIImage(named: "notFoundImage")! }
    return uiimage
  }
  
  var body: some View {
    ZStack {
      Color(DesignColor.black.color)
        .ignoresSafeArea()
      VStack(alignment: .leading) {
        HStack {
          if review?.profileImageAuthor != nil {
            AnimatedImage(url: URL(string: review?.profileImageAuthor ?? "notFoundImage"))
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: SizeAndMeasures.profilePictureBig.measure, height: SizeAndMeasures.profilePictureBig.measure)
              .clipShape(Circle())
          } else {
            Image(uiImage: UIImage(named: "notFoundImage")!)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: SizeAndMeasures.profilePictureBig.measure, height: SizeAndMeasures.profilePictureBig.measure)
              .clipShape(Circle())
              .opacity(0.5)
          }
          VStack(alignment: .leading) {
            Text("Written by")
              .font(.system(size: TextStyle.paragraph.size))
              .fontWeight(.bold)
            .foregroundColor(Color(DesignColor.whiteDirt.color))
            Text(review?.author ?? "username")
              .font(.system(size: TextStyle.paragraph.size))
              .fontWeight(.bold)
              .foregroundColor(Color(DesignColor.gray.color))
          }
          Spacer()
          if review?.score != nil {
            HStack {
              Image(systemName: "star.fill")
                .foregroundColor(Color(DesignColor.gray.color))
              Text(String(review?.score ?? 0))
                .font(.system(size: TextStyle.paragraph.size))
                .fontWeight(.bold)
                .foregroundColor(Color(DesignColor.gray.color))
            }
          }
        }
        .padding(.bottom, SizeAndMeasures.margin.measure)
        ScrollView(.vertical, showsIndicators: false, content: {
          Text(review?.content ?? "We don't have any review here")
            .font(.system(size: TextStyle.paragraph.size))
            .fontWeight(.regular)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color(DesignColor.gray.color))
        })
        Spacer()
      }
      .padding(.all, SizeAndMeasures.margin.measure)
    }
    
  }
}

struct ReviewView_Previews: PreviewProvider {
  static var previews: some View {
    ReviewView()
  }
}
