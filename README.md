[![Code Climate](https://codeclimate.com/github/eilw/promotion_tech_test/badges/gpa.svg)](https://codeclimate.com/github/eilw/promotion_tech_test)
# Promotion and checkout tech test

A tech test to model the a checkout function and promotion rules, in Ruby.

### Approach
To get a sense of the solution space, I started by listing the various components that were described in the brief: Checkout, item, promotion rules and basket. I decided against a basket class as it was not included in the sample Ruby code shown, so therefore implemented that functionality in the checkout class instead.

The brief provided the feature tests to be resolved, where each test was based on a different basket of items. With the feature test as a basis, I followed TDD approach to implement the required functionality.

At the moment, my solution requires any promotion based on the total price, to be the last part of the promotion_rules array - e.g. all product related promotions must be implemented first in order to update the 'real' total price.

I've kept the solution open by using 'types' of promotions as a way to distinguish between different rules. I first check what type the promotion rule is, and I then calculate the discount based on that. Consequently, this will allow for a few more 'types' to be included - however, if there will be too many types, then it would most likely need to be refactored to find more similarities between types. 

### Testing
RSpec is the testing framework.
- clone this repo
- go into the root of the folder
- run ```rspec```


### Code example
```
SETTING UP THE OBJECTS
quantity_promotion =  PromotionRule.new({type: "product", threshold: 2, id: "001", discount_pp: 0.75})
total_promotion =  PromotionRule.new({type: "total",threshold: 60, discount_pct: 0.1})
promotion_rules =  [quantity_promotion,total_promotion]
co =  Checkout.new(promotion_rules)
lavender_heart =  Item.new("001", 9.25)
cufflinks =  Item.new("002", 45.00)
kids_tshirt =  Item.new("003", 19.95)

co.scan(lavender_heart)
co.scan(cufflinks)
co.scan(lavender_heart)
co.scan(kids_tshirt)
price = co.total
price --> £73.76
```
