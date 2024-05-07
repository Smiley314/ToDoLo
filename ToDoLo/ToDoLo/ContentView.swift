//
//  ContentView.swift
//  ToDoLo
//
//  Created by Smiley on 5/2/24.
//
//
//  Home.swift
//  ToDoLo
//
//  Created by Smiley on 5/2/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var isLoading = true
    @State private var isNavigated = false
    @StateObject var taskViewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                VStack{
                    Image("Work")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                    //.frame(height: UIScreen.main.bounds.height / 2)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.isNavigated = true
                        }
                        .background(
                            NavigationLink(
                                destination: To_do_List().environmentObject(taskViewModel),
                                isActive: $isNavigated
                            ) {
                                EmptyView()
                            }
                        )
                }
                
                VStack{
                    Image("Personal")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                    //.frame(height: UIScreen.main.bounds.height / 2)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.isNavigated = true
                        }
                        .background(
                            NavigationLink(
                                destination: To_do_List().environmentObject(taskViewModel),
                                isActive: $isNavigated
                            ) {
                                EmptyView()
                            }
                        )
                }
            }
        }
    }
}


#Preview {
    ContentView().environmentObject(TaskViewModel())
}
