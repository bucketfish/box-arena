extends Node


#loot tables
var loot = {
	'1':['wooden stick', 'healing drop', 'cookie'],
	'2':['wooden sword', 'health pot', 'choco cookie', 'clothes'],
	'3':['stone sword', 'leather padding', 'apple pie'],
	'4':['stone axe', 'health potion'],
	'5':['sharp flint', 'steak', 'iron armor'],
	'6':['battle axe', 'golden apple', 'grilled porkchop'],
	'7':['spiked mace', 'chainmail armor', 'pumpkin pie'],
	'8':['iron rapier', 'iron heart', 'nano-vest', 'cake'],
	'9':['silver katana', 'diamond hoe', 'golden carrot'],
		}
		
const itemsorder = ["healing drop", "health pot", "health potion", "iron heart", "cookie", "choco cookie", "apple pie", "steak", "golden apple", "grilled porkchop", "pumpkin pie", "cake", "golden carrot", "fishcow", "clothes", "leather padding", "iron armor", "chainmail armor", "nano-vest", "wooden stick", "wooden sword", "stone sword", "stone axe", "sharp flint", "battle axe", "spiked mace", "iron rapier", "silver katana", "diamond how", "ruby scythe", "emerald greatsword", "sapphire saber", "axe of perun", "blade of fire", "elemental blade"]

