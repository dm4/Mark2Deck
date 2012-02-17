guard 'livereload' do
    watch(%r{.+\.html})
end

guard 'shell' do
    watch(/^(.*\.md)$/) { |m|
        puts "\e[33m#{m[0]} update at " + Time.now.inspect + "\e[m"
        `./md2html.pl #{m[0]}`
    }
end
