# Specifications for the Rails Assessment

- [x] Use the Ruby on Rails framework.

Ruby on Rails has been used for the project.

- [x] Your models must include a has_many, a belongs_to, and a has_many :through relationship. You can include more models to fill out your domain, but there must be at least a model acting as a join table for the has_many through. Also, make sure that the join table contains at least one user submittable attribute; for example: rides with tickets or appointments with times.

Certificates have and belong to many ciphers through certificate ciphers.
Certificates belong to a load balancer.

- [x] Your models should include reasonable validations for the simple attributes. You don't need to add every possible validation or duplicates, such as presence and a minimum length, but the models should defend against invalid data.

Usernames have to present. Passwords have to be at least 8 characters.

- [x] You must include at least one class level ActiveRecord scope methods. To some extent these class scopes can be added to power a specific individual feature, such as "My Overdue Tasks" in a TODO application, scoping all tasks for the user by a datetime scope for overdue items, @user.tasks.overdue. Reports make for a good usage of class scopes, such as "Most Valuable Cart by Customer" where the code would implement a Cart.most_valuable and Cart.by_customer which could be combined as Cart.most_valuable.by_customer(@customer).

There are many search features using class level ActiveRecord scopes for certificates.

- [x] Your application must provide a standard user authentication, including signup, login, logout, and passwords. You can use Devise but given the complexity of that system, you should also feel free to roll your own authentication logic.

I've rolled my own which includes all of the above.

- [x] Your authentication system should allow login from some other service. Facebook, twitter, foursquare, github, etc...

It allows login from GitHub.

- [x] You must make use of a nested resource with the appropriate RESTful URLs. Additionally, your nested resource must provide a form that relates to the parent resource. Imagine an application with user profiles. You might represent a person's profile via the RESTful URL of /profiles/1, where 1 is the primary key of the profile. If the person wanted to add pictures to their profile, you could represent that as a nested resource of /profiles/1/pictures, listing all pictures belonging to profile 1. The route /profiles/1/pictures/new would allow me to upload a new picture to profile 1. Focus on making a working application first and then adding more complexity. Making a nested URL resource like '/divisions/:id/teams/new' is great. Having a complex nested resource like 'countries/:id/sports/:id/divisions/:id/teams/new' is going to make this much harder on you.

There is a nested edit form for certificates under load balancers.

- [x] Your forms should correctly display validation errors. Your fields should be enclosed within a fields_with_errors class and error messages describing the validation failures must be present within the view.

There are error messages for invalid login.

- [x] Your application must be, within reason, a DRY (Do-Not-Repeat-Yourself) rails app. Logic present in your controllers should be encapsulated as methods in your models. Your views should use helper methods and partials to be as logic-less as possible. Follow patterns in the Rails Style Guide and the Ruby Style Guide.

My application has as much logic as I can see how to moved into the models. Helpers have been used in places such as the menu to check whether the user is logged in.
All code has been linted using Rubocop to check it follows the style guides.

- [x] Do not use scaffolding to build your project. Your goal here is to learn. Scaffold is a way to get up and running quickly, but learning a lot is not one of the benefits of scaffolding. That’s why we do not allow the use of scaffolding for projects.

No scaffolding was used in the creation of this Rails project.

## TODO

- fields_with_errors on the correct inputs.
- Add a value to my join table.
- Add a show nested route.
- Add a new nested route.
- Turn the searches into RESTful routes.
