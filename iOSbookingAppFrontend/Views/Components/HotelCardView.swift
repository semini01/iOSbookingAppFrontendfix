//
//  HotelCardView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-17.
//
//
import SwiftUI

struct HotelCardView: View {
    let hotel: Hotel
    @State private var isFavourite = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
                    
                    // Image + Heart overlay
                    ZStack(alignment: .topTrailing) {
                        if let url = URL(validImageString: hotel.imageUrl) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.main.bounds.width * 0.85, height: 160)
                                        .clipped()
                                        .overlay(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.clear, .black.opacity(0.35)]),
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                case .failure(_), .empty:
                                    placeholderImage
                                        .frame(width: UIScreen.main.bounds.width * 0.85, height: 160)
                                @unknown default:
                                    placeholderImage
                                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
                                }
                            }
                        } else {
                            placeholderImage
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
                        }
                        
                       
                        Button(action: {
                            isFavourite.toggle()
                        }, label: {
                            Image(systemName: isFavourite ? "heart.fill" : "heart")
                                .foregroundColor(isFavourite ? .red : .white)
                                .padding(8)
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        })
                        .padding(10)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 3)
                    
                    // Hotel details
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text(hotel.name.nilIfBlank ?? "Unknown Hotel")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Spacer(minLength: 20)
                            
                            if let price = hotel.price {
                                Text("$\(String(format: "%.0f", price)) / night")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.red)
                                    .padding(.trailing, 4)
                            }
                        }
                        
                        if let city = hotel.city?.nilIfBlank {
                            Text(city)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        if let rating = hotel.rating {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.subheadline)
                                Text(String(format: "%.1f", rating))
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                    }
                    .padding([.horizontal, .bottom], 8)
                }
                .frame(width: UIScreen.main.bounds.width * 0.85)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.black.opacity(0.4))
                )
            }
            
            private var placeholderImage: some View {
                Color.gray.opacity(0.3)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 28, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
        }

private extension URL {
    init?(validImageString raw: String?) {
        guard let raw = raw?.trimmingCharacters(in: .whitespacesAndNewlines),
              !raw.isEmpty
        else { return nil }

        if let url = URL(string: raw) {
            self = url
            return
        }

        let encoded = raw.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        guard let encoded, let url = URL(string: encoded) else { return nil }
        self = url
    }
}

private extension String {
    var nilIfBlank: String? {
        let t = trimmingCharacters(in: .whitespacesAndNewlines)
        return t.isEmpty ? nil : t
    }
}

private extension Optional where Wrapped == String {
    var nilIfBlank: String? {
        switch self {
        case .some(let s): return s.nilIfBlank
        case .none: return nil
        }
    }
}

#Preview {
    HotelCardView(hotel: Hotel(
        id: "1",
        name: "Test Hotel",
        city: "Colombo",
        rating: 4.5,
        price: 120,
        imageUrl: "https://picsum.photos/400/200",
        latitude: 6.9271,    
        longitude: 79.8612,
        facilities: nil
    ))
}

