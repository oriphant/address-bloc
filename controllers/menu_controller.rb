require_relative "../models/address_book"

class MenuController
attr_accessor :address_book

    def initialize
        @address_book = AddressBook.new
    end

    def main_menu
        puts "Main Menu - #{@address_book.entries.count} Entries"
        puts "\n"
        puts "1 - View all entries"
        puts "2 - View Entry Number n"
        puts "3 - Create an entry"
        puts "4 - Search for an entry"
        puts "5 - Import entries from a CSV"
        puts "6 - Exit"
        puts "\n"
        print "Enter your selection: "

        selection = gets.to_i
        
        case selection
        when 1
            system "clear"
            view_all_entries
            main_menu
        when 2
            system "clear"
            view_entry_n
            main_menu
        when 3
            system "clear"
            create_entry
            main_menu
        when 4
            system "clear"
            search_entries
            main_menu
        when 5
            system "clear"
            read_csv
            main_menu
        when 6
            puts "Good-bye!"
            exit(0)
        else
            system "clear"
            puts "Sorry, that is not a valid input"
            main_menu
        end
    end
# ~~~~~ Entry 1 - View All Contacts ~~~~~~~~~
    def view_all_entries
        @address_book.entries.each do|entry|
        system "clear"
        puts entry.to_s 
        puts "\n"
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end

    def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    selection = gets.chomp
    case selection
        when "n"
        when "d"
          delete_entry(entry)
        when "e"
          edit_entry(entry)
          entry_submenu(entry)
        when "m"
            system "clear"
            main_menu
        else
            system "clear"
            puts "#{selection} is not a valid input"
            puts "\n"
            puts entry.to_s 
            search_submenu(entry)
        end
    end

    def delete_entry(entry)
      @address_book.entries.delete(entry)
      puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)
      print "Update name: "
      name = gets.chomp
      print "Updated phone number: "
      phone_number = gets.chomp
      print "Updated email: "
      email = gets.chomp

      entry.name=name if !name.empty?
      entry.phone_number=phone_number if !phone_number.empty?
      entry.email=email if !email.empty?
      system "clear"

      puts "Updated entry: "
      puts entry
    end
# ~~~~~ Entry 2 - View Specific Entry n ~~~~~~~~~
# ~~~~~ CP22 Assignment Here ~~~~~~~~~
    def view_entry_n
        system "clear"
    
        if @address_book.entries.length ==0
            puts "You need to first enter an address using Option 3 below"
            puts"\n"
            main_menu
        else
            print"Which entry would you like to see?: "
            entry_n = gets.to_i
        
                while entry_n>@address_book.entries.length || entry_n<=0
                    puts"\n"
                    puts"Invalid entry there are only #{@address_book.entries.length} entries."
                    puts"Please enter a new number less than or equal to #{@address_book.entries.length}: "
                    entry_n = gets.chomp.to_i
                end
                    system "clear"
                    output_n = @address_book.entries[entry_n-1]
                    puts"\n"
                    puts "This is the contact:"
                    puts "#{output_n}"
                    puts"\n"
        end
        
    end
# ~~~~~ Entry 3 - Create a Contact ~~~~~~~~~

    def create_entry
        system "clear"
        puts "New AddressBloc Entry"
        
        print "Name: "
        name = gets.chomp
        print "Phone number: "
        phone = gets.chomp
        print "Email: "
        email = gets.chomp
        
        @address_book.add_entry(name, phone, email)
        
        system "clear"
        puts "New entry created"
    end
# ~~~~~ Entry 4 - Search for a Specific Contact ~~~~~~~~~
    def search_entries
      print "Search by name: "
      name = gets.chomp

      match = @address_book.binary_search(name)
      system "clear"

      if match
        puts match.to_s
        search_submenu(match)
      else
        puts "No match found for #{name}"
      end
    end
    def search_submenu(entry)
      puts "\nd - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"
      selection = gets.chomp

      case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        seach_submenu(entry)
      end
    end

# ~~~~~ Entry 5 - Import Contracts from a CSV File ~~~~~~~~~
    def read_csv
      print "Enter CSV file to import: "
      file_name = gets.chomp

      if file_name.empty?
        system "clear"
        puts "No CSV file read"
        main_menu
      end
      begin
        entry_count=@address_book.import_from_csv(file_name).count
        system "clear"
        puts "#{entry_count} new entries added from #{file_name}"
      rescue
        puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      end
    end
    
end