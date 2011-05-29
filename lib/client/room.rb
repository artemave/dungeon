class Room < ActiveResource::Base
  self.site = 'http://localhost' #FIXME

  attr_accessor :entrance
end
