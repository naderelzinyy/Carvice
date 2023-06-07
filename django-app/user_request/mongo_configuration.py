from pymongo import MongoClient, GEOSPHERE
import pprint

cluster = "mongodb+srv://carviceapp:LOl2NqSS6YZehcaG@cluster0.mdyliea.mongodb.net/?retryWrites=true&w=majority"
# "mongodb+srv://carviceapp:<password>@cluster0.mdyliea.mongodb.net/"

client = MongoClient(cluster)
db = client["carvice_mongo"]
sample = {
    "_id": 2,
    "user_id": 4,
    "workshop_name": "AutoService2",
    "location": {
        "type": "Point",
        "coordinates": [-73.856077, 40.848447]
    }
}

records = [{"location": {"coordinates": [-73.856077, 40.848447], "type": "Point"}, "name": "Morris Park Bake Shop"},
           {"location": {"coordinates": [-73.961704, 40.662942], "type": "Point"}, "name": "Wendy'S"},
           {"location": {"coordinates": [-73.98241999999999, 40.579505], "type": "Point"}, "name": "Riviera Caterer"},
           {"location": {"coordinates": [-73.8601152, 40.7311739], "type": "Point"}, "name": "Tov Kosher Kitchen"},
           {"location": {"coordinates": [-73.8803827, 40.7643124], "type": "Point"}, "name": "Brunos On The Boulevard"},
           {"location": {"coordinates": [-73.98513559999999, 40.7676919], "type": "Point"},
            "name": "Dj Reynolds Pub And Restaurant"},
           {"location": {"coordinates": [-73.9068506, 40.6199034], "type": "Point"}, "name": "Wilken'S Fine Food"},
           {"location": {"coordinates": [-74.00528899999999, 40.628886], "type": "Point"}, "name": "Regina Caterers"},
           {"location": {"coordinates": [-73.9482609, 40.6408271], "type": "Point"},
            "name": "Taste The Tropics Ice Cream"},
           {"location": {"coordinates": [-74.1377286, 40.6119572], "type": "Point"}, "name": "Kosher Island"},
           {"location": {"coordinates": [-73.8786113, 40.8502883], "type": "Point"}, "name": "Wild Asia"},
           {"location": {"coordinates": [-73.9973325, 40.61174889999999], "type": "Point"},
            "name": "C \u0026 C Catering Service"},
           {"location": {"coordinates": [-73.96926909999999, 40.7685235], "type": "Point"},
            "name": "1 East 66Th Street Kitchen"},
           {"location": {"coordinates": [-73.871194, 40.6730975], "type": "Point"}, "name": "May May Kitchen"},
           {"location": {"coordinates": [-73.9653967, 40.6064339], "type": "Point"}, "name": "Seuda Foods"},
           {"location": {"coordinates": [-73.97822040000001, 40.6435254], "type": "Point"}, "name": "Carvel Ice Cream"},
           {"location": {"coordinates": [-73.7032601, 40.7386417], "type": "Point"}, "name": "Carvel Ice Cream"},
           {"location": {"coordinates": [-74.0259567, 40.6353674], "type": "Point"}, "name": "Nordic Delicacies"},
           {"location": {"coordinates": [-73.9829239, 40.6580753], "type": "Point"}, "name": "The Movable Feast"},
           {"location": {"coordinates": [-73.839297, 40.78147], "type": "Point"}, "name": "Sal'S Deli"},
           {"location": {"coordinates": [-73.95171, 40.767461], "type": "Point"}, "name": "Glorious Food"},
           {"location": {"coordinates": [-73.9925306, 40.7309346], "type": "Point"}, "name": "Bully'S Deli"},
           {"location": {"coordinates": [-73.976112, 40.786714], "type": "Point"}, "name": "Harriet'S Kitchen"}]

# db.mechanics.insert_one({"location": {"coordinates": [2, 5],
#                                       "type": "Point"
#                                       }, "name": "nader"})

# db.mechanics.insert_many(records)

# db.mechanics.create_index([("location", GEOSPHERE)])

# db.mechanics.insert_one(sample)
# db.mechanics.createIndex({})
if __name__ == '__main__':
    # res = db.mechanics.find()
    # {"loc": {"$within": {"$center": [[0, 0], 6]}}}

    point = {
        "type": "Point",
        "coordinates": [-73.976112, 40.786714]
    }
    query = {
            "location": {
                "$geoWithin": {
                    "$center": [point["coordinates"], 1000/6371.0]
                }
            }
        }
    res = db.mechanics.find(query)
    print(db.mechanics.count_documents(query))
    for result in res:
        print(result)

    # res = db.mechanics.find({
    #     "location": {
    #         "$nearSphere": {
    #             "$geometry": {
    #                 "type": "Point",
    #                 "coordinates": [-73.93414657, 40.82302903]
    #             },
    #             "$maxDistance": 5}}})
