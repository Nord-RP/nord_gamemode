forumAccounts = DBConn:define("ips_core_members", {
    member_id={
        type = DBManager.INT(11),
        primaryKey = true,
        autoIncrement = true
    },
    name={
        type = DBManager.STRING(255),
    },
    members_pass_hash={
        type = DBManager.STRING(255),
    },
})

characters = DBConn:define("mta_characters", {
    id={
        type = DBManager.INT(11),
        primaryKey = true,
        autoIncrement = true
    },
    owner_id={
        type = DBManager.INT(11),
    },
    name={
        type = DBManager.STRING(30),
    },
    surname={
        type = DBManager.STRING(30),
    },
    skin={
        type = DBManager.INT(11),
    },
    playtime={
        type = DBManager.INT(11),
    },
    blocked={
        type = DBManager.INT(1),
    },
    hidden={
        type = DBManager.INT(1),
    },
    online={
        type = DBManager.INT(1),
    },
    sex={
        type = DBManager.INT(1),
    },
    age={
        type = DBManager.INT(11),
    }
})


DBConn:sync()