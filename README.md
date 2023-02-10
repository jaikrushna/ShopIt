
# ShopIT

E-commerce application for offline shops and small vendors to display their available products.
Idea behind this application is to deliver the things to the users or customers as soon as within few hours or to make customers offline search for products easy and see the product in real before buying.


## Screenshots

#### 1]Registration_Page:
###### Firebase email Authentication used.
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173232-5e24e2cb-7a73-418e-9650-c5a81fcfe990.jpg)


#### 2]Login_Page:
###### Contains custom logo made on figma
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173311-0db596e6-0c3f-452c-997d-5350b5cf0f32.jpg)


#### 3]Main_Page:
###### Contains a Drawer, Cart, Fav selector and Products Displayed as cards on Grid 
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173438-83347d88-8608-4b21-8199-0ea64c0ccade.jpg)


#### 4]Favourites options:
###### 2 Options=Favs and All
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173475-fc2e4833-2c6b-40a1-b349-1551410470fe.jpg)


#### 5]Favourites:
###### Only Liked images are disaplyed
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173513-c7fc41ef-3b1c-4369-95ff-5e144c788194.jpg)


#### 6]Added to Cart:
###### Card contains like button, Name of product and cart button to add item, after adding a pop-up to notify or undo the to remove from cart
![App Screenshot](https://user-images.githubusercontent.com/86294906/218174004-2b6f22cc-3905-44bf-ae5c-74dab82ddc19.jpg)


#### 7]Cart:
###### Cart contains selected products , their quantity ,price and Order button
![App Screenshot](https://user-images.githubusercontent.com/86294906/218174579-46abafa7-aec6-4041-90f4-1df2060c2a12.jpg)


#### 8]Drawer:
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173631-cd292828-4346-4d34-b24b-7e1576a9da7b.jpg)


#### 9]Add_Products:
###### Screen to add product to sell
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173695-8f1c6d65-7238-416f-8619-9d89b3cf357f.jpg)


#### 10]Display or screen of product getting add:
###### Product is displayed in a Container
![App Screenshot](https://user-images.githubusercontent.com/86294906/218173750-f37545af-5566-456e-ad9d-618fc83d80dc.jpg)


#### 11]List of Added Products:
###### List of Products and each product contains a edit and delete option
![App Screenshot](https://user-images.githubusercontent.com/86294906/218174728-02e59bac-87f2-45d4-a55e-d6b041d0f9b8.jpg)



#### 12]Orders:
###### List of Past Orders placed by users
![App Screenshot](https://user-images.githubusercontent.com/86294906/218174810-bfeea342-e9f0-4ee7-828c-0989cabebb1b.jpg)


#### 13]Display of Product:
###### Product view when clicked on card , contains product images, its details , and Placed order button
![App Screenshot]![resize13](https://user-images.githubusercontent.com/86294906/218174099-6e87323c-fff5-400b-bf17-0a4748a6b8c3.jpg)



## Libraries used and their usuage:


#### 1]Provider:
Provider package is used for State Management Purpose

#### 2]Http:
Used to Post, Patch and get the products uploaded on Firebase Realtime Database.

#### 3]Shared Preferences:
To store the login information on device allocated for autologin

#### 4]Intl:
Used to store the infromation of user date and time when placing the order and orders are arranged according to Date&Time

#### 5]Cupertino Items:
To used some defined icons like a heart for liking the product

