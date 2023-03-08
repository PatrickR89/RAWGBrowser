# RAWGBrowser
Interview project for Profico. Project idea was to create an application which would access RAWG APIs, listing games by their genres.
Also application stores selected genre in Firebase, loading it on next app load, keeping user to their selected genre.
In games listing, any game can be checked out by tapping, to see details and description.
No UI guidelines were provided, therefore app UI was created in modern clean style, with minimal effects.

* Project was developed without Storyboard, building UI programmatically.
* Project files are structured by their types for easier navigation.
* Project also contains buildable DocC documentation for easier navigation in code.

## Code Architecture

### Coordinator pattern
Project was built with coordinator pattern in order to keep modular elements independed from each other.
*MainCoordinator* class was created in that puprose, to change View Controllers in *Navigation Controller*.
MainCoordinator is also responsible for containing APIService and DatabaseService classes.
All Controllers are created in coordinator to minimalize injecting data to ViewControllers, as also for test purposes.

### Delegate patter
In order to keep class instances separated, and avoid passing them down in hierarchy or forcefully use their functions, delegate pattern was used.
Most of delegacies have MainCoordinator as their target.

### MVVM patter
MVVM pattern was used to minimalize non-UI related functionalities in instances resposnible for UI, in order to provide minimal required amount of information to them. ViewModels are created from their respective Model instances using their initialization.

### Code design
Code complexity was kept to a minimum, separating larger methods into several smaller ones, particularly regarding methods responsible for UI.

## UI design

For the project *Thonburi* font was used. Background colors are based in darker colors, while accent colors were orange and green.
Status bar was set to light mode for whole navigation in app. 
UI was created to be dynamic, keeping number of constants to a bare minimum.
**For design purposes iPhone 14 simulator was used.** Differences may occur in different variations and generations of iPhones.

### Genre selection screen

Genre selection screen was built with *UICollectionView*, with horizontal scroll, and large cells to present each genre. On scroll or drag stop, applicaton centers on closest cell. 

![mainScreen](https://user-images.githubusercontent.com/87969333/223737533-0e3541dd-45e3-4b6a-9c26-4759ea6fe1b6.png)

### Games list

After genre selection, new View Controller is set to *Navigation Controller*, which presents all games within given genre. 
Games are presented in *Table View*, with cells containig thumbnail (created with help of SDWebImage), which covers half of the cell,
containing shading with background color towards the end of image. Cell also contains game's title and rating.
This View Controller also contains navigation button to remove saved genre and return user to main screen.
**Note: Separate "settings" window was not used for reseting genre, in order to keep user interaction as simple as possible.**


![gameListScreen](https://user-images.githubusercontent.com/87969333/223739333-0a462f7e-cfd8-4e1b-8e3c-c6b236377dd7.png)

View Controller also notifies *APIService* when bottom cell was reached, in order to fetch next page of games. 
*Note: For future plans idea is to keep fixed ammount of games saved in application, and remove those on start after two pages were added. Additional method would be added, which would add games already passed when scrolled to top.*

### Game detail

When a single game is selected an new screen appears showing information about the game, which was retrieved from *RAWG API*.
Information is dynamic, as some games differ in available information. To present those detail, a *Table View* was used on the lower half of screen.

![gameDetailScreen](https://user-images.githubusercontent.com/87969333/223740843-1200e0f3-3f09-4f89-9f61-c4857743c64b.png)

On the image itself, "i" logo is visible, which opens modal view containing description about the game.

![gameDetailDescription](https://user-images.githubusercontent.com/87969333/223741376-d271cc86-9f93-4c7d-8a85-5967f5667253.png)

### Error notifications

In case of errors in requests, responses and network connection, a notification is displayed on the middle of the screen.
Notification dissapears with a timeout od 2 seconds. Notification is displayed via *APIServiceDelegate*

![warningMessage](https://user-images.githubusercontent.com/87969333/223741864-b39a3757-d048-4b1a-a0bf-4edfb0c1f6d6.png)

### Spinner notification

While *APIService* is waiting for response, spinner is displayed on the center of the screen, using *APIServiceDelegate*. After response was recieved or error occured, spinner is removed.

## Application

### Unit tests

In order to avoid issues while converting data recieved via *HTTPResponse* to data presentable on UI,
test cases were used to check for any irregularity in coversion from models to viewModels.
Tests were included also for populating data in controllers, from recieved data from *APIService*.

### Package dependencies

For the project two dependencies were used.

* *Firebase* for storing selected genre id, on Google Firebase DB.
* *SDWebImage* to render images directly from URLs provided by *RAWG API*

### Code separation

In order to keep code cleaner, several methods were moved to their respective extension, including extension for *UILabel*, and *UIButton*,
while constants were stored in separate structs as static instances.

# Update

## Settings

Add *SettingsViewController* with respective *Controller* and View to be opened from *GamesListViewController* via *MainCoordinator*. Setting currently contains only one cell in one section, available for further development.


![settingsView](https://user-images.githubusercontent.com/87969333/223854921-371e88b6-9048-4a0f-9b93-6eb8807ce99b.png)

## Colors

Text colors were changed mainly from orange to white for better user expirience (text in DescriptionView, GameViewCell titleLabel...)

## NotificationWindow

In order to avoid invasion of *NavigationController* or other ViewControllers for that matter, for spinner and error message views new instance of *UIWindow* is created, which presents information to user, and is destroyed on child's lifecycle end.
