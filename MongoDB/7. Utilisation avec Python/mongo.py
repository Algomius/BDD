from pymongo import MongoClient

client = MongoClient(host='localhost', port=27017)

db = client.test

p = {
	'first_name' : 'John',
	'last_name' : 'Doe',
	'age' : 5
}

#result = db.personne.insert_one(p)

#print(result)

result = db.personne.find()
for e in result:
    print(e)


pipe = [
    {'$group' : { '_id': "$car", "count" : { '$sum' : 1}}},
    {'$sort' : {"count" : 1}}
]

ag = db.personne.aggregate(pipe)
for e in ag:
    print(e)



client.close()
