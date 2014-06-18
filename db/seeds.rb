Category.destroy_all
Forum.destroy_all

c = Category.create(title: "Administrative")
c.forums.create(title: "Announcements", description: "Forum announcements.")

c = Category.create(title: "Love Forums")
c.forums.create(title: "Love Advice", description: "General Relationship discussion. Post your problems and let other members help you out.")
c.forums.create(title: "Ask A Male", description: "Wonder what your guy friend is thinking? Find help from our male members.")
c.forums.create(title: "Ask A Female", description: "Wonder what your girl friend is thinking? Find help from our female members.")
c.forums.create(title: "Intimate Forum", description: "Discussion related to close body contact & related issues.")

c = Category.create(title: "Water Cooler")
c.forums.create(title: "Off-Topic Discussion", description: "Forum for general conversation and anything not related to the other forums.")
