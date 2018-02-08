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
    coupons.each {|coupon|
      if coupon[:item] == item
        if coupon[:num] <= item[:count]
          cart[item][:count] = item[:count] % coupon[:num]
          cart[(item + " W/COUPON")] = {:price => coupon[:cost], :clearance => item[:clearance], :count => (item[:count] / coupon[:num])}
          # cart[(item + " W/COUPON")][:price] = coupon[:cost]
          # cart[(item + " W/COUPON")][:clearance] = item[:clearance]
          # cart[(item + " W/COUPON")][:count] = item[:count] / coupon[:num]
        end
      end
    }
  }
  cart
end

def apply_clearance(cart)
  cart.map { |item|
    if item[:clearance]
      item[:price] = item[:price] * 0.80
    end
  }
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  binding.pry
  cart = apply_coupons(cart, coupons)
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
