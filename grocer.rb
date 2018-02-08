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
          newCount = item[:count] % coupon[:num]
          newItemCount = item[:count] / coupon[:num]
          newItemCost = coupon[:cost]
        end
      end
    }
    if newItemCount
      cart[item][:count] = newCount
      cart[(item + " W/COUPON")] = {:price => newItemCost, :clearance => item[:clearance], :count => newItemCount}
    end
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
