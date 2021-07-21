import Foundation

struct Badge: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imgString: String
    let goal: Int
}

struct Badges {
    static let badges = [
        Badge(name: "got 5", imgString: "badge_5", goal: 3),
        Badge(name: "got 15", imgString: "badge_15", goal: 3),
        Badge(name: "got 30", imgString: "badge_30", goal: 2),
        Badge(name: "got 45", imgString: "badge_45", goal: 4)
    ]
}
