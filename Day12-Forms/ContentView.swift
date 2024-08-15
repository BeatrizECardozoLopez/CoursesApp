//
//  ContentView.swift
//  Day12-Forms
//
//  Created by Beatriz Cardozo on 13/8/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var courses = [
        Course(name: "Introduction to Programming", image: "intro_programming", author: "John Doe", difficulty: 1, description: "A beginner's guide to programming", price: 9.99),
        Course(name: "Advanced Data Structures", image: "data_structures", author: "Jane Smith", difficulty: 4, description: "In-depth study of data structures", price: 14.99),
        Course(name: "Artificial Intelligence Fundamentals", image: "ai_fundamentals", author: "Alex Johnson", difficulty: 3, description: "Understanding the basics of AI", price: 11.99),
        Course(name: "Mobile App Development with Swift", image: "mobile_dev_swift", author: "Emma Brown", difficulty: 3, description: "Creating iOS apps with Swift", price: 12.99),
        Course(name: "Web Development Bootcamp", image: "web_dev_bootcamp", author: "Michael Clark", difficulty: 3, description: "Comprehensive web development course", price: 10.99),
        Course(name: "Python for Data Science", image: "python_data_science", author: "Olivia White", difficulty: 2, description: "Using Python for data analysis", price: 9.99),
        Course(name: "Machine Learning Basics", image: "machine_learning", author: "William Turner", difficulty: 4, description: "Understanding the fundamentals of machine learning", price: 13.99),
        Course(name: "Cybersecurity Essentials", image: "cybersecurity_essentials", author: "Sophia Martinez", difficulty: 3, description: "Fundamentals of cybersecurity", price: 11.99),
        Course(name: "UI/UX Design Fundamentals", image: "ui_ux_design", author: "Daniel Garcia", difficulty: 2, description: "Basic principles of UI/UX design", price: 10.99),
        Course(name: "Java Programming Masterclass", image: "java_masterclass", author: "Isabella Lee", difficulty: 4, description: "Comprehensive Java programming course", price: 14.99),
        Course(name: "Game Development with Unity", image: "game_dev_unity", author: "Andrew Hall", difficulty: 3, description: "Creating games using Unity engine", price: 12.99),
        Course(name: "Database Management Basics", image: "db_management_basics", author: "Ethan Adams", difficulty: 2, description: "Fundamentals of database management", price: 9.99),
        Course(name: "Cloud Computing Fundamentals", image: "cloud_computing", author: "Ava Wilson", difficulty: 3, description: "Understanding cloud computing concepts", price: 11.99),
        Course(name: "Rapid Prototyping Techniques", image: "rapid_prototyping", author: "James Brown", difficulty: 2, description: "Quick methods for prototyping", price: 10.99),
        Course(name: "Data Analysis with R", image: "data_analysis_r", author: "Mia Miller", difficulty: 3, description: "Analyzing data using the R language", price: 11.99)
    ]
    
    @State private var selectedCourse: Course?
    @State private var showModal: Bool = false
    @EnvironmentObject var settings: SettingsFactory
    
    init() {
        //Modify NavigationBar Appeareance
        let navbarAppearance = UINavigationBarAppearance()
        navbarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.purple,
            .font: UIFont(name: "ArialRoundedMTBold", size: 30)!,
        ]
        navbarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.purple,
            .font: UIFont(name: "ArialRoundedMTBold", size: 15)!,
        ]
        
        UINavigationBar.appearance().standardAppearance = navbarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navbarAppearance
        UINavigationBar.appearance().compactAppearance = navbarAppearance
        
        navbarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.backward.circle"), transitionMaskImage: UIImage(systemName: "arrow.backward.circle"))

    }
    
    var body: some View {
        
        NavigationStack{
            List {
                ForEach(self.courses.sorted(by: DisplayOrder(type: self.settings.displayOrder)!.sortPredicate())){ course in
                    if self.shouldShowCourse(course: course) {
                        NavigationLink (destination: CourseDetailView(course: course)){
                            InfoImageRow(course: course)
                                .contextMenu{ //for prolonged touch
                                    Button{
                                        self.buyCourse(product: course)
                                    } label: {
                                        HStack {
                                            Text("Buy")
                                            Image(systemName: "storefront.fill")
                                        }
                                    }
                                    
                                    Button{
                                        self.favorite(product: course)
                                    } label: {
                                        HStack {
                                            Text("Favorite")
                                            Image(systemName: "star.fill")
                                        }
                                    }
                                    
                                    Button{
                                        self.delete(product: course)
                                    } label: {
                                        HStack {
                                            Text("Delete")
                                            Image(systemName: "trash.fill")
                                        }
                                    }
                                }
                                .onTapGesture {
                                    self.selectedCourse = course
                                }
                        }
                    }
                }
                .listRowSeparatorTint(.purple)
            }
            .listStyle(.plain)
            .navigationTitle("Recent Courses")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button() {
                        self.showModal = true
                    } label: {
                        Text("\(Image(systemName: "gear"))")
                            .foregroundStyle(.purple)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                    }
                }
            } 
            .fullScreenCover(isPresented: $showModal, content: {
                SettingsView().environmentObject(self.settings)
            })
        }
        .tint(.purple)
        
    }
    
    
    
    private func buyCourse(product course: Course) {
        if let index = self.courses.firstIndex(where: {$0.id == course.id}){
            self.courses[index].isPurchased = true
        }
    }
    
    private func favorite(product course: Course) {
        if let index = self.courses.firstIndex(where: {$0.id == course.id}){
            self.courses[index].isFavorite.toggle()
        }
    }
    
    private func delete(product course: Course) {
        if let index = self.courses.firstIndex(where: {$0.id == course.id}){
            self.courses.remove(at: index)
        }
    }
    
    //FILTERS
    private func shouldShowCourse(course: Course) -> Bool {
        //Purchased Courses
        let purchasedCondition = !self.settings.showPurchasedOnly || (self.settings.showPurchasedOnly && course.isPurchased)
        
        //Favourite Courses
        let favouriteCondition = !self.settings.showFavoriteOnly || (self.settings.showFavoriteOnly && course.isFavorite)
        
        //Difficulty
        let difficultyCondition = (course.difficulty <= self.settings.difficultyLevel)
        
        //Price Range
        let priceRangeCondition = (course.price >= self.settings.minPrice) && (course.price <= self.settings.maxPrice)
        
        //Sort Condition
        
        
         return purchasedCondition && favouriteCondition && difficultyCondition && priceRangeCondition
    }
    
    
}

//Small Image and course title
struct InfoImageRow: View {
    
    var course: Course
    
    var body: some View {
        HStack {
            Image(course.image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 16)
            
            VStack (alignment: .leading){
                HStack {
                    Text(course.name)
                        .font(.system(.body, design: .rounded))
                        .bold()
                    
                    Image(systemName: "cellularbars", variableValue: Double(course.difficulty)/4)
                        .font(.subheadline)
                        .foregroundColor(.purple)
                }

                Text(course.author)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.secondary)
                
                Text("\(String(format: "%.2f", course.price))$") //to get just two decimals
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.purple)
                    .bold()
            }
            
            Spacer()
            
            HStack (spacing: 10){
                if(course.isFavorite){
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                }
                
                if(course.isPurchased){
                    Image(systemName: "checkmark")
                        .foregroundColor(.purple)
                }
                
            }
        }
    }
}


#Preview {
    ContentView().environmentObject(SettingsFactory())
}





    


