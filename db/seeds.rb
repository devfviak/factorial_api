# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Expense.destroy_all

user = User.create!(first_name: 'Stan',
										last_name: 'Smith',
										email: 'stan@smith.com',
										password: 'qwerty',
										phone: '+34634234890')


expense = Expense.create!(concept: 'Test expense',
													subtotal_cents: 100,
													total_cents: 120,
													currency: 'USD',
													processor: 'stripe',
													user_id: user.id)
