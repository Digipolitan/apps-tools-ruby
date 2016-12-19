module Digipolitan

  class UI

    def input(message)
      print message
      return gets.strip()
    end

    def confirm(message)
      return nil
    end

  end

end
