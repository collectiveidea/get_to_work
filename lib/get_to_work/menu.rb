module GetToWork
  module Menu
    def menu_ask(statement, options, *args)
      print_table(options.table) # Assuming MenuPresenter type
      choice = ask(statement, *args)
      options.item_for(choice: choice)
    end
  end
end
