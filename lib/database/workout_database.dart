List<String> cateButtonList = [
  'All',
  'Cardio',
  'Chest',
  'Shoulders',
  'Back',
  'Biceps',
  'Triceps',
  'Abs',
  'Legs',
  'Glutes',
  'Others'
];

Map<String, List> workMap = {
  'Cardio': [
    'Walking',
    'Running',
    'Treadmill',
    'Rowing Machine',
    'Mountain Climber',
    'Bicycle',
    'Stepper',
    'Jumping Jack',
    'Jump Rope',
    'Burpee',
  ],
  'Chest': [
    'Push Up',
    'Dip',
    'Fly',
    'Machine Fly',
    'Dumbbell Fly',
    'Pec Dec Fly',
    'Pullover',
    'Barbell Pullover',
    'Dumbbell Pullover',
    'Bench Press',
    'Smith Machine Bench Press',
    'Incline Bench Press',
    'Decline Bench Press',
    'Squeeze Press',
    'Plate Press',
    'Chest Press',
    'Chest Press Machine',
    'Dumbbell Chest Press',
    'Cable Crossover',
  ],
  'Shoulders': [
    'Y Raise',
    'Shoulder Press',
    'Shoulder Press Machine',
    'dumbbell Shoulder Press',
    'Barbell Shoulder Press',
    'Military Press',
    'Behind The Neck Press',
    'Front Raise',
    'Lateral Raise',
    'Bent-Over Lateral Raise',
    'Shrug',
    'Upright Row',
    'Reverse Fly',
    'Cable Reverse Fly',
    'Pec Dec Reverse Fly',
    'Face Pull',
  ],
  'Back': [
    'Row',
    'Barbell Row',
    'Dumbbell Row',
    'Seated Row',
    'Seated Machine Row',
    'Seated Cable Row',
    'T Bar Row',
    'Deadlift',
    'Conventional Deadlift',
    'Romanian Deadlift',
    'Sumo Deadlift',
    'Stiff Leg Deadlift',
    'Pull Up',
    'Lat Pull Down',
    'Lat Pull Down Machine',
    'Cable Pull Down',
  ],
  'Biceps': [
    'Ez Bar Curl',
    'Barbell Curl',
    'Dumbbell Curl',
    'Hammer Curl',
    'Cable Curl',
  ],
  'Triceps': [
    'Dumbbell Triceps Extension',
    'Cable Triceps Extension',
    'Lying Dumbbell Triceps Extension',
    'Lying Barbell Triceps Extension',
    'French Press',
    'Triceps Kickback',
    'Triceps Push Down',
  ],
  'Abs': [
    'L Sit',
    'Russian Twist',
    'Leg Raise',
    'Hanging Leg Raise',
    'Chair Leg Raise',
    'Ab Wheel Rollout',
    'V Up',
    'Side Bend',
    'Sit Up',
    'Crunch',
    'Cable Crunch',
    'Seated Crunch',
    'Bicycle Crunch',
    'Leg Lift Crunch',
    'Reverse Crunch',
    'Plank',
    'Side Plank',
  ],
  'Legs': [
    'Squat',
    'Barbell Squat',
    'Dumbbell Squat',
    'Smith Machine Squat',
    'Kettlebell Squat',
    'Leg Press',
    'Leg Curl',
    'Box Jump',
    'Lunge',
    'Dumbbell Lunge',
    'Barbell Lunge',
    'Calf Raise',
    'Step Up',
  ],
  'Glutes': [
    'Hip Thrust',
    'Hip Raise',
    'Side Lying Abduction',
    'Seated Hip Abduction',
    'Donkey Kick',
    'Glute Kickback',
    'Glute Bridge',
  ],
};

Map routineMap = {
  'Back&Biceps Sample': {
    'Pull up': {
      'category': 'Back',
      'set_info': [
        {
          'set': '4',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Lat Pull Down': {
      'category': 'Back',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Barbell Row': {
      'category': 'Back',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Seated Row': {
      'category': 'Back',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Ez Bar Curl': {
      'category': 'Biceps',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Dumbbell curl': {
      'category': 'Biceps',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Hammer Curl': {
      'category': 'Biceps',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '9',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
  'Chest&Triceps Sample': {
    'Bench Press': {
      'category': 'Chest',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Dip': {
      'category': 'Chest',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '10',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Triceps Kickback': {
      'category': 'Triceps',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Triceps Push Down': {
      'category': 'Triceps',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
  'Shoulders&Legs Sample': {
    'Military Press': {
      'category': 'Shoulders',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Lateral Raise': {
      'category': 'Shoulders',
      'set_info': [
        {
          'set': '4',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Reverse Fly': {
      'category': 'Shoulders',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Squat': {
      'category': 'Legs',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Lunge': {
      'category': 'Legs',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '8',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Deadlift': {
      'category': 'Back',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '6',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
  'Abs Sample': {
    'Hanging Leg Raise': {
      'category': 'Abs',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '12',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Crunch': {
      'category': 'Abs',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Bicycle': {
      'category': 'Abs',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
  'EZ Workout Sample': {
    'Pull Up': {
      'category': 'Back',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '10',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Sit Up': {
      'category': 'Abs',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Push Up': {
      'category': 'Chest',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Squat': {
      'category': 'Legs',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '40',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
  '5X5 A Sample': {
    'Bench Press': {
      'category': 'Chest',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Barbell Squat': {
      'category': 'Legs',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Barbell Row': {
      'category': 'Back',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
  '5X5 B Sample': {
    'Barbell Squat': {
      'category': 'Legs',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Military Press': {
      'category': 'Shoulders',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Deadlift': {
      'category': 'Back',
      'set_info': [
        {
          'set': '1',
          'weight': '',
          'reps': '5',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
  'Home Workout Sample': {
    'Plank': {
      'category': 'Abs',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '',
          'time': '1',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Glute Bridge': {
      'category': 'Glutes',
      'set_info': [
        {
          'set': '2',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Squat': {
      'category': 'Legs',
      'set_info': [
        {
          'set': '5',
          'weight': '',
          'reps': '20',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Crunch': {
      'category': 'Abs',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '15',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Push Up': {
      'category': 'Chest',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '15',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
    'Lateral Raise': {
      'category': 'Shoulders',
      'set_info': [
        {
          'set': '3',
          'weight': '',
          'reps': '30',
          'time': '',
          'unit_time': 'kg',
          'unit_weight': 'minutes'
        }
      ]
    },
  },
};
