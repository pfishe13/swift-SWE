import dataset

if __name__ == "__main__":
    taskbook_db = dataset.connect('sqlite:///taskbook.db')  
    task_table = taskbook_db.get_table('task')
    task_table.drop()
    task_table = taskbook_db.create_table('task')
    task_table.insert_many([
        {"time":0.0, "sets":"3", "reps":"10", "description":"Bench Press", "list":"today", "completed":True},
        {"time":0.5, "sets":"4", "reps":"8", "description":"Incline Bench Press", "list":"today", "completed":False},
        {"time":0.3, "sets":"3", "reps":"15", "description":"Incline Chest Fly", "list":"tomorrow", "completed":False},
        {"time":0.7, "sets":"5", "reps":"10", "description":"Pushups", "list":"tomorrow", "completed":True}
    ]) 
    meal_table = taskbook_db.get_table('meal')
    meal_table.drop()
    meal_table = taskbook_db.create_table('meal')
    meal_table.insert_many([
        {"time":0.0, "food":"Apple", "amount":"1", "calories":52,"list":"today", "completed":False},
        {"time":0.5, "food":"Grilled Chicken", "amount":"3 ounces", "calories":160, "list":"today", "completed":False},
    ]) 
