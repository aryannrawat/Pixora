//
//  FullScreenWallpaperView.swift
//  Pixora
//
//  Created by Acmeinteh iOS Device  on 14/11/25.
//


import SwiftUI

struct FullScreenWallpaperView: View {
    let imageName: String
    let title: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // Fullscreen image
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            // Top bar (Back + Title)
            HStack(spacing: 12) {
                // Back Button
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.black.opacity(0.4))
                        .clipShape(Circle())
                }
                
                // Only Wallpaper Name (no owner)
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(.black.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
            }
            .padding(.top, 55) // Moves below dynamic island
            .padding(.horizontal)
        }
    }
}

# Preview
struct FullScreenWallpaperView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenWallpaperView(
            imageName: "wall1",
            title: "Neon Galaxy"
        )
    }
}
