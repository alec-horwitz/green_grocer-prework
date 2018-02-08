require "pry"
def consolidate_cart(cart)
  consolidatedCart = {}
  cart.each {|inventory|
    inventory.each {|item, values|
      if consolidatedCart[item]
        consolidatedCart[item][:count] += 1
      else
        consolidatedCart[item] = values
        consolidatedCart[item][:count] = 1
      end
    }
  }
  consolidatedCart
end

def apply_coupons(cart, coupons)
  appliedCart = {}
  cart.each {|item, values|
    newCount = 0
    newItemCount = 0
    newItemCost = 0
    newItemName = ""
    coupons.each {|coupon|
      if coupon[:item] == item
        if coupon[:num] <= item[:count]
          newCount = item[:count] % coupon[:num]
          newItemCount = item[:count] / coupon[:num]
          newItemCost = coupon[:cost]
          newItemName = item + "W/COUPON"
        end
      end
    }
    binding.pry
    if newItemCount
      if newCount
        appliedCart[item] = {:price => item[:price], :clearance => item[:clearance], :count => newCount}
      end
      appliedCart[item + "W/COUPON"] = {:price => newItemCost, :clearance => item[:clearance], :count => newItemCount}
    else
      appliedCart[item] = values
    end
  }
  appliedCart
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
