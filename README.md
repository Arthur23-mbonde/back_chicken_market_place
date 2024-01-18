# README

BREVE PRESENTATION DES ROUTES

Le chemin pour la home page est : root "welcomes#index" => Au démarrage du site, valables pour les utilisateurs non connectés (ou des simples visiteurs) 
Les utilisateurs inscrits et connectés en tant qu'éleveurs trouveront leur home page à travers ce chemin : get 'farmer', to: 'welcomes#farmer'
Les utilisateurs inscrits et connectés en tant que clients trouveront leur home page à travers ce chemin : get 'client', to: 'welcomes#client'

Ouvrir le fichier app/config/routes.rb pour avoir plus d'informations sur les routes.


LE CONTENU ACTUEL DU FICHIER DE MIGRATION (Les tables disponibles présentement en base de données)

[back_chicken_market_place](db/migrate/20231229145140_devise_create_users.rb)
[back_chicken_market_place](db/migrate/20231230110405_create_farmers.rb) 
[back_chicken_market_place](db/migrate/20231230120029_create_races.rb) 
[back_chicken_market_place](db/migrate/20231230120124_create_categories.rb) 
[back_chicken_market_place](db/migrate/20231230211701_create_products.rb) 
[back_chicken_market_place](db/migrate/20240103151811_create_active_storage_tables.active_storage.rb)
[back_chicken_market_place](db/migrate/20240106121359_create_carts.rb) 
[back_chicken_market_place](db/migrate/20240106121639_create_cart_products.rb) 
[back_chicken_market_place](db/migrate/20240109201830_create_chat_rooms.rb) 
[back_chicken_market_place](db/migrate/20240110010739_create_messages.rb) 
[back_chicken_market_place](db/migrate/20240112002525_create_participants.rb) 
[back_chicken_market_place](db/migrate/20240116023639_add_status_to_users.rb)


PRESENTATION DES TABLES DU MODELE REPONDANT AUX BESOINS DE L'APPLICATION

** La table USERS

id

status

role

first_name

last_name

age

sex

country

city

phone

address

email

password

password_confirmation


** La table FARMERS

id

user_id

name

address

description


** La table RACES

id

name


** La table CATEGORIES

id

name

description


** La table PRODUCTS

id

race_id

category_id

name

description

current_price

disponibility

evaluation


** La table CARTS

id

title


** La table ORDERS

id

user_id

status


** La table REVIEWS

id

product_id

content

mark


** La table de jointure ORDER_PRODUCT

id

order_id

product_id

rate (La quantité du produit figurant dans la commande)

sum


** La table de jointure CART_PRODUCT

id

cart_id

product_id

rate (Le nombre du produit ajouté au panier d’achat)


** La table de jointure FARMER_RACE_JOIN_TABLE

id

farmer_id

race_id


** La table CHAT_ROOMS

id

title

is_public?


** La table MESSAGES

id

discussion_id

user_id

content


** La table PARTICIPANTS

id

user_id

chat_room.id



LES JOINTURES

Un utilisateur a un et un seul panier d’achat ; un panier d’achat appartient à un et un seul utilisateur

Un panier d’achat peut être concerné par plusieurs commandes ; une commande est spécifique à un et seul panier d’achat

Un produit peut être ajouté dans plusieurs paniers d’achats ; un panier d’achats peut renfermer plusieurs produits

Un utilisateur détient un et un seul ferme ; un ferme appartient à un et un seul utilisateur

Une race peut renfermer plusieurs produits ; un produit appartient à une et une seule race

Une catégorie peut renfermer plusieurs produits ; un produit appartient à une et une seule catégorie

Une race peut se retrouver dans plusieurs fermes ; un ferme peut détenir plusieurs races

Une salle de conversation peut contenir plusieurs discussions ; une discussion appartient à une et une salle de discussion

Une discussion peut compter plusieurs messages ; un message fait partie d’une et d’une seule discussion

Un utilisateur peut écrire plusieurs messages dans une discussion ; un message appartient à un et un seul utilisateur dans une discussion