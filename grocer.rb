def consolidate_cart(cart)
  consolidatedCart = {}
  cart.each {|inventory|
    inventory.each {|item, values|
      consolidatedCart[item][:count] += 1 if consolidatedCart[item]
      if !consolidatedCart[item]
        consolidatedCart[item] = values
        (consolidatedCart[item] = values)[item][:count] = 1
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
  cart.each { |item, value| value[:price] = (value[:price] * 0.80).round(2) if value[:clearance] }
end

def checkout(cart, coupons)
  total = 0.00
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each {|item, value| total += value[:price] * value[:count] }
  total > 100.00 ? total = total * 0.90 : total
end
