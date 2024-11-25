
# Mini Instagram

Instagram is an iOS social networking application where users can sign in, have their own account, edit their profile page, add posts, receive notifications, view other users' posts, favorite them, view post comments, and more. The app was developed using Swift and UIKit in Xcode. Six developers worked on the project, each with assigned responsibilities. Trello was used for task management and process organization, allowing team members to track tasks and plan completed and pending work. Development was carried out on the GitHub platform, where team members actively completed tasks on separate branches, coordinating with one another. Pull requests were frequently used, and the app was ultimately merged and finalized on the main branch.

### ⚙️ Features:
- Authorization ✅
- Scroll Feed 📰
- Like/Unlike Post ❤️/💔
- Read Comments 💬
- View Multiple Images in a Single Post 🖼️
- Share Post 🔗
- Search Posts 🔍
- See Searched Post Details Page 📖
- Add Post and Image from Gallery ➕🖼️
- See Notifications and Follow People 🔔👥
- Navigate to Profile 👤➡️
- Edit Profile ✏️


## 🚀 Tools & Technologies Used:
- Xcode
- Language: Swift
- Frameworks: UIKit, Foundation
- Version Control: GitHub
- Mockoon (Dummy API)



## 🛠️ Details

#### User Credentials
| User | Password     | 
| :-------- | :------- |
| Nick14 | Ilovemc |

-----
#### Get Feed
 - [Feed JSON data](https://codeshare.io/pAm9dD)

```http
  GET http://localhost:3000/v1/users/self/feed
```

#### Get Notifications
 - [Notifications JSON data](https://codeshare.io/deN3dy)

```http
  GET http://localhost:3000/v1/users/self/media/liked
```

## 🤝 Contributing

- Tornike Desporashvili – Led the team, assigned responsibilities, and planned the work process. Tornike was responsible for creating the navigation, feed page, post detail page, viewing comments, and favoriting posts. He actively assisted team members with bug fixes, contributed to code refactoring, merged the project, resolved merge conflicts, and ensured smooth functionality during the final merge by fixing bugs.

- Nino Dimitriadze – Worked extensively on the Profile Page and Edit Profile Page, allowing users to view their profile and posts. Through the Edit Profile Page, users could change and update their personal information. Nino participated in fixing the TabBar and Notification pages. She contributed to identifying and fixing code bugs and actively worked on code refactoring to improve the code structure. Nino also provided technical support to other team members in resolving issues.

- Iliko Kukava – Was responsible for working with Mockoon, setting up and managing several APIs for different pages. Iliko also actively helped team members resolve various issues.

- Giorgi Gakhokidze – Created the Login and Add Post pages. After user authentication, the information is stored in the keychain, so re-authentication is not required after app closure. During post creation, users can select photos from the device gallery.

- Ana Kochievi – Created the Search Page, where users can browse random posts and search for posts with content they are interested in.

- Tariel Khalvashi – Created the Notification page, where users can see who has followed them. Users can also follow other people and view notifications related to their own posts.


![Static Badge](https://img.shields.io/badge/Swift-6.0-orange)    ![Static Badge](https://img.shields.io/badge/Platform-iOS-orange)
