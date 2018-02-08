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
  cart.map {|item, values|
    newCount = 0
    newItemCount = 0
    newItemCost = 0.00
    coupons.each {|coupon|
      if coupon[:item] == item
        if coupon[:num] <= item[:count]
          cart[item][:count] = item[:count] % coupon[:num]
          cart[(item + " W/COUPON")] = {}
          cart[(item + " W/COUPON")][:price] = coupon[:cost] 
          cart[(item + " W/COUPON")][:clearance] = item[:clearance] 
          cart[(item + " W/COUPON")][:count] = item[:count] / coupon[:num]
        end
      end
    }
  }
end

def apply_clearance(cart)
  cart.map { |item|
    if item[:clearance]
      item[:price] = item[:price] * 0.80
    end
  }
end

def checkout(cart, coupons)
  cart = apply_coupons(consolidate_cart(cart), coupons)
  binding.pry
  cart = apply_clearance(cart)
  total = 0.00
  cart.each {|item|
    total += item[:price] * item[:count]
  }
  if total > 100.00
    total = total * 0.90
  end
  total
end