var items = {
	#level 1 itms
	'wooden stick':{
					'damage': 1,
					'energy': -1,
					'weapon': true,
					'fusion': 'wooden sword',
					'desc': 'it’s just about as effective as a slightly more polished branch.',
					},

	'healing drop':{
					'health': 1,
					'desc': 'a drop of this might just be what you need for a small cut on your finger!',
					},

	'cookie':      {
					'energy': 4,
					'desc': 'this game uses cookies to give you a better user experience.',
					},


	#level 2 items
	'wooden sword':{
					'damage': 2,
					'energy': -2,
					'weapon': true,
					'fusion': 'stone sword',
					'desc': 'it’s more useful than a stick, but that doesn’t make it useful.',
					},

	'health pot':  {
					'health': 2,
					'desc': 'an ENTIRE POT? OF HEALTH? what a GEM! a pity it only heals two hp.',
					},

	'choco cookie':{
					'energy': 6,
					'desc': 'it\'s a cookie, just that it has chocolate on it. congrats. you now have a choco cookie.',
					},

	'clothes':     {
					'plural': 'clothes',
					'total_health': 1,
					'desc': 'maybe if you put some of this on people would stop attacking you.',
					},


	#level 3 items
	'stone sword': {
					'damage': 3,
					'energy': -5,
					'weapon': true,
					'fusion':'stone axe',
					'desc': 'now we’re getting somewhere! ‘somewhere’ is probably a fiery pit of lava, but, y\'know, it’s somewhere.',
					},

	'leather padding':{
					'total_health': 2,
					'desc': 'call it whatever you like - we all know it\'s a fursuit.',
					},

	'apple pie':    {
					'energy': 6,
					'health':2,
					'desc': 'it might just smell vaguely of happiness if you just hold your breath.',
					},


	#level 4 items
	'stone axe':    {
					'damage': 4,
					'energy': -4,
					'weapon': true,
					'fusion':'sharp flint',
					'desc': 'if you\'ve an axe to grind with someone, give them this axe.',
					},

	'health potion':{
					'health': 3,
					'desc': 'i hear drinking this is good for your health.',
					},


	#level 5 items
	'sharp flint':{
					'damage': 4,
					'energy': -3,
					'weapon': true,
					'fusion': 'battle axe',
					'desc': 'trust me, paper cuts are NOTHING compared to devastation you get from trying to hold this. all it does is cause pain.',
					},

	'steak':{
					'energy': 10,
					'desc': 'finally, some good ol\' overcooked steak.',
					},

	'iron armor':   {
					'total_health': 5,
					'desc': 'sure, it\'s clunky, and loud, and heavy, but it\'s also very shiny if you polish it often! by \'often\', we mean every ten seconds.',
					},


	#level 6 items
	'battle axe':   {
					'damage': 6,
					'energy':-5,
					'weapon': true,
					'fusion': 'spiked mace',
					'desc': 'this is the axe you use to lightly graze your mortal enemy with. just be grateful it\'s made of something better than stone.',
					},

	'golden apple': {
					'health': 5,
					'desc': 'it\'s shiny. you could probably attract a crow with it. the crow would probably be a better source of food.',
					},

	'grilled porkchop':{
					'energy': 12,
					'desc': 'it\'s grilled, it\'s pork, and it\'s a chop. pretty self-explanatory, if you ask me.',
					},


	#level 7 items
	'spiked mace':  {
					'damage': 10,
					'energy': -15,
					'weapon': true,
					'fusion': 'iron rapier',
					'desc': 'there\'s probably a sound argument to be made on its usefulness, but i don\'t want to hear it.',
					},

	'chainmail armor':{
					'total_health': 7,
					'desc': 'how are the endless string of texts you forwarded helping you now, huh? HUH? probably more than this ever will, but that\'s besides the point.',
					},

	'pumpkin pie':  {
					'energy': 16,
					'desc': 'if the taste of apple pies doesn\'t suit you, this definitely won\'t!',
					},


	#level 8 items
	'iron rapier':  {
					'damage': 12,
					'energy': -7,
					'weapon': true,
					'fusion': 'silver katana',
					'desc': 'look how it gleams! look how COOL and AWESOME it is! look how it stabs - hang on - look how it stabs! look. okay. look how it - y\'know what? just...look away.',
					},

	'iron heart':   {
					'health': 7,
					'desc': 'don\'t think about where it came from and you\'ll be fine - if you’re fine living as an accomplice to MURDER, you MURDERER.',
					},

	'nano-vest':    {
					'total_health': 10,
					'desc': 'it\'s pretty impressive...that such a vest made with nanotechnology could be this useless.',
					},

	'cake':         {
					'energy': 20,
					'health': 7,
					'desc': 'is a lie and marie antoinette is the liar.',
					},


	#level 9 items
	'silver katana':{
					'damage': 20,
					'energy': -17,
					'weapon': true,
					'fusion': 'emerald greatsword',
					'desc': 'now you look like a ninja - just worse!',
					},

	'diamond hoe':  {
					'damage': 10,
					'energy': 0,
					'weapon': true,
					'desc': 'till your crops with this for extra damage to your soul!',
					},

	'golden carrot':{
					'energy': 30,
					'health': 10,
					'desc': 'oink oink you capitalist pig. bring back the guillotine.',
					},


	#fusion only items
	'emerald greatsword':{
					'damage': 25,
					'energy': -20,
					'weapon': true,
					'fusion': 'sapphire saber',
					'desc': 'villagers won\'t be able to get ENOUGH of this!',
					},

	'sapphire saber':{
					'damage':30,
					'energy': -30,
					'weapon': true,
					'fusion': 'axe of perun',
					'desc': 'it\'s just like a light saber - just...less.',
					},

	'axe of perun': {
					'plural': 'axes of perun',
					'damage':40,
					'energy': -35,
					'weapon': true,
					'desc': 'you really didn\'t need to flex this hard on us.',
					},


	#boss drops
	'ruby scythe':  {
					'damage': 15,
					'energy': -10,
					'weapon': true,
					'desc': 'you killed someone. now you have a scythe. and the scent of death.',
					},

	'blade of fire':{
					'plural': 'blades of fire',
					'damage': 35,
					'energy': -30,
					'weapon': true,
					'desc': 'do you know why it\'s so hot in here? because you decided to carry a blade of FIRE into this room, that\'s why.',
					},


	#elemental blade
	'elemental blade':{
					'damage': 100,
					'energy': 0,
					'weapon': true,
					'desc': 'it kept balance between the elements...but all that changed when the fire nation attacked...',
					},


	#misc
	'fishcow':      {
					'health': -10,
					'energy': 20,
					'desc': 'why.',
					}
}

var bosslist = {
	2:[
		'nyam',
		'sol',
		'pionk'],

	6:[
		'flickflack',
		'ticktack',
		'kickee'],

	10:[
		'slurpydoo',
		'conkydonk',
		'tictactoe',
		'fishymoo'],

	'end':[
		'poinkydirtie', #earth
		'swooshymooshy', #water
		'foofeefoofee', #fire
		"puffpuffiepuff" #air
		 ]
	}
