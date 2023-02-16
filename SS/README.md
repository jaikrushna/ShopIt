
# ShopIT

E-commerce application for offline shops and small vendors to display their available products.
Idea behind this application is to deliver the things to the users or customers as soon as within few hours or to make customers offline search for products easy and see the product in real before buying.


## Screenshots

#### 1]Registration_Page:
![App Screenshot](https://user-images.githubusercontent.com/86294906/218159036-59323548-3948-42da-94bc-06e41f71a440.jpeg)
Firebase email Authentication used.

#### 2]Login_Page:
![App Screenshot](https://user-images.githubusercontent.com/86294906/218159097-a22052d9-ce67-4a63-a65d-a6d0c6b4c112.jpeg)
Contains custom logo made on figma

#### 3]Main_Page:
![WhatsApp Image 2023-02-10 at 12 22 58 AM (1)](https://user-images.githubusercontent.com/86294906/218159461-cd895b87-d5e7-4605-b643-10b25c695334.jpeg)
Contains a Drawer, Cart, Fav selector and Products Displayed as cards on Grid .

#### 4]Favourites options:
![WhatsApp Image 2023-02-10 at 12 22 58 AM](https://user-images.githubusercontent.com/86294906/218160328-f400df40-3202-48c1-ac18-c4859513f9e2.jpeg)
2 Options=Favs and All

#### 5]Favourites:
![WhatsApp Image 2023-02-10 at 12 22 57 AM (2)](https://user-images.githubusercontent.com/86294906/218160478-afb891c6-8663-4867-b678-0184b6967638.jpeg)
Only Liked images are disaplyed


#### 6]Added to Cart:
![WhatsApp Image 2023-02-10 at 12 22 57 AM (1)](https://user-images.githubusercontent.com/86294906/218160612-ca73ecc6-3d58-4d13-abff-dd481902719a.jpeg)
Card contains like button, Name of product and cart button to add item, after adding a pop-up to notify or undo the to remove from cart.


#### 7]Cart:
![WhatsApp Image 2023-02-10 at 12 22 57 AM](https://user-images.githubusercontent.com/86294906/218160978-ef0413d5-ed8c-4cb1-ac5c-60f6858cce36.jpeg)
Cart contains selected products , their quantity ,price and Order button


#### 8]Drawer:
![WhatsApp Image 2023-02-10 at 12 22 59 AM (2)](https://user-images.githubusercontent.com/86294906/218161178-e851d580-9cdf-4126-b728-4c8eadb71237.jpeg)


#### 9]Add_Products:
![WhatsApp Image 2023-02-10 at 12 22 59 AM (1)](https://user-images.githubusercontent.com/86294906/218161254-4eb4192d-1132-4844-baaa-9b94f3fa0379.jpeg)
Screen to add product to sell


#### 10]Display or screen of product getting add:
![WhatsApp Image 2023-02-10 at 12 22 59 AM](https://user-images.githubusercontent.com/86294906/218161501-3bf0acf2-07ae-424c-ade3-6f2cab9c349a.jpeg)
Product is displayed in a Container


#### 11]List of Added Products:
![WhatsApp Image 2023-02-10 at 12 22 58 AM (2)](https://user-images.githubusercontent.com/86294906/218161654-47818338-50ed-4c42-bb6c-1c7723abf716.jpeg)
List of Products and each product contains a edit and delete option


#### 12]Orders:
![WhatsApp Image 2023-02-10 at 12 22 56 AM](https://user-images.githubusercontent.com/86294906/218161867-d412373b-7836-40fb-8411-23b8f82c5b24.jpeg)
List of Past Orders placed by users


#### 13]Display of Product:
![WhatsApp Image 2023-02-10 at 12 24 33 AM](https://user-images.githubusercontent.com/86294906/218162016-a9bda93b-3d62-4796-ba72-f946a08ae5d4.jpeg)
Product view when clicked on card , contains product images, its details , and Placed order button


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

