{

  host: 'YOUR_HOST',
  base_domain: 'YOUR_DOMAIN',
  blog_url: 'YOUR_BLOG_URL',
  twitter_username: "YOUR_TWITTER",
  email_contact: 'EMAIL_ACCOUNT',
  email_system: 'EMAIL_ACCOUNT',
  email_no_reply: 'EMAIL_ACCOUNT',
  support_forum: 'YOUR_SUPPORT_URL',
  string_value: 'testing',
  integer_value: 13322332242342,
  float_value: 1.63243242393,
  boolean_value_f: false,
  boolean_value_t: true

}.each do |name, value|
   conf = Setting.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value,
     data_type: "#{value.class}"
   })
end


puts '============================================='
puts ' Showing all entries in Setting Table...'
puts '---------------------------------------------'

Setting.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']} --> #{a['data_type']}"
end

puts '---------------------------------------------'
puts 'Done!'