require 'wikitext'


class Country < ApplicationRecord
	has_many :cities
	has_many :user_countries
	has_many :users, through: :user_countries
	has_many :reviews, through: :user_countries

	
	

	def self.get_description

		Country.all.each do |country|

			resp = RestClient.get("https://en.wikivoyage.org/w/api.php?action=query&prop=revisions&rvprop=content&rvsection=0&titles=#{self.format_country_name(country.name)}&format=json")

			info = JSON.parse(resp)

			new_description = info['query']['pages'].values[0]['revisions'][0]['*']

			parsed_description = Wikitext::Parser.new.parse(new_description)
			country.description = parsed_description

			if parsed_description.downcase.include?('warningbox')

				desc = parsed_description
				first_index = desc.index('arningbox')
				sub_string = desc.slice(first_index..-1)
				sub_string = sub_string.split('|')
				warning = sub_string[1]

				country.warning = warning

			end


			country.save
		end

	end

	def self.format_country_name(name)
	    new_name = name.gsub('_',' ')
	    new_name.gsub(/[\u0080-\u00ff]/, 'a')
	    new_name.gsub(',','')

	    if new_name.include?('(')
	      new_name = name[/[^()]+/]
	    end

	    return new_name.chomp('_')
	end

	def self.match_background

		backgrounds = self.get_backgrounds
		self.all.each  do |country|
			bg = backgrounds.select{|background| background[:id] == country.id}
			if bg.length > 0 
				country.background = bg.first[:background]
				country.save
			end
		end

	end		



	def self.get_backgrounds
		return backgrounds = [
			{id: 1001, background: 'https://images.unsplash.com/photo-1507234897433-06646bd0e673?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1003, background: 'https://images.unsplash.com/photo-1504972738139-adc5cfcf91c8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1004, background: 'https://upload.wikimedia.org/wikipedia/commons/2/2a/%D8%A7%D8%B3%D9%83%D8%B1%D8%A7%D9%85_2_-_%D8%AA%D9%85%D9%86%D8%B1%D8%A7%D8%B3%D8%AA.jpg'},
			{id: 1005, background: 'https://www.nps.gov/articles/images/AMSA-Ofu-Island.jpg?maxwidth=1200&autorotate=false'},
			{id: 1006, background: 'https://i.ytimg.com/vi/bswsVef5Keo/maxresdefault.jpg'},
			{id: 1007, background: 'https://i.pinimg.com/originals/bd/12/aa/bd12aafa9aff70bfac78caea0ce31569.jpg'},
			{id: 1008, background: 'https://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/videos/anguilla-little-bay-anguillawb18_0.jpg?itok=s8mNedD5'},
			{id: 1009, background: 'https://c.pxhere.com/photos/27/93/antarctica_cold_floating_freeze_glacial_glacier_ice_icescape-992342.jpg!d'},
			{id: 1010, background: 'https://images.unsplash.com/photo-1553634551-300d16aa9787?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1011, background: 'https://images.unsplash.com/photo-1493724798364-c4ca5e3f5fd3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1462&q=80'},
			{id: 1012, background: 'https://images.unsplash.com/photo-1515330877652-c5c2a95addf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1013, background: 'https://images.unsplash.com/photo-1548176566-a76d33e45922?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1014, background: 'https://images.unsplash.com/photo-1543940812-fe29c50e51d9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80'},
			{id: 1015, background: 'https://images.unsplash.com/photo-1486570318579-054c95b01160?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1490&q=80'},
			{id: 1016, background: 'https://c.pxhere.com/photos/12/35/winter_azerbaijan_horse_landscape_mountain_snow_clouds_pasture-1188518.jpg!d'},
			{id: 1017, background: 'https://images.unsplash.com/photo-1559956144-83a135c9872e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1018, background: 'https://live.staticflickr.com/8689/17051717567_6072eb58f2_b.jpg'},
			{id: 1019, background: 'https://images.unsplash.com/photo-1578128178799-ffbb862243c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1020, background: 'https://images.unsplash.com/photo-1511914265872-c40672604a80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1021, background: 'https://images.unsplash.com/photo-1518770035226-b1c4f19dec60?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60'},
			{id: 1022, background: 'https://images.unsplash.com/photo-1491557345352-5929e343eb89?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1023, background: 'https://images.unsplash.com/photo-1546046142-8f8fae7de558?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1482&q=80'},
			{id: 1024, background: 'https://www.ruralelec.org/sites/default/files/default_images/thangaraj_kumaravel_cc_by_2.0_cut.jpg'},
			{id: 1025, background: 'https://images.unsplash.com/photo-1580840237709-e672f5851231?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1026, background: 'https://images.unsplash.com/photo-1542828810-3372a0020f50?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1027, background: 'https://images.unsplash.com/photo-1526029655228-b7ee496c7819?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1029, background: 'https://images.unsplash.com/photo-1531029824729-9dc4d6313233?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1030, background: 'https://images.unsplash.com/photo-1560846288-b58bb7ae1083?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1031, background: 'https://i0.wp.com/thevalemagazine.com/wp-content/uploads/2019/03/bouvet-island-south-atlantic-ocean.jpg?fit=1280%2C800&ssl=1'},
			{id: 1032, background: 'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1033, background: 'https://i.ytimg.com/vi/gl9As81DiDE/maxresdefault.jpg'},
			{id: 1035, background: 'https://images.unsplash.com/photo-1502126402642-07c2b7a9e7d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1036, background: 'https://images.unsplash.com/photo-1571174215966-b271b37b6a97?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80'},
			{id: 1037, background: 'https://upload.wikimedia.org/wikipedia/commons/0/04/Sultan_Omar_Ali_Saifuddien_Mosque%2C_Brunei%3B_2009.jpg'},
			{id: 1038, background: 'https://images.unsplash.com/photo-1533186758335-367d64aeb7ff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1555&q=80'},
			{id: 1041, background: 'https://images.unsplash.com/photo-1526324585411-e24d5ba61edd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1392&q=80'},
			{id: 1042, background: 'https://storage.needpix.com/rsynced_images/mount-cameroon-1489500_1280.jpg'},
			{id: 1043, background: 'https://images.unsplash.com/photo-1507409613952-518459ac866e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1044, background: 'https://images.unsplash.com/photo-1517424052886-6c7fe06cd4ad?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1491&q=80'},
			{id: 1045, background: 'https://images.unsplash.com/photo-1555744164-728dd59f9d8b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80'},
			{id: 1047, background: 'https://images.unsplash.com/photo-1574786201468-574f3151871e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1403&q=80'},
			{id: 1048, background: 'https://images.unsplash.com/photo-1478827387698-1527781a4887?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1049, background: 'https://images.unsplash.com/photo-1514920735211-8c697444a248?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1050, background: 'https://images.unsplash.com/photo-1516420114325-97684b59e4da?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1052, background: 'https://images.unsplash.com/photo-1532443603613-61fa154742cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1490&q=80'},
			{id: 1054, background: 'https://images.unsplash.com/photo-1579547056948-3bc828faf558?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1056, background: 'https://images.unsplash.com/photo-1576789334654-6a2ef23d13aa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1057, background: 'https://images.unsplash.com/photo-1562559094-0739564bbc71?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1058, background: 'https://images.unsplash.com/photo-1533331639-74f1863c7b3c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1059, background: 'https://images.unsplash.com/photo-1520496366548-c316918abbc8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1060, background: 'https://images.unsplash.com/photo-1526067250293-e1a554afdb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1061, background: 'https://images.unsplash.com/photo-1516658542418-7777f7c65df0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1062, background: 'https://images.unsplash.com/photo-1489443302102-2b00d08b4b3a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1063, background: 'https://images.unsplash.com/photo-1534684105949-56869170677f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1064, background: 'https://images.unsplash.com/photo-1552796220-db7b4c3824a2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1065, background: 'https://images.unsplash.com/photo-1499598896209-c62806b9ae75?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1491&q=80'},
			{id: 1066, background: 'https://images.unsplash.com/photo-1524778880162-1b5dccfbdb0b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1067, background: 'https://images.unsplash.com/photo-1501684691657-cf3012635478?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1068, background: 'https://images.unsplash.com/photo-1539768942893-daf53e448371?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1069, background: 'https://images.unsplash.com/photo-1512857543850-6f05fdcf9973?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1072, background: 'https://images.unsplash.com/photo-1465802954450-8fcef6708c35?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1073, background: 'https://images.unsplash.com/photo-1516533075015-a3838414c3ca?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1074, background: 'https://images.unsplash.com/photo-1517784665784-0251075fd9e5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1075, background: 'https://images.unsplash.com/photo-1526715058896-23f69a067d99?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1336&q=80'},
			{id: 1076, background: 'https://images.unsplash.com/photo-1530736822234-c8562cb0a710?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1077, background: 'https://images.unsplash.com/photo-1482160310982-3adf8b38daef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1078, background: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80'},
			{id: 1080, background: 'https://images.unsplash.com/photo-1532614034235-187d8e4d6cfc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1336&q=80'},
			{id: 1084, background: 'https://images.unsplash.com/photo-1563284223-333497472e88?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1355&q=80'},
			{id: 1085, background: 'https://images.unsplash.com/photo-1484053801020-3a74ca659b03?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1086, background: 'https://images.unsplash.com/photo-1508861736614-6800103b49b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1087, background: 'https://images.unsplash.com/photo-1545289825-f9d7f7562daf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1498&q=80'},
			{id: 1088, background: 'https://images.unsplash.com/photo-1530841377377-3ff06c0ca713?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1089, background: 'https://images.unsplash.com/photo-1543470373-e055b73a8f29?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1090, background: 'https://images.unsplash.com/photo-1468465704228-4966aabccd18?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1506&q=80'},
			{id: 1091, background: 'https://images.unsplash.com/photo-1558787767-e452c31d4b96?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1092, background: 'https://images.unsplash.com/photo-1578118198174-898747df0e36?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1093, background: 'https://images.unsplash.com/photo-1525453878038-5d5a7d19bdd4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1094, background: 'https://images.unsplash.com/photo-1495134990874-164fd7cf0ffa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1490&q=80'},
			{id: 1098, background: 'https://images.unsplash.com/photo-1510796962426-959af1dc86e6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1100, background: 'https://images.unsplash.com/photo-1570239870405-db13f1aa9880?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1101, background: 'https://cdn.birdwatchingdaily.com/2019/04/Honduras-opener-By-chrisontour84.jpg'},
			{id: 1102, background: 'https://images.unsplash.com/photo-1507941097613-9f2157b69235?ixlib=rb-1.2.1&auto=format&fit=crop&w=1413&q=80'},
			{id: 1103, background: 'https://images.unsplash.com/photo-1569443706499-47491954bf45?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1104, background: 'https://images.unsplash.com/photo-1506269351850-0428eaed2193?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1105, background: 'https://images.unsplash.com/photo-1548560463-fd1af27c6384?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60'},
			{id: 1106, background: 'https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80'},
			{id: 1110, background: 'https://images.unsplash.com/photo-1451337516015-6b6e9a44a8a3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1111, background: 'https://images.unsplash.com/photo-1474038876692-81f046eb281c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1112, background: 'https://images.unsplash.com/photo-1554401922-3ac1c68b2715?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1113, background: 'https://images.unsplash.com/photo-1499678329028-101435549a4e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80'},
			{id: 1114, background: 'https://images.unsplash.com/photo-1437719417032-8595fd9e9dc6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1334&q=80'},
			{id: 1115, background: 'https://images.unsplash.com/photo-1528164344705-47542687000d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1369&q=80'},
			{id: 1116, background: 'https://images.unsplash.com/photo-1475871281315-3ef5af74cd54?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1117, background: 'https://images.unsplash.com/photo-1551171129-8ce1ebb911b3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1118, background: 'https://images.unsplash.com/photo-1530480667809-b655d4dc3aaa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1487&q=80'},
			{id: 1119, background: 'https://images.unsplash.com/photo-1489392191049-fc10c97e64b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1496&q=80'},
			{id: 1122, background: 'https://images.unsplash.com/photo-1493873432549-bf8cbeb7d0c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1418&q=80'},
			{id: 1123, background: 'https://images.unsplash.com/photo-1562835156-2f62f161b32c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1124, background: 'https://images.unsplash.com/photo-1522054541898-adc6abd570e5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1334&q=80'},
			{id: 1125, background: 'https://images.unsplash.com/photo-1575285272587-a2523237d6b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1127, background: 'https://images.unsplash.com/photo-1529002045502-d3c5024f8e24?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1128, background: 'https://images.unsplash.com/photo-1512424113276-fa9f6a112384?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1129, background: 'https://images.unsplash.com/photo-1533939664942-173b7df71238?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1336&q=80'},
			{id: 1130, background: 'https://images.unsplash.com/photo-1456051580611-e193e8fb2cc9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1373&q=80'},
			{id: 1133, background: 'https://images.unsplash.com/photo-1577917704494-b4e7a6c28b8f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1134, background: 'https://images.unsplash.com/photo-1558694440-03ade9215d7b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1135, background: 'https://images.unsplash.com/photo-1516344015312-67c699ad7761?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1434&q=80'},
			{id: 1136, background: 'https://images.unsplash.com/flagged/photo-1560505455-11cee7a131b0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1414&q=80'},
			{id: 1137, background: 'https://images.unsplash.com/photo-1505881502353-a1986add3762?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1562&q=80'},
			{id: 1139, background: 'https://images.unsplash.com/photo-1527155431803-74e5f93c7111?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1360&q=80'},
			{id: 1140, background: 'https://images.unsplash.com/photo-1543051824-ebd4aff3001b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1141, background: 'https://images.unsplash.com/photo-1574767027902-00bd97ef4ea5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1336&q=80'},
			{id: 1142, background: 'https://images.unsplash.com/photo-1543318557-a11bce6e033a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1355&q=80'},
			{id: 1143, background: 'https://images.unsplash.com/photo-1513415277900-a62401e19be4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1145, background: 'https://images.unsplash.com/photo-1524158637050-36b68ca9a5ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60'},
			{id: 1146, background: 'https://images.unsplash.com/photo-1545605583-36e41fbdd27f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1148, background: 'https://images.unsplash.com/photo-1575540121783-60f174302cc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1410&q=80'},
			{id: 1149, background: 'https://images.unsplash.com/photo-1535219241072-7d3c28a49a5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1496&q=80'},
			{id: 1156, background: 'https://images.unsplash.com/photo-1543417355-60a0b3788831?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1151, background: 'https://images.unsplash.com/photo-1570268325073-4f2bd3fbe3fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1152, background: 'https://images.unsplash.com/photo-1489749798305-4fea3ae63d43?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1496&q=80'},
			{id: 1153, background: 'https://images.unsplash.com/photo-1544298943-4c10be26bd29?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1441&q=80'},
			{id: 1154, background: 'https://images.unsplash.com/photo-1535748020240-f647f81842ee?ixlib=rb-1.2.1&auto=format&fit=crop&w=1355&q=80'},
			{id: 1155, background: 'https://images.unsplash.com/photo-1536270213414-83e51bdcdd74?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1156, background: 'https://images.unsplash.com/photo-1553947315-42cee3c8c771?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1157, background: 'https://images.unsplash.com/photo-1544735716-392fe2489ffa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1158, background: 'https://images.unsplash.com/photo-1534351590666-13e3e96b5017?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1159, background: 'https://images.unsplash.com/photo-1579503083595-e7f1f910d573?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1160, background: 'https://images.unsplash.com/photo-1528988719300-046ff7faf8cb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1161, background: 'https://images.unsplash.com/photo-1501327825011-e83b7080b0f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1163, background: 'https://images.unsplash.com/photo-1537372023620-37161b1ad8ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60'},
			{id: 1168, background: 'https://images.unsplash.com/photo-1526080676457-4544bf0ebba9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1169, background: 'https://images.unsplash.com/photo-1579193219811-074cb9a633e4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},
			{id: 1170, background: 'https://images.unsplash.com/photo-1550586678-f7225f03c44b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1334&q=80'},
			{id: 1171, background: 'https://images.unsplash.com/photo-1543818872-7a43ea9a7853?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1173, background: 'https://images.unsplash.com/photo-1467753445110-a4321e6c63c2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1175, background: 'https://s3.amazonaws.com/iexplore_web/images/assets/000/006/257/original/paraguay_-_igazu.jpg?1443182487'},
			{id: 1176, background: 'https://images.unsplash.com/photo-1526392060635-9d6019884377?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'},
			{id: 1177, background: 'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=60'},
			{id: 1179, background: 'https://images.unsplash.com/photo-1496661274775-a86a124b9df3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1506&q=80'},
			{id: 1180, background: 'https://images.unsplash.com/photo-1532546430529-1be093fd5aaf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80'},
			{id: 1181, background: 'https://images.unsplash.com/photo-1556337074-c1a5a6559f12?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1489&q=80'},

		]
	end
end
























# description['query']['pages'].values[0]['revisions'][0]['*']