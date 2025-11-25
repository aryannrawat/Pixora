//
//  ContentView.swift
//  Pixora
//
//  Created by Acmeinteh iOS Device on 13/11/25.
//
//
//  HomeView.swift
//  Pixora
//

import SwiftUI

struct HomeView: View {

    init() {
        UIView.appearance().overrideUserInterfaceStyle = .dark
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Namespace private var animation
    @State private var selectedImage: String? = nil
    @State private var wallpapers = ["1", "2", "3", "4", "5", "6", "8", "9", "10","11"]
    @State private var showBars = true
    @State private var selectedCategory = "All"
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {

                        // MARK: Header + Search
                        VStack(spacing: 10) {
                            Text("PIXORA")
                                .font(.system(size: 25, weight: .heavy))
                                .kerning(2)
                                .foregroundColor(.white)

                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white.opacity(0.6))
                                Text("Search wallpapers...")
                                    .foregroundColor(.white.opacity(0.6))
                                Spacer()
                            }
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black.opacity(0.6), radius: 4)
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)

                        
                        // MARK: Category Chips
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(["All", "Nature", "Amoled", "Anime", "City"], id: \.self) { cat in
                                    Text(cat)
                                        .font(.callout.bold())
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(
                                            selectedCategory == cat ?
                                            Color.white.opacity(0.15) :
                                            Color.white.opacity(0.08)
                                        )
                                        .clipShape(Capsule())
                                        .scaleEffect(selectedCategory == cat ? 1.1 : 1.0)
                                        .animation(.spring(response: 0.4), value: selectedCategory)
                                        .onTapGesture {
                                            haptic(.medium)
                                            withAnimation(.spring()) {
                                                selectedCategory = cat
                                                wallpapers.shuffle()
                                             }
                                         }
                                     }
                                 }
                            .padding(.horizontal)
                        }


                        // MARK: Wallpapers Grid
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(Array(wallpapers.enumerated()), id: \.element) { index, name in
                                
                                NavigationLink(value: name) {
                                    WallpaperCard(imageName: name)
                                        .matchedGeometryEffect(id: name, in: animation)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .staggered(index)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .padding(.bottom, 100)
                }
                
                
                // MARK: Bottom Tab Bar
                FloatingBottomTab()
            }
            .navigationDestination(for: String.self) { imageName in
                WallpaperDetailView(imageName: imageName)
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    HomeView()
}


// MARK: - Header View
struct HeaderView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("13 November · 0 Walls")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                Text("DAILY")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            
            Image("user")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        showProfile.toggle()
                    }
                }
            }
        .padding(.top, 16)
    }
}

// MARK: - Category Chip
struct CategoryChip: View {
    var title: String
    var selected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(selected ? Color.white.opacity(0.15) : Color.white.opacity(0.08))
            .foregroundColor(.white)
            .cornerRadius(20)
    }
}

// MARK: - Wallpaper Card
struct WallpaperCard: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width / 3 - 12,
                   height: UIScreen.main.bounds.height / 4.5)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .clipped()
            .shadow(color: .black.opacity(0.5), radius: 4)
    }
}

// MARK: - Bottom Bar
struct FloatingBottomTab: View {
    @State private var tab = 0
    let icons = ["house", "square.grid.2x2", "sparkles", "bookmark"]

    var body: some View {
        HStack(spacing: 50) {
            ForEach(0..<icons.count, id: \.self) { i in
                VStack(spacing: 6) {
                    Image(systemName: icons[i])
                        .font(.system(size: 22, weight: .medium))
                        .scaleEffect(tab == i ? 1.2 : 1.0)
                        .foregroundColor(tab == i ? .white : .black.opacity(1))
                        .animation(.spring(response: 0.3), value: tab)

                    if tab == i {
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(.white)
                            .transition(.scale)
                    }
                }
                .onTapGesture {
                    haptic(.soft)
                    tab = i
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.6), radius: 8)
        .padding(.horizontal, 30)
        .frame(height: 85)
    }
}


// MARK: - Scroll PreferenceKey
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func staggered(_ index: Int) -> some View {
        self
            .opacity(1)
            .offset(y: 8)
            .animation(
                .spring(response: 0.35, dampingFraction: 0.75)
                .delay(0.03 * Double(index)),
                value: index
            )
    }
}

// MARK: - HAPTIC FUNCTION
func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .heavy) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
}
