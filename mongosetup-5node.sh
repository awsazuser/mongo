if [ `mongo master --eval "printjson(rs.isMaster())"|grep "setName"|grep "example"|wc -l` = 0 ]
then
        echo "Replication set configuration does not exist"
        mongo admin --host 127.0.0.1 --eval 'rs.initiate({ _id: "example", members: [{ _id: 1, host: "mongo1:27017" }, { _id: 2,host: "mongo2:27017" }, { _id: 3, host: "mongo3:27017" }, { _id: 4, host: "mongo4:27017" }, { _id: 5, host: "mongo5:27017" }], settings: { getLastErrorDefaults: { w: "majority", wtimeout: 30000 }}})'
        while [ 1 -eq 1 ]
        do
                if [ `mongo master --eval "printjson(rs.isMaster())"|grep "ismaster"|grep "true" |wc -l` = 0 ]
                then
                echo "Replication set initializing"
                sleep 5
                else
                echo "Replication set initialized"
                echo "Creating Admin User for Mongo"
                mongo admin --host 127.0.0.1 --eval 'db.createUser({user: "admin", pwd: "mpass123", roles: [ { role: "root", db:"admin" } ] } )'
                echo "Admin User created Sucessfully"
                break
                fi
        done
else
        echo "Replication set configuration exist"
fi