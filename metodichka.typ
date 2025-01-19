#import "functions.typ": lets
#let load_tickets = () => {
	let tickets_offset = 1
	set heading(numbering: (..nums) => {
		let number = nums.pos().map(str).slice(1).join(".")
		if nums.pos().len() == tickets_offset + 1 {
			"Вопрос " + number + "."
		}
	}, supplement: [Вопрос]
		, offset: tickets_offset)
	show heading.where(level: tickets_offset + 1): it => {
		pagebreak()
		it
	}
	let first = 0
	let last = 42
	for ticketid in range(first, last + 1) {
		let ticketname = str(ticketid) + ".typ"
		while ticketname.len() < str(last).len() + ".typ".len() {
			ticketname = "0" + ticketname
		}
		counter(heading).update((..nums) => {
			let arr = nums.pos()
			if arr.len() > tickets_offset {
				arr.at(tickets_offset) = ticketid - 1
			}
			return arr
		})
		include "tickets/" + ticketname
	}
}
#let generate_title() = {
	set align(center)
	v(1.5cm)
	text(weight: "bold", upper("Машинно-зависимые языки программирования") + "\n")
	[*3 семестр*]
	par("Материалы для подготовки к экзамену")
	v(1.5cm)
	set align(left)
	text("Данила Григорьев" + "\n")
	text("Смирнов Егор" + "\n")
	v(1fr)
	set align(center)
	text("г. Саратов" + " " + str(datetime.today().year()))
	pagebreak()
}

#generate_title()

#outline(title: "Программа экзамена", target: heading.where(level: 2, supplement: [Вопрос]))

#load_tickets()
