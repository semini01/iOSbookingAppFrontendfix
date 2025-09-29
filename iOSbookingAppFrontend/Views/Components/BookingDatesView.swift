//
//  BookingDatesView.swift
//  iOSbookingAppFrontend
//
//  Created by Semini Wickramasinghe on 2025-09-20.
//


import SwiftUI

struct BookingDatesView: View {
    @Binding var checkInDate: Date
    @Binding var checkOutDate: Date
    
    @State private var showCheckInPicker = false
    @State private var showCheckOutPicker = false
    @State private var animateTitle = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Booking Dates")
                           .font(.headline)
                           .foregroundColor(.white)
                           .padding(.horizontal)
                           .scaleEffect(animateTitle ? 1.05 : 1.0)
                           .opacity(animateTitle ? 1.0 : 0.6)
                           .shadow(color: animateTitle ? .blue.opacity(0.6) : .clear,
                                   radius: animateTitle ? 6 : 0)
                           .onAppear {
                               withAnimation(
                                   Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)
                               ) {
                                   animateTitle.toggle()
                               }
                           }
            
            Button(action: {
                showCheckInPicker.toggle()
            }) {
                HStack {
                    Text("Check-In: \(formattedDate(checkInDate))")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.orange)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
            }
            .sheet(isPresented: $showCheckInPicker) {
                VStack {
                    DatePicker("Select Check-In",
                               selection: $checkInDate,
                               displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .colorScheme(.dark)
                        .padding()
                    
                    Button("Done") {
                        showCheckInPicker = false
                    }
                    .padding()
                    .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
                .presentationDetents([.medium, .large])
            }
            
            
            Button(action: {
                showCheckOutPicker.toggle()
            }) {
                HStack {
                    Text("Check-Out: \(formattedDate(checkOutDate))")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundColor(.orange)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.1))
                .cornerRadius(12)
            }
            .sheet(isPresented: $showCheckOutPicker) {
                VStack {
                    DatePicker("Select Check-Out",
                               selection: $checkOutDate,
                               in: checkInDate...,
                               displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .colorScheme(.dark)
                        .padding()
                    
                    Button("Done") {
                        showCheckOutPicker = false
                    }
                    .padding()
                    .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
                .presentationDetents([.medium, .large])
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    BookingDatesView(
        checkInDate: .constant(Date()),
        checkOutDate: .constant(Calendar.current.date(byAdding: .day, value: 2, to: Date())!)
    )
    .background(Color.black)
}
