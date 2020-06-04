# Monster Shop 2003 
BE Mod2 Group Project

Visit Our Monster Shop Application: 

**Team Members**

[Joshua Tukman](https://github.com/Joshua-Tukman)

[Rostam Mahabadi](https://github.com/Rostammahabadi)

[Melanie Tran](https://github.com/melatran)

[Jack Puchalla](https://github.com/JPuchalla)

## Background Information

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will be able to get "shipped" by an admin. Each user role will have access to some or all CRUD functionality for application models.

### Setup

- Fork this repository
- Clone down your forked repository
- Run `bundle install`
- Run `rake db:{drop,create,migrate,seed}` to setup databases
- Run `rails s` to operate in your browser in `localhost:3000`

## Running the tests

Run `bundle exec rspec` in your terminal

## User Roles

1. Visitor - this type of user is anonymously browsing our site and is not logged in

2. Regular User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order

3. Merchant Employee - this user works for a merchant. They can fulfill orders on behalf of their merchant. They also have the same permissions as a regular user (adding items to a cart and checking out)

4. Admin User - a registered user who has "superuser" access to all areas of the application; user is logged in to perform their work

### Register
<img width="628" alt="Screen Shot 2020-06-04 at 5 03 50 PM" src="https://user-images.githubusercontent.com/59414750/83818832-8a566380-a685-11ea-973c-437abb250569.png">

## Default User

- When users register for a new account, they are assigned a role of a regular user by default
- Visitors must log in to check out
- Users can add items into their cart and create an order
- They do not have access to admin or merchant functionality
- Users can also edit their profile and update their password

```
  def update
      if password_change?
        flash[:error] = "Password and confirmation password need to match"
        redirect_to "/default_user/profile/edit?pw=change"
        return
      end
      current_user.update(user_params)
      if current_user.save
        if params[:pw] == "changed"
          flash[:notice] = "Your password has been updated"
        else
          flash[:notice] = "Your data was updated"
        end
        redirect_to default_user_profile_path
      else
        flash[:error] = current_user.errors.full_messages.to_sentence
        redirect_to "/default_user/profile/edit"
      end
    end
 ```

## Merchant

- Merchants can fulfil orders from users/customers
- Merchants have the ability to enable and disable their own items

<img width="1066" alt="Screen Shot 2020-06-04 at 5 26 58 PM" src="https://user-images.githubusercontent.com/59414750/83820047-c212da80-a688-11ea-832c-22ea9ed81680.png">

## Admin

- Admin are considered superusers with access to all areas of the application
- Admin can see all orders in the system
- Admin has the ability to enable and disable items and merchants

```
  def update
      item = Item.find(params[:item_id])
      merchant = Merchant.find(params[:merchant_id])
      if params[:edit] == 1
        item.update(item_params)
        updateable?
      else
        if item.active? == true
          item.update(active?:false)
          flash[:notice] = "#{item.name} is no longer for sale"
        else
          item.update(active?:true)
          flash[:notice] = "#{item.name} is now available for sale"
        end
        redirect_to "/admin/merchants/#{merchant.id}/items"
      end
    end
  ```
  
  ```
  def updateable?
      if @item.save
        flash[:notice] = "#{@item.name} has been updated"
        redirect_to "/admin/merchants/#{@item.merchant_id}/items"
      else
        flash[:error] = @item.errors.full_messages.to_sentence
        redirect_to "/admin/merchant/items/#{@item.id}"
      end
    end
  ```
