# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: sentimentalizer 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sentimentalizer"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["malavbhavsar"]
  s.date = "2014-12-27"
  s.description = "Sentiment analysis with ruby."
  s.email = "malav.bhavsar@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".ruby-version",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/data/negative/neg0.txt",
    "lib/data/negative/neg1.txt",
    "lib/data/negative/neg10.txt",
    "lib/data/negative/neg100.txt",
    "lib/data/negative/neg101.txt",
    "lib/data/negative/neg103.txt",
    "lib/data/negative/neg105.txt",
    "lib/data/negative/neg107.txt",
    "lib/data/negative/neg108.txt",
    "lib/data/negative/neg109.txt",
    "lib/data/negative/neg111.txt",
    "lib/data/negative/neg113.txt",
    "lib/data/negative/neg115.txt",
    "lib/data/negative/neg116.txt",
    "lib/data/negative/neg118.txt",
    "lib/data/negative/neg119.txt",
    "lib/data/negative/neg12.txt",
    "lib/data/negative/neg120.txt",
    "lib/data/negative/neg121.txt",
    "lib/data/negative/neg122.txt",
    "lib/data/negative/neg124.txt",
    "lib/data/negative/neg125.txt",
    "lib/data/negative/neg126.txt",
    "lib/data/negative/neg128.txt",
    "lib/data/negative/neg131.txt",
    "lib/data/negative/neg133.txt",
    "lib/data/negative/neg134.txt",
    "lib/data/negative/neg135.txt",
    "lib/data/negative/neg136.txt",
    "lib/data/negative/neg137.txt",
    "lib/data/negative/neg138.txt",
    "lib/data/negative/neg141.txt",
    "lib/data/negative/neg143.txt",
    "lib/data/negative/neg144.txt",
    "lib/data/negative/neg145.txt",
    "lib/data/negative/neg146.txt",
    "lib/data/negative/neg147.txt",
    "lib/data/negative/neg148.txt",
    "lib/data/negative/neg149.txt",
    "lib/data/negative/neg150.txt",
    "lib/data/negative/neg151.txt",
    "lib/data/negative/neg152.txt",
    "lib/data/negative/neg154.txt",
    "lib/data/negative/neg156.txt",
    "lib/data/negative/neg157.txt",
    "lib/data/negative/neg158.txt",
    "lib/data/negative/neg159.txt",
    "lib/data/negative/neg16.txt",
    "lib/data/negative/neg161.txt",
    "lib/data/negative/neg162.txt",
    "lib/data/negative/neg164.txt",
    "lib/data/negative/neg167.txt",
    "lib/data/negative/neg168.txt",
    "lib/data/negative/neg169.txt",
    "lib/data/negative/neg17.txt",
    "lib/data/negative/neg170.txt",
    "lib/data/negative/neg171.txt",
    "lib/data/negative/neg172.txt",
    "lib/data/negative/neg173.txt",
    "lib/data/negative/neg174.txt",
    "lib/data/negative/neg175.txt",
    "lib/data/negative/neg176.txt",
    "lib/data/negative/neg177.txt",
    "lib/data/negative/neg178.txt",
    "lib/data/negative/neg179.txt",
    "lib/data/negative/neg18.txt",
    "lib/data/negative/neg180.txt",
    "lib/data/negative/neg181.txt",
    "lib/data/negative/neg182.txt",
    "lib/data/negative/neg183.txt",
    "lib/data/negative/neg184.txt",
    "lib/data/negative/neg185.txt",
    "lib/data/negative/neg186.txt",
    "lib/data/negative/neg187.txt",
    "lib/data/negative/neg188.txt",
    "lib/data/negative/neg189.txt",
    "lib/data/negative/neg19.txt",
    "lib/data/negative/neg190.txt",
    "lib/data/negative/neg191.txt",
    "lib/data/negative/neg193.txt",
    "lib/data/negative/neg194.txt",
    "lib/data/negative/neg196.txt",
    "lib/data/negative/neg197.txt",
    "lib/data/negative/neg199.txt",
    "lib/data/negative/neg2.txt",
    "lib/data/negative/neg20.txt",
    "lib/data/negative/neg200.txt",
    "lib/data/negative/neg201.txt",
    "lib/data/negative/neg202.txt",
    "lib/data/negative/neg204.txt",
    "lib/data/negative/neg205.txt",
    "lib/data/negative/neg206.txt",
    "lib/data/negative/neg208.txt",
    "lib/data/negative/neg209.txt",
    "lib/data/negative/neg21.txt",
    "lib/data/negative/neg210.txt",
    "lib/data/negative/neg213.txt",
    "lib/data/negative/neg214.txt",
    "lib/data/negative/neg216.txt",
    "lib/data/negative/neg217.txt",
    "lib/data/negative/neg218.txt",
    "lib/data/negative/neg219.txt",
    "lib/data/negative/neg220.txt",
    "lib/data/negative/neg221.txt",
    "lib/data/negative/neg222.txt",
    "lib/data/negative/neg223.txt",
    "lib/data/negative/neg224.txt",
    "lib/data/negative/neg225.txt",
    "lib/data/negative/neg226.txt",
    "lib/data/negative/neg227.txt",
    "lib/data/negative/neg228.txt",
    "lib/data/negative/neg229.txt",
    "lib/data/negative/neg23.txt",
    "lib/data/negative/neg230.txt",
    "lib/data/negative/neg231.txt",
    "lib/data/negative/neg232.txt",
    "lib/data/negative/neg233.txt",
    "lib/data/negative/neg235.txt",
    "lib/data/negative/neg236.txt",
    "lib/data/negative/neg237.txt",
    "lib/data/negative/neg238.txt",
    "lib/data/negative/neg24.txt",
    "lib/data/negative/neg240.txt",
    "lib/data/negative/neg241.txt",
    "lib/data/negative/neg242.txt",
    "lib/data/negative/neg243.txt",
    "lib/data/negative/neg245.txt",
    "lib/data/negative/neg246.txt",
    "lib/data/negative/neg247.txt",
    "lib/data/negative/neg248.txt",
    "lib/data/negative/neg25.txt",
    "lib/data/negative/neg250.txt",
    "lib/data/negative/neg251.txt",
    "lib/data/negative/neg252.txt",
    "lib/data/negative/neg253.txt",
    "lib/data/negative/neg254.txt",
    "lib/data/negative/neg255.txt",
    "lib/data/negative/neg256.txt",
    "lib/data/negative/neg257.txt",
    "lib/data/negative/neg258.txt",
    "lib/data/negative/neg260.txt",
    "lib/data/negative/neg261.txt",
    "lib/data/negative/neg262.txt",
    "lib/data/negative/neg263.txt",
    "lib/data/negative/neg264.txt",
    "lib/data/negative/neg265.txt",
    "lib/data/negative/neg266.txt",
    "lib/data/negative/neg267.txt",
    "lib/data/negative/neg269.txt",
    "lib/data/negative/neg27.txt",
    "lib/data/negative/neg270.txt",
    "lib/data/negative/neg272.txt",
    "lib/data/negative/neg274.txt",
    "lib/data/negative/neg277.txt",
    "lib/data/negative/neg278.txt",
    "lib/data/negative/neg28.txt",
    "lib/data/negative/neg281.txt",
    "lib/data/negative/neg282.txt",
    "lib/data/negative/neg284.txt",
    "lib/data/negative/neg285.txt",
    "lib/data/negative/neg286.txt",
    "lib/data/negative/neg287.txt",
    "lib/data/negative/neg288.txt",
    "lib/data/negative/neg290.txt",
    "lib/data/negative/neg292.txt",
    "lib/data/negative/neg293.txt",
    "lib/data/negative/neg297.txt",
    "lib/data/negative/neg298.txt",
    "lib/data/negative/neg299.txt",
    "lib/data/negative/neg3.txt",
    "lib/data/negative/neg30.txt",
    "lib/data/negative/neg300.txt",
    "lib/data/negative/neg301.txt",
    "lib/data/negative/neg302.txt",
    "lib/data/negative/neg303.txt",
    "lib/data/negative/neg305.txt",
    "lib/data/negative/neg306.txt",
    "lib/data/negative/neg307.txt",
    "lib/data/negative/neg308.txt",
    "lib/data/negative/neg309.txt",
    "lib/data/negative/neg31.txt",
    "lib/data/negative/neg310.txt",
    "lib/data/negative/neg311.txt",
    "lib/data/negative/neg312.txt",
    "lib/data/negative/neg314.txt",
    "lib/data/negative/neg315.txt",
    "lib/data/negative/neg319.txt",
    "lib/data/negative/neg32.txt",
    "lib/data/negative/neg320.txt",
    "lib/data/negative/neg321.txt",
    "lib/data/negative/neg323.txt",
    "lib/data/negative/neg324.txt",
    "lib/data/negative/neg326.txt",
    "lib/data/negative/neg327.txt",
    "lib/data/negative/neg328.txt",
    "lib/data/negative/neg329.txt",
    "lib/data/negative/neg33.txt",
    "lib/data/negative/neg330.txt",
    "lib/data/negative/neg331.txt",
    "lib/data/negative/neg332.txt",
    "lib/data/negative/neg333.txt",
    "lib/data/negative/neg334.txt",
    "lib/data/negative/neg335.txt",
    "lib/data/negative/neg336.txt",
    "lib/data/negative/neg337.txt",
    "lib/data/negative/neg338.txt",
    "lib/data/negative/neg34.txt",
    "lib/data/negative/neg340.txt",
    "lib/data/negative/neg341.txt",
    "lib/data/negative/neg342.txt",
    "lib/data/negative/neg343.txt",
    "lib/data/negative/neg344.txt",
    "lib/data/negative/neg346.txt",
    "lib/data/negative/neg347.txt",
    "lib/data/negative/neg348.txt",
    "lib/data/negative/neg349.txt",
    "lib/data/negative/neg351.txt",
    "lib/data/negative/neg352.txt",
    "lib/data/negative/neg353.txt",
    "lib/data/negative/neg355.txt",
    "lib/data/negative/neg357.txt",
    "lib/data/negative/neg358.txt",
    "lib/data/negative/neg359.txt",
    "lib/data/negative/neg36.txt",
    "lib/data/negative/neg360.txt",
    "lib/data/negative/neg361.txt",
    "lib/data/negative/neg362.txt",
    "lib/data/negative/neg364.txt",
    "lib/data/negative/neg365.txt",
    "lib/data/negative/neg368.txt",
    "lib/data/negative/neg37.txt",
    "lib/data/negative/neg370.txt",
    "lib/data/negative/neg371.txt",
    "lib/data/negative/neg372.txt",
    "lib/data/negative/neg373.txt",
    "lib/data/negative/neg374.txt",
    "lib/data/negative/neg378.txt",
    "lib/data/negative/neg379.txt",
    "lib/data/negative/neg38.txt",
    "lib/data/negative/neg380.txt",
    "lib/data/negative/neg383.txt",
    "lib/data/negative/neg388.txt",
    "lib/data/negative/neg389.txt",
    "lib/data/negative/neg390.txt",
    "lib/data/negative/neg391.txt",
    "lib/data/negative/neg392.txt",
    "lib/data/negative/neg393.txt",
    "lib/data/negative/neg394.txt",
    "lib/data/negative/neg395.txt",
    "lib/data/negative/neg397.txt",
    "lib/data/negative/neg40.txt",
    "lib/data/negative/neg401.txt",
    "lib/data/negative/neg402.txt",
    "lib/data/negative/neg405.txt",
    "lib/data/negative/neg406.txt",
    "lib/data/negative/neg407.txt",
    "lib/data/negative/neg409.txt",
    "lib/data/negative/neg412.txt",
    "lib/data/negative/neg413.txt",
    "lib/data/negative/neg415.txt",
    "lib/data/negative/neg416.txt",
    "lib/data/negative/neg419.txt",
    "lib/data/negative/neg421.txt",
    "lib/data/negative/neg422.txt",
    "lib/data/negative/neg423.txt",
    "lib/data/negative/neg425.txt",
    "lib/data/negative/neg426.txt",
    "lib/data/negative/neg427.txt",
    "lib/data/negative/neg428.txt",
    "lib/data/negative/neg43.txt",
    "lib/data/negative/neg432.txt",
    "lib/data/negative/neg434.txt",
    "lib/data/negative/neg435.txt",
    "lib/data/negative/neg436.txt",
    "lib/data/negative/neg437.txt",
    "lib/data/negative/neg438.txt",
    "lib/data/negative/neg439.txt",
    "lib/data/negative/neg441.txt",
    "lib/data/negative/neg443.txt",
    "lib/data/negative/neg444.txt",
    "lib/data/negative/neg445.txt",
    "lib/data/negative/neg446.txt",
    "lib/data/negative/neg448.txt",
    "lib/data/negative/neg449.txt",
    "lib/data/negative/neg45.txt",
    "lib/data/negative/neg450.txt",
    "lib/data/negative/neg451.txt",
    "lib/data/negative/neg454.txt",
    "lib/data/negative/neg456.txt",
    "lib/data/negative/neg457.txt",
    "lib/data/negative/neg458.txt",
    "lib/data/negative/neg459.txt",
    "lib/data/negative/neg46.txt",
    "lib/data/negative/neg460.txt",
    "lib/data/negative/neg461.txt",
    "lib/data/negative/neg462.txt",
    "lib/data/negative/neg464.txt",
    "lib/data/negative/neg465.txt",
    "lib/data/negative/neg466.txt",
    "lib/data/negative/neg467.txt",
    "lib/data/negative/neg468.txt",
    "lib/data/negative/neg469.txt",
    "lib/data/negative/neg47.txt",
    "lib/data/negative/neg470.txt",
    "lib/data/negative/neg473.txt",
    "lib/data/negative/neg474.txt",
    "lib/data/negative/neg475.txt",
    "lib/data/negative/neg476.txt",
    "lib/data/negative/neg478.txt",
    "lib/data/negative/neg479.txt",
    "lib/data/negative/neg48.txt",
    "lib/data/negative/neg481.txt",
    "lib/data/negative/neg482.txt",
    "lib/data/negative/neg483.txt",
    "lib/data/negative/neg484.txt",
    "lib/data/negative/neg485.txt",
    "lib/data/negative/neg486.txt",
    "lib/data/negative/neg49.txt",
    "lib/data/negative/neg491.txt",
    "lib/data/negative/neg493.txt",
    "lib/data/negative/neg495.txt",
    "lib/data/negative/neg496.txt",
    "lib/data/negative/neg497.txt",
    "lib/data/negative/neg498.txt",
    "lib/data/negative/neg499.txt",
    "lib/data/negative/neg5.txt",
    "lib/data/negative/neg500.txt",
    "lib/data/negative/neg501.txt",
    "lib/data/negative/neg502.txt",
    "lib/data/negative/neg503.txt",
    "lib/data/negative/neg504.txt",
    "lib/data/negative/neg506.txt",
    "lib/data/negative/neg507.txt",
    "lib/data/negative/neg51.txt",
    "lib/data/negative/neg510.txt",
    "lib/data/negative/neg511.txt",
    "lib/data/negative/neg513.txt",
    "lib/data/negative/neg514.txt",
    "lib/data/negative/neg515.txt",
    "lib/data/negative/neg517.txt",
    "lib/data/negative/neg518.txt",
    "lib/data/negative/neg519.txt",
    "lib/data/negative/neg52.txt",
    "lib/data/negative/neg520.txt",
    "lib/data/negative/neg521.txt",
    "lib/data/negative/neg523.txt",
    "lib/data/negative/neg527.txt",
    "lib/data/negative/neg528.txt",
    "lib/data/negative/neg53.txt",
    "lib/data/negative/neg530.txt",
    "lib/data/negative/neg533.txt",
    "lib/data/negative/neg535.txt",
    "lib/data/negative/neg54.txt",
    "lib/data/negative/neg542.txt",
    "lib/data/negative/neg543.txt",
    "lib/data/negative/neg544.txt",
    "lib/data/negative/neg546.txt",
    "lib/data/negative/neg547.txt",
    "lib/data/negative/neg548.txt",
    "lib/data/negative/neg549.txt",
    "lib/data/negative/neg55.txt",
    "lib/data/negative/neg550.txt",
    "lib/data/negative/neg552.txt",
    "lib/data/negative/neg553.txt",
    "lib/data/negative/neg554.txt",
    "lib/data/negative/neg56.txt",
    "lib/data/negative/neg57.txt",
    "lib/data/negative/neg59.txt",
    "lib/data/negative/neg6.txt",
    "lib/data/negative/neg60.txt",
    "lib/data/negative/neg61.txt",
    "lib/data/negative/neg62.txt",
    "lib/data/negative/neg63.txt",
    "lib/data/negative/neg64.txt",
    "lib/data/negative/neg66.txt",
    "lib/data/negative/neg67.txt",
    "lib/data/negative/neg68.txt",
    "lib/data/negative/neg69.txt",
    "lib/data/negative/neg7.txt",
    "lib/data/negative/neg70.txt",
    "lib/data/negative/neg71.txt",
    "lib/data/negative/neg72.txt",
    "lib/data/negative/neg73.txt",
    "lib/data/negative/neg74.txt",
    "lib/data/negative/neg75.txt",
    "lib/data/negative/neg76.txt",
    "lib/data/negative/neg77.txt",
    "lib/data/negative/neg79.txt",
    "lib/data/negative/neg8.txt",
    "lib/data/negative/neg80.txt",
    "lib/data/negative/neg83.txt",
    "lib/data/negative/neg84.txt",
    "lib/data/negative/neg86.txt",
    "lib/data/negative/neg89.txt",
    "lib/data/negative/neg9.txt",
    "lib/data/negative/neg90.txt",
    "lib/data/negative/neg91.txt",
    "lib/data/negative/neg92.txt",
    "lib/data/negative/neg93.txt",
    "lib/data/negative/neg94.txt",
    "lib/data/negative/neg96.txt",
    "lib/data/negative/neg97.txt",
    "lib/data/negative/neg99.txt",
    "lib/data/positive/pos0.txt",
    "lib/data/positive/pos10.txt",
    "lib/data/positive/pos100.txt",
    "lib/data/positive/pos102.txt",
    "lib/data/positive/pos103.txt",
    "lib/data/positive/pos104.txt",
    "lib/data/positive/pos105.txt",
    "lib/data/positive/pos106.txt",
    "lib/data/positive/pos107.txt",
    "lib/data/positive/pos108.txt",
    "lib/data/positive/pos109.txt",
    "lib/data/positive/pos11.txt",
    "lib/data/positive/pos110.txt",
    "lib/data/positive/pos113.txt",
    "lib/data/positive/pos115.txt",
    "lib/data/positive/pos116.txt",
    "lib/data/positive/pos117.txt",
    "lib/data/positive/pos118.txt",
    "lib/data/positive/pos119.txt",
    "lib/data/positive/pos12.txt",
    "lib/data/positive/pos120.txt",
    "lib/data/positive/pos122.txt",
    "lib/data/positive/pos124.txt",
    "lib/data/positive/pos125.txt",
    "lib/data/positive/pos126.txt",
    "lib/data/positive/pos127.txt",
    "lib/data/positive/pos128.txt",
    "lib/data/positive/pos13.txt",
    "lib/data/positive/pos130.txt",
    "lib/data/positive/pos131.txt",
    "lib/data/positive/pos132.txt",
    "lib/data/positive/pos133.txt",
    "lib/data/positive/pos135.txt",
    "lib/data/positive/pos136.txt",
    "lib/data/positive/pos137.txt",
    "lib/data/positive/pos138.txt",
    "lib/data/positive/pos139.txt",
    "lib/data/positive/pos14.txt",
    "lib/data/positive/pos141.txt",
    "lib/data/positive/pos142.txt",
    "lib/data/positive/pos143.txt",
    "lib/data/positive/pos144.txt",
    "lib/data/positive/pos145.txt",
    "lib/data/positive/pos147.txt",
    "lib/data/positive/pos148.txt",
    "lib/data/positive/pos149.txt",
    "lib/data/positive/pos15.txt",
    "lib/data/positive/pos151.txt",
    "lib/data/positive/pos153.txt",
    "lib/data/positive/pos154.txt",
    "lib/data/positive/pos155.txt",
    "lib/data/positive/pos156.txt",
    "lib/data/positive/pos157.txt",
    "lib/data/positive/pos158.txt",
    "lib/data/positive/pos16.txt",
    "lib/data/positive/pos160.txt",
    "lib/data/positive/pos163.txt",
    "lib/data/positive/pos164.txt",
    "lib/data/positive/pos165.txt",
    "lib/data/positive/pos168.txt",
    "lib/data/positive/pos169.txt",
    "lib/data/positive/pos17.txt",
    "lib/data/positive/pos170.txt",
    "lib/data/positive/pos171.txt",
    "lib/data/positive/pos172.txt",
    "lib/data/positive/pos173.txt",
    "lib/data/positive/pos174.txt",
    "lib/data/positive/pos175.txt",
    "lib/data/positive/pos176.txt",
    "lib/data/positive/pos177.txt",
    "lib/data/positive/pos178.txt",
    "lib/data/positive/pos179.txt",
    "lib/data/positive/pos180.txt",
    "lib/data/positive/pos181.txt",
    "lib/data/positive/pos182.txt",
    "lib/data/positive/pos183.txt",
    "lib/data/positive/pos184.txt",
    "lib/data/positive/pos185.txt",
    "lib/data/positive/pos186.txt",
    "lib/data/positive/pos187.txt",
    "lib/data/positive/pos188.txt",
    "lib/data/positive/pos189.txt",
    "lib/data/positive/pos19.txt",
    "lib/data/positive/pos191.txt",
    "lib/data/positive/pos193.txt",
    "lib/data/positive/pos194.txt",
    "lib/data/positive/pos195.txt",
    "lib/data/positive/pos196.txt",
    "lib/data/positive/pos197.txt",
    "lib/data/positive/pos199.txt",
    "lib/data/positive/pos2.txt",
    "lib/data/positive/pos20.txt",
    "lib/data/positive/pos200.txt",
    "lib/data/positive/pos201.txt",
    "lib/data/positive/pos202.txt",
    "lib/data/positive/pos203.txt",
    "lib/data/positive/pos204.txt",
    "lib/data/positive/pos208.txt",
    "lib/data/positive/pos21.txt",
    "lib/data/positive/pos210.txt",
    "lib/data/positive/pos211.txt",
    "lib/data/positive/pos212.txt",
    "lib/data/positive/pos214.txt",
    "lib/data/positive/pos216.txt",
    "lib/data/positive/pos217.txt",
    "lib/data/positive/pos219.txt",
    "lib/data/positive/pos22.txt",
    "lib/data/positive/pos220.txt",
    "lib/data/positive/pos221.txt",
    "lib/data/positive/pos223.txt",
    "lib/data/positive/pos224.txt",
    "lib/data/positive/pos225.txt",
    "lib/data/positive/pos227.txt",
    "lib/data/positive/pos228.txt",
    "lib/data/positive/pos229.txt",
    "lib/data/positive/pos23.txt",
    "lib/data/positive/pos230.txt",
    "lib/data/positive/pos231.txt",
    "lib/data/positive/pos232.txt",
    "lib/data/positive/pos233.txt",
    "lib/data/positive/pos235.txt",
    "lib/data/positive/pos236.txt",
    "lib/data/positive/pos237.txt",
    "lib/data/positive/pos239.txt",
    "lib/data/positive/pos24.txt",
    "lib/data/positive/pos240.txt",
    "lib/data/positive/pos241.txt",
    "lib/data/positive/pos242.txt",
    "lib/data/positive/pos244.txt",
    "lib/data/positive/pos245.txt",
    "lib/data/positive/pos246.txt",
    "lib/data/positive/pos248.txt",
    "lib/data/positive/pos249.txt",
    "lib/data/positive/pos25.txt",
    "lib/data/positive/pos250.txt",
    "lib/data/positive/pos251.txt",
    "lib/data/positive/pos252.txt",
    "lib/data/positive/pos254.txt",
    "lib/data/positive/pos255.txt",
    "lib/data/positive/pos259.txt",
    "lib/data/positive/pos26.txt",
    "lib/data/positive/pos260.txt",
    "lib/data/positive/pos261.txt",
    "lib/data/positive/pos262.txt",
    "lib/data/positive/pos263.txt",
    "lib/data/positive/pos265.txt",
    "lib/data/positive/pos266.txt",
    "lib/data/positive/pos267.txt",
    "lib/data/positive/pos268.txt",
    "lib/data/positive/pos269.txt",
    "lib/data/positive/pos270.txt",
    "lib/data/positive/pos272.txt",
    "lib/data/positive/pos274.txt",
    "lib/data/positive/pos275.txt",
    "lib/data/positive/pos277.txt",
    "lib/data/positive/pos278.txt",
    "lib/data/positive/pos279.txt",
    "lib/data/positive/pos28.txt",
    "lib/data/positive/pos280.txt",
    "lib/data/positive/pos281.txt",
    "lib/data/positive/pos282.txt",
    "lib/data/positive/pos283.txt",
    "lib/data/positive/pos284.txt",
    "lib/data/positive/pos285.txt",
    "lib/data/positive/pos286.txt",
    "lib/data/positive/pos287.txt",
    "lib/data/positive/pos288.txt",
    "lib/data/positive/pos289.txt",
    "lib/data/positive/pos29.txt",
    "lib/data/positive/pos290.txt",
    "lib/data/positive/pos292.txt",
    "lib/data/positive/pos293.txt",
    "lib/data/positive/pos294.txt",
    "lib/data/positive/pos295.txt",
    "lib/data/positive/pos297.txt",
    "lib/data/positive/pos298.txt",
    "lib/data/positive/pos299.txt",
    "lib/data/positive/pos3.txt",
    "lib/data/positive/pos30.txt",
    "lib/data/positive/pos300.txt",
    "lib/data/positive/pos301.txt",
    "lib/data/positive/pos302.txt",
    "lib/data/positive/pos303.txt",
    "lib/data/positive/pos304.txt",
    "lib/data/positive/pos306.txt",
    "lib/data/positive/pos308.txt",
    "lib/data/positive/pos31.txt",
    "lib/data/positive/pos311.txt",
    "lib/data/positive/pos314.txt",
    "lib/data/positive/pos316.txt",
    "lib/data/positive/pos317.txt",
    "lib/data/positive/pos318.txt",
    "lib/data/positive/pos319.txt",
    "lib/data/positive/pos32.txt",
    "lib/data/positive/pos320.txt",
    "lib/data/positive/pos321.txt",
    "lib/data/positive/pos323.txt",
    "lib/data/positive/pos324.txt",
    "lib/data/positive/pos325.txt",
    "lib/data/positive/pos326.txt",
    "lib/data/positive/pos327.txt",
    "lib/data/positive/pos33.txt",
    "lib/data/positive/pos332.txt",
    "lib/data/positive/pos335.txt",
    "lib/data/positive/pos337.txt",
    "lib/data/positive/pos339.txt",
    "lib/data/positive/pos341.txt",
    "lib/data/positive/pos342.txt",
    "lib/data/positive/pos343.txt",
    "lib/data/positive/pos344.txt",
    "lib/data/positive/pos345.txt",
    "lib/data/positive/pos346.txt",
    "lib/data/positive/pos347.txt",
    "lib/data/positive/pos349.txt",
    "lib/data/positive/pos350.txt",
    "lib/data/positive/pos351.txt",
    "lib/data/positive/pos353.txt",
    "lib/data/positive/pos354.txt",
    "lib/data/positive/pos355.txt",
    "lib/data/positive/pos358.txt",
    "lib/data/positive/pos359.txt",
    "lib/data/positive/pos36.txt",
    "lib/data/positive/pos361.txt",
    "lib/data/positive/pos363.txt",
    "lib/data/positive/pos364.txt",
    "lib/data/positive/pos366.txt",
    "lib/data/positive/pos367.txt",
    "lib/data/positive/pos369.txt",
    "lib/data/positive/pos37.txt",
    "lib/data/positive/pos372.txt",
    "lib/data/positive/pos373.txt",
    "lib/data/positive/pos374.txt",
    "lib/data/positive/pos375.txt",
    "lib/data/positive/pos376.txt",
    "lib/data/positive/pos377.txt",
    "lib/data/positive/pos378.txt",
    "lib/data/positive/pos379.txt",
    "lib/data/positive/pos380.txt",
    "lib/data/positive/pos381.txt",
    "lib/data/positive/pos383.txt",
    "lib/data/positive/pos384.txt",
    "lib/data/positive/pos385.txt",
    "lib/data/positive/pos386.txt",
    "lib/data/positive/pos387.txt",
    "lib/data/positive/pos388.txt",
    "lib/data/positive/pos39.txt",
    "lib/data/positive/pos390.txt",
    "lib/data/positive/pos391.txt",
    "lib/data/positive/pos392.txt",
    "lib/data/positive/pos393.txt",
    "lib/data/positive/pos395.txt",
    "lib/data/positive/pos396.txt",
    "lib/data/positive/pos397.txt",
    "lib/data/positive/pos398.txt",
    "lib/data/positive/pos4.txt",
    "lib/data/positive/pos40.txt",
    "lib/data/positive/pos400.txt",
    "lib/data/positive/pos403.txt",
    "lib/data/positive/pos404.txt",
    "lib/data/positive/pos406.txt",
    "lib/data/positive/pos407.txt",
    "lib/data/positive/pos409.txt",
    "lib/data/positive/pos41.txt",
    "lib/data/positive/pos411.txt",
    "lib/data/positive/pos412.txt",
    "lib/data/positive/pos413.txt",
    "lib/data/positive/pos414.txt",
    "lib/data/positive/pos415.txt",
    "lib/data/positive/pos416.txt",
    "lib/data/positive/pos417.txt",
    "lib/data/positive/pos418.txt",
    "lib/data/positive/pos419.txt",
    "lib/data/positive/pos42.txt",
    "lib/data/positive/pos420.txt",
    "lib/data/positive/pos421.txt",
    "lib/data/positive/pos422.txt",
    "lib/data/positive/pos424.txt",
    "lib/data/positive/pos426.txt",
    "lib/data/positive/pos428.txt",
    "lib/data/positive/pos429.txt",
    "lib/data/positive/pos43.txt",
    "lib/data/positive/pos430.txt",
    "lib/data/positive/pos432.txt",
    "lib/data/positive/pos433.txt",
    "lib/data/positive/pos434.txt",
    "lib/data/positive/pos437.txt",
    "lib/data/positive/pos439.txt",
    "lib/data/positive/pos44.txt",
    "lib/data/positive/pos440.txt",
    "lib/data/positive/pos441.txt",
    "lib/data/positive/pos444.txt",
    "lib/data/positive/pos445.txt",
    "lib/data/positive/pos448.txt",
    "lib/data/positive/pos449.txt",
    "lib/data/positive/pos45.txt",
    "lib/data/positive/pos450.txt",
    "lib/data/positive/pos451.txt",
    "lib/data/positive/pos452.txt",
    "lib/data/positive/pos453.txt",
    "lib/data/positive/pos454.txt",
    "lib/data/positive/pos455.txt",
    "lib/data/positive/pos456.txt",
    "lib/data/positive/pos457.txt",
    "lib/data/positive/pos458.txt",
    "lib/data/positive/pos46.txt",
    "lib/data/positive/pos461.txt",
    "lib/data/positive/pos463.txt",
    "lib/data/positive/pos464.txt",
    "lib/data/positive/pos465.txt",
    "lib/data/positive/pos467.txt",
    "lib/data/positive/pos47.txt",
    "lib/data/positive/pos470.txt",
    "lib/data/positive/pos471.txt",
    "lib/data/positive/pos472.txt",
    "lib/data/positive/pos474.txt",
    "lib/data/positive/pos475.txt",
    "lib/data/positive/pos477.txt",
    "lib/data/positive/pos478.txt",
    "lib/data/positive/pos480.txt",
    "lib/data/positive/pos481.txt",
    "lib/data/positive/pos482.txt",
    "lib/data/positive/pos484.txt",
    "lib/data/positive/pos485.txt",
    "lib/data/positive/pos486.txt",
    "lib/data/positive/pos488.txt",
    "lib/data/positive/pos489.txt",
    "lib/data/positive/pos490.txt",
    "lib/data/positive/pos491.txt",
    "lib/data/positive/pos492.txt",
    "lib/data/positive/pos494.txt",
    "lib/data/positive/pos495.txt",
    "lib/data/positive/pos498.txt",
    "lib/data/positive/pos499.txt",
    "lib/data/positive/pos5.txt",
    "lib/data/positive/pos500.txt",
    "lib/data/positive/pos501.txt",
    "lib/data/positive/pos502.txt",
    "lib/data/positive/pos503.txt",
    "lib/data/positive/pos505.txt",
    "lib/data/positive/pos507.txt",
    "lib/data/positive/pos51.txt",
    "lib/data/positive/pos510.txt",
    "lib/data/positive/pos511.txt",
    "lib/data/positive/pos514.txt",
    "lib/data/positive/pos515.txt",
    "lib/data/positive/pos516.txt",
    "lib/data/positive/pos518.txt",
    "lib/data/positive/pos520.txt",
    "lib/data/positive/pos521.txt",
    "lib/data/positive/pos523.txt",
    "lib/data/positive/pos524.txt",
    "lib/data/positive/pos525.txt",
    "lib/data/positive/pos526.txt",
    "lib/data/positive/pos527.txt",
    "lib/data/positive/pos528.txt",
    "lib/data/positive/pos53.txt",
    "lib/data/positive/pos532.txt",
    "lib/data/positive/pos533.txt",
    "lib/data/positive/pos537.txt",
    "lib/data/positive/pos55.txt",
    "lib/data/positive/pos57.txt",
    "lib/data/positive/pos59.txt",
    "lib/data/positive/pos6.txt",
    "lib/data/positive/pos63.txt",
    "lib/data/positive/pos64.txt",
    "lib/data/positive/pos65.txt",
    "lib/data/positive/pos66.txt",
    "lib/data/positive/pos67.txt",
    "lib/data/positive/pos68.txt",
    "lib/data/positive/pos69.txt",
    "lib/data/positive/pos7.txt",
    "lib/data/positive/pos70.txt",
    "lib/data/positive/pos71.txt",
    "lib/data/positive/pos73.txt",
    "lib/data/positive/pos75.txt",
    "lib/data/positive/pos76.txt",
    "lib/data/positive/pos77.txt",
    "lib/data/positive/pos8.txt",
    "lib/data/positive/pos80.txt",
    "lib/data/positive/pos81.txt",
    "lib/data/positive/pos82.txt",
    "lib/data/positive/pos83.txt",
    "lib/data/positive/pos86.txt",
    "lib/data/positive/pos87.txt",
    "lib/data/positive/pos88.txt",
    "lib/data/positive/pos89.txt",
    "lib/data/positive/pos9.txt",
    "lib/data/positive/pos90.txt",
    "lib/data/positive/pos92.txt",
    "lib/data/positive/pos93.txt",
    "lib/data/positive/pos94.txt",
    "lib/data/positive/pos95.txt",
    "lib/data/positive/pos96.txt",
    "lib/data/positive/pos98.txt",
    "lib/data/positive/pos99.txt",
    "lib/engine.rb",
    "lib/engine/analyser.rb",
    "lib/engine/classification_result.rb",
    "lib/engine/classifier.rb",
    "lib/engine/corpus.rb",
    "lib/engine/document.rb",
    "lib/generators/sentimentalizer_generator.rb",
    "lib/generators/templates/initializer.rb",
    "lib/sentimentalizer.rb",
    "sentimentalizer.gemspec",
    "spec/sentimentalizer_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/malavbhavsar/sentimentalizer"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Sentiment analysis with ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.11.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.11.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end
