import Foundation

class LikesViewModel {
    
    var sections: [String] = ["New", "Today", "This Week", "This Month"]
    private(set) var data: [String: [LikeItem]] = [:]
    
    var onDataUpdated: (() -> Void)?
    
    func fetchData() {
        data = [
            "New": [
                LikeItem(profileImage: "profile1", username: "karennne", action: "liked your photo.", time: "1h", postImage: "post1", isFollowButtonVisible: false)
            ],
            "Today": [
                LikeItem(profileImage: "profile1", username: "kiero_d, zackjohn and 26 others", action: "liked your photo.", time: "3h", postImage: "post1", isFollowButtonVisible: false)
            ],
            "This Week": [
                LikeItem(profileImage: "profile1", username: "craig_love", action: "mentioned you in a comment: @jacob_w exactly..", time: "2d", postImage: "post1", isFollowButtonVisible: false),
                LikeItem(profileImage: "profile1", username: "martini_rond", action: "started following you.", time: "3d", postImage: nil, isFollowButtonVisible: true),
                LikeItem(profileImage: "profile1", username: "maxjacobson", action: "started following you.", time: "3d", postImage: nil, isFollowButtonVisible: true),
                LikeItem(profileImage: "profile1", username: "mis_potter", action: "started following you.", time: "3d", postImage: nil, isFollowButtonVisible: true)
            ],
            "This Month": [
                LikeItem(profileImage: "profile1", username: "m_humphrey", action: "started following you.", time: "3d", postImage: nil, isFollowButtonVisible: true)
            ]
        ]
        
        onDataUpdated?()
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        let key = sections[section]
        return data[key]?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> LikeItem? {
        let key = sections[indexPath.section]
        return data[key]?[indexPath.row]
    }
}
