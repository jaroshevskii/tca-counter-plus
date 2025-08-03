//
//  CounterView.swift
//  TCACounterPlus
//
//  Created by Sasha Jaroshevskii on 03.08.2025.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(store.count)")
                .font(.system(size: 60, weight: .bold))
                .padding()
                .frame(maxWidth: .infinity)
            
            HStack(spacing: 16) {
                GlassButton(label: "-", action: { store.send(.decrementButtonTapped) })
                
                if store.count != 0 {
                    GlassButton(label: "Reset", action: { store.send(.resetButtonTapped) })
                }
                
                GlassButton(label: "+", action: { store.send(.incrementButtonTapped) })
            }
            .animation(.smooth(extraBounce: 0.25), value: store.count)
            
            GlassButton(
                label: store.isTimerRunning ? "Stop Timer" : "Start Timer",
                action: { store.send(.toggleTimerButtonTapped) }
            )
            
            GlassButton(label: "Fact", action: { store.send(.factButtonTapped) })
            
            Spacer()
            
            if store.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let fact = store.fact {
                Text(fact)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                Toggle("Restart timer when count changes", isOn: Binding(
                    get: { store.shouldRestartTimerOnChange },
                    set: { _ in store.send(.toggleRestartTimerSwitch) }
                ))
                .toggleStyle(.switch)
                .padding()
                .glassEffect(in: .rect(cornerRadius: 16))
                
                Text("When enabled, the timer restarts whenever the count changes via buttons.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

struct GlassButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.title3.bold())
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
                .frame(minWidth: 80)
        }
        .buttonStyle(.plain)
        .glassEffect(in: .rect(cornerRadius: 20))
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