var bosses = {
	#level 3 bosses
	'nyam':{
				'damage': 2,
				'health': 5,
				'level': 1,
				'speed': 200,
				'knockback': 1500,
				'drop':['steak', 'steak', 'steak', 'steak', 'choco cookie'],
				'desc': 'it eats a lot. not that we\'re judging, or anything.'},

	'sol':{
				'damage': 4,
				'health': 2,
				'speed': 150,
				'knockback': 700,
				'level': 1,
				'drop':['golden apple', 'golden apple'],
				'desc': 'its future is almost blinding. a pity you have to cut it short.'},

	'pionk':{
				'damage': 1,
				'health': 7,
				'level': 1,
				'speed': 100,
				'knockback': 500,
				'drop':['wooden stick', 'wooden stick', 'wooden stick', 'wooden stick', 'wooden stick', 'wooden stick', 'wooden stick', 'wooden stick'],
				'desc': 'just... be nice and pretend its hits hurt.'},

	#level 6 bosses
	'flickflack':{
				'damage':5,
				'health': 8,
				'level': 2,
				'drop':['sharp flint', 'sharp flint', 'sharp flint'],
				'desc': 'you... don\'t want to be anywhere near it about five seconds after you\'ve defeated it. trust me.'},

	'ticktack':{
				'damage':7,
				'health': 4,
				'level': 2,
				'drop':['nano-vest', 'nano-vest', 'iron heart'],
				'desc': 'its skin is sharp enough to be made into armour (for the masochist).'},

	'kickee':{
				'damage': 2,
				'health': 15,
				'level': 2,
				'drop':['cake', 'cake', 'cake'],
				'desc': 'its legs are entirely made out of cake. don\'t ask me how i know this.'},

	#level 10 bosses
	'slurpydoo':{
				'damage':10,
				'health':12,
				'level':3,
				'drop':['silver katana','silver katana','silver katana','silver katana','silver katana','silver katana','silver katana','ruby scythe'],
				'desc': 'consuming metal you can\'t digest probably isn’t the best of ideas, but neither is consuming swords that could slice you in half. it does both.'},

	'conkydonk':{
				'damage':15,
				'health':6,
				'level':3,
				'drop':['emerald greatsword','ruby scythe'],
				'desc': 'if you beat it up, it\'ll help you beat other monsters up. beat it up.'},

	'tictactoe':{
				'damage':3,
				'health':20,
				'level':3,
				'drop':['ruby scythe', 'golden carrot', 'golden carrot'],
				'desc': 'it\'s won ten carrot-eating competitions, and the fame\'s really gotten to his head.'},

	'fishymoo':{
				'damage':42,
				'health': 11,
				'level': 3,
				'drop':['fishcow', 'fishcow', 'fishcow'],
				'desc': 'this is the worst thing you will ever have the misfortune of meeting.'},

	#endgame
	'poinkydirtie':{
				'damage':30,
				'health':70,
				'level':'endgame',
				'desc':'incomplete description'},

	'swooshymooshy':{
				'damage':30,
				'health':50,
				'level':'endgame',
				'desc':'incomplete description'},

	'foofeefoofee':{
				'damage':50,
				'health':50,
				'level':'endgame',
				'drop':['blade of fire'],
				'desc':'incomplete description'},

	'puffpuffiepuff':{
				'damage':30,
				'health':50,
				'level':'endgame',
				'desc':'incomplete description'}
	}

var cowardmessage = [
				'huh. i thought you were braver than that.',
				'c\'mon, you could’ve handled that.',
				'what\'s the point of coming in here if you\'re just running away?',
				'okay. this is getting on my nerves now. last chance. don\'t let me down.',
				'i guess you aren\'t who i wanted you to be. well. goodbye.\nthe values of all chests have been reduced.',
				'typical.']

#values
var fightplaces = [2, 6, 10]

var places = {
			'0 0' :[],
			'1 0': ['cookie'],
			'1 1': ['wooden stick'],
			'0 1': ['cookie'],
			'0 -1': ['wooden stick'],
			'-1 -1': ['wooden stick'],
			'-1 0': ['healing drop'],
			'-1 1':['cookie'],
			'1 -1':['healing drop']}

var genbosses = {
				'10 -10': {'name': 'poinkydirtie', 'alive': true},
				'10 10': {'name': 'swooshymooshy', 'alive': true},
				'-10 10': {'name': 'foofeefoofee', 'alive': true},
				'-10 -10': {'name': 'puffpuffiepuff', 'alive': true}}
