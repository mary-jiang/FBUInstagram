# Project 4 - Not Instagram

Not Instagram is a photo sharing app using Parse as its backend.

Time spent: 16 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [x] Run your app on your phone and use the camera to take the photo
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Display the profile photo with each post
  - [ ] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [ ] User can like a post and see number of likes for each post in the post details screen.
- [x] Style the login page to look like the real Instagram login page.
- [x] Style the feed to look like the real Instagram feed. (not exactly, but it is quite close)
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [x] Tapping on a post in the profile view will bring up a details view version of that post

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Best way to implement likes
2. Best way to implement comments

## Video Walkthrough

All required user stories:

![](https://i.imgur.com/JQEXts0.gif)

Profile tab:

![](https://i.imgur.com/06vhToa.gif)

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- Parse
- AFNetworking
- DateTools


## Notes

The profile view scene uses MVC design where the model is seperate from the view controller and the view is seperated from the view controller. 

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
