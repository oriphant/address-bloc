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

    def view_all_entries
        @address_book.entries.each do|entry|
        system "clear"
        puts entry.to_s
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end

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
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

    def search_entries
    end

    def read_csv
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
            when "e"
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                entries submenu(entry)
            end
    end
end