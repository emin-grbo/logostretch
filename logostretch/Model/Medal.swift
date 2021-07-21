import Foundation

struct Medal: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imgString: String
    let goal: Int
}

struct Medals {
    static let medalsList = [
        Medal(name: "got 5", imgString: "badge_5", goal: 3),
        Medal(name: "got 15", imgString: "badge_15", goal: 3),
        Medal(name: "got 30", imgString: "badge_30", goal: 2),
        Medal(name: "got 45", imgString: "badge_45", goal: 4)
    ]
}
