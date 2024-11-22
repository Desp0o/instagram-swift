#### networkManager გამოყენება

```swift
import NetworkManagerFramework

  func fetchData() {
        let apiLink = "http://localhost:3000/all-posts"
        Task {
            do {
                let fetchedData: PostResponse = try await networkService.fetchData(urlString: apiLink, headers: [:])
                
                allPostsData = fetchedData.response
                print(allPostsData)
                
            } catch NetworkError.httpResponseError {
                print("Response is not HTTPURLResponse or missing")
            } catch NetworkError.invalidURL {
                print("Invalid URL")
            } catch NetworkError.statusCodeError(let statusCode) {
                print("Unexpected status code: \(statusCode)")
            } catch NetworkError.noData {
                print("No data received from server")
            } catch NetworkError.decodeError(let error) {
                print("Decode error: \(error.localizedDescription)")
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
            }
        }
    }
```

#### ფორმატერის გამოყენება
```swift

https://swiftpackageindex.com/Desp0o/izziDateFormatter

```



