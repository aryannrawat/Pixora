//
//  WallpaperDetailView.swift
//  Pixora
//
//  Created by Acmeinteh iOS Device  on 14/11/25.
//


import SwiftUI

struct WallpaperDetailView: View {
    var imageName: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            // FULLSCREEN WALLPAPER
            Image(imageName)
                .resizable()
                .scaledToFill()
                .clipped()

            VStack {
                Spacer()

                VStack(spacing: 8) {
                    Text("Sky Travel")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)

                    Text("By AmaanCG · 4K")
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.8))
                }

                .padding(.bottom, 40)

                HStack {
                    
                    // LEFT BUTTON
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 52, height: 52)
                            .background(.white.opacity(0.20))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .frame( alignment: .leading)

                    // CENTER BUTTON
                    Button {} label: {
                        Text("Download")
                            .font(.title3.bold())
                            .foregroundColor(.black)
                            .frame(width: 180, height: 52)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // RIGHT BUTTON
                    Button {} label: {
                        Image(systemName: "bookmark")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 52, height: 52)
                            .background(.white.opacity(0.20))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .frame( alignment: .trailing)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)

                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea()             // <-- FIX: Apply to the entire ZStack
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
