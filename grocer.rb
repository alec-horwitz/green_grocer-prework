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
  coupons.each {|coupon|
    if cart.include?(coupon[:item])
      cartitem = coupon[:item]
      cartitemValue = cart[cartitem]
      if coupon[:num] <= cartitemValue[:count]
        cart[(cartitem + " W/COUPON")] = {:price => coupon[:cost], :clearance => cartitemValue[:clearance], :count => (cartitemValue[:count] / coupon[:num])}
        cart[cartitem][:count] = cartitemValue[:count] % coupon[:num]
      end
    end
  }
  cart
end

def apply_clearance(cart)
  cart.each { |item, value|
    if value[:clearance]
      # binding.pry
      value[:price] = value[:price] * 0.80
    end
  }
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  # binding.pry
  cart = apply_coupons(cart, coupons)
  # binding.pry
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
