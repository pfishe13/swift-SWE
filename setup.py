import dataset

if __name__ == "__main__":
    taskbook_db = dataset.connect('sqlite:///taskbook.db')  
    task_table = taskbook_db.get_table('task')
    task_table.drop()
    task_table = taskbook_db.create_table('task')
    task_table.insert_many([
        {"time":0.0, "sets":"3", "reps":"10", "description":"Barbell Bench Press", "list":"today", "completed":False},
        {"time":0.5, "sets":"4", "reps":"12","description":"Decline Pushups", "list":"today", "completed":False},
        {"time":0.3, "sets":"5", "reps":"8","description":"Dumbbell Flies", "list":"today", "completed":False},
        {"time":0.7, "sets":"5", "reps":"12","description":"Squats", "list":"tomorrow", "completed":False},
        {"time":0.7, "sets":"3", "reps":"15","description":"Barbell Lunges", "list":"tomorrow", "completed":False}
    ]) 
