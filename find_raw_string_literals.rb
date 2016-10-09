#!/usr/bin/ruby

# characters in the list will prevent the @ sign from being considered as a string literal start
characters_to_ignore_before_at = "%"

# list all .m and .h files in directory
Dir.glob("#{ENV['SRCROOT']}/#{ENV['PROJECT_NAME']}/**/{*.h,*.m}") do |file|

    # iterate through all lines of the given file
    File.foreach(file).with_index do |line, line_num|

        # iterate through all occurences of @", and check if it represents the beginning of a string literal
        index = -1
        while index = line.index('@"', index+1)

            # if we haven't found the beginning of a literal we go to the next occurence
            next if index > 0 && characters_to_ignore_before_at.index(line[index-1])

            # we find the end of the literal
            index_end = index + 1
            while index_end = line.index('"', index_end+1)
                # the double-quote character doesn't denote an end if it's escaped
                break if line[index_end-1] != '\\'
            end

            # in case the literal is sprend into multiple lines and we don't find its end on this line
            if index_end == nil
                index_end = -1
            end

            # string literal content
            string_to_translate = line[index..index_end]

            # xcode warning
            puts "#{file}:#{line_num+1}:#{index+1}: warning: TRANSLATE: #{string_to_translate}"
        end
    end
end

