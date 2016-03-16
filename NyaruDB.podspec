Pod::Spec.new do |s|
  s.name         = "NyaruDB"
  s.version      = "1.4.2"
  s.summary      = "A simple NoSQL database(key-value pair)."
  s.homepage     = "https://github.com/AquarHEAD/NyaruDB"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Kelp" => "kelp@phate.org" }
  s.source       = { :git => "https://github.com/kelp404/NyaruDB.git", :branch => "master" }
  s.source_files  = "NyaruDB/NyaruDB/**/*.{m,h}"
  s.requires_arc = true
end
