#set text(lang: "ru")
#set table(stroke: 0.6pt)
#set figure(caption: "")

#let load_tickets = () => {
  set heading(
    numbering: (first, ..other) => {
      if other.pos().len() == 0 {
        "Вопрос " + str(first) + "."
      }
    },
    hanging-indent: 0pt,
    supplement: none,
  )
  show heading.where(level: 1): it => {
    pagebreak()
    it
  }
  let first = 0
  let last = 43
  for ticketid in range(first, last + 1) {
    let ticketname = str(ticketid) + ".typ"
    while ticketname.len() < str(last).len() + ".typ".len() {
      ticketname = "0" + ticketname
    }
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
  text("Смирнов Егор" + "\n")
  text("Чертков Михаил" + "\n")
  text("Храмов Александр" + "\n")
  text("Григорьев Данила" + "\n")
  text("Соловьев Артем" + "\n")
  text("Толстов Роберт" + "\n")
  text("Леонтьев Михаил" + "\n")
  v(1fr)
  set align(center)
  text("г. Саратов " + str(datetime.today().year()))
  pagebreak()
}

#generate_title()

#set page(numbering: "1")

#outline(title: "Программа экзамена", target: heading.where(level: 1))

#load_tickets()
