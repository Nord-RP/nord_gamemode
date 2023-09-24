forumAccountsModel = DBConn:define("ips_core_members", {
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
    pp_reputation_points={
        type = DBManager.INT(11),
    },
})

charactersModel = DBConn:define("mta_characters", {
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
    money={
        type = DBManager.INT(11),
    },
    bank_money={
        type = DBManager.INT(11),
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
    },
    health={
        type = DBManager.INT(11),
    },
    psyche={
        type = DBManager.INT(11),
    },
    strength={
        type = DBManager.INT(11),
    },
})

authTokenModel = DBConn:define("mta_auth_token", {
    id={
        type = DBManager.INT(11),
        primaryKey = true,
    },
    member_id={
        type = DBManager.INT(11),
    },
    token={
        type = DBManager.STRING(255),
    },
})


vehiclesModel = DBConn:define("mta_vehicles", {
    id={
        type = DBManager.INT(11),
        primaryKey = true,
    },
    model={
        type = DBManager.INT(6),
    },
    owner={
        type = DBManager.INT(11),
    },
    owner_type={
        type = DBManager.INT(4),
    },
    fuel={
        type = DBManager.INT(4),
    },
    health={
        type = DBManager.INT(6),
    },
    mileage={
        type = DBManager.INT(11),
    },
    plate={
        type = DBManager.STRING(8),
    },
    color={
        type = DBManager.STRING(255),
    },    
    spawn_position={
        type = DBManager.STRING(255),
    },
    favorite={
        type = DBManager.INT(1),
    }
})

adminsModel = DBConn:define("mta_admins", {
    user_id={
        type = DBManager.INT(11),
        primaryKey = true,
    },
    level={
        type = DBManager.INT(4),
    },
})


DBConn:sync()