from db import db
from sqlalchemy import text

def add_to_library(user_id, game_id): # todo error: database failure
    sql = "INSERT INTO library (user_id, game_id) VALUES (:user_id, :game_id)"
    db.session.execute(text(sql), {"user_id":user_id, "game_id":game_id})
    db.session.commit()

def get_library(user_id):
    sql = "SELECT G.title, G.id FROM games G, library L WHERE L.user_id=:user_id AND L.game_id=G.id"
    result = db.session.execute(text(sql), {"user_id":user_id})
    return result.fetchall()

def already_in_library(user_id, game_id):
    sql = "SELECT game_id FROM library WHERE user_id=:user_id AND game_id=:game_id"
    result = db.session.execute(text(sql), {"user_id":user_id, "game_id":game_id})
    return result.fetchone() != None