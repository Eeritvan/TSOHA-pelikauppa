from db import db
from sqlalchemy import text

def add_game_to_history(user_id, game_id, date, price): # todo error: database failure
    sql = "INSERT INTO history (user_id, game_id, date, sum) VALUES (:user_id, :game_id, :date, :price)"
    db.session.execute(text(sql), {"user_id":user_id, "game_id":game_id, "date":date, "price":(-price)})
    db.session.commit()

def add_balance_to_history(user_id, date, amount): # todo error: database failure
    sql = "INSERT INTO history (user_id, date, sum) VALUES (:user_id, :date, :sum)"
    db.session.execute(text(sql), {"user_id":user_id, "date":date, "sum":amount})
    db.session.commit()