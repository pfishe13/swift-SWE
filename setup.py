import dataset

if __name__ == "__main__":
    taskbook_db = dataset.connect('sqlite:///taskbook.db')  
    task_table = taskbook_db.get_table('task')
    task_table.drop()
    task_table = taskbook_db.create_table('task')
    task_table.insert_many([
        {"time":0.0, "sets":"3", "reps":"10", "description":"Bench Press", "list":"today", "completed":True},
        {"time":0.5, "sets":"4", "reps":"8", "description":"Incline Bench Press", "list":"today", "completed":False},
        {"time":0.3, "sets":"3", "reps":"12", "description":"Incline Chest Fly", "list":"today", "completed":False},
        {"time":0.7, "sets":"3", "reps":"10", "description":"Alternating Dumbbell Bench Press", "list":"today", "completed":False},
        {"time":0.7, "sets":"5", "reps":"10", "description":"Pushups", "list":"today", "completed":False},
        {"time":0.7, "sets":"3", "reps":"", "description":"Minute Plank", "list":"today", "completed":False}
    ]) 
    meal_table = taskbook_db.get_table('meal')
    meal_table.drop()
    meal_table = taskbook_db.create_table('meal')
    meal_table.insert_many([
        {"time":0.0, "food":"Apple", "amount":"1", "calories":52,"list":"today", "completed":False},
        {"time":0.5, "food":"Scrambled Eggs", "amount":"3", "calories":150, "list":"today", "completed":False},
        {"time":0.5, "food":"Grilled Chicken", "amount":"3 ounces", "calories":160, "list":"today", "completed":False},
        {"time":0.5, "food":"White Rice", "amount":"2 cups", "calories":320, "list":"today", "completed":False},
    ]) 
    user_table = taskbook_db.get_table('users')
    user_table.drop()
    user_table = taskbook_db.create_table('users')
