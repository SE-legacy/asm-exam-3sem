#let block_base = (name, breakline, content) => {
  [*#name*.]
  if breakline {
    par(content)
  } else {
    h(5pt)
    content
  }
}
#let block_proofable = (name, breakline, wording, proof) => {
  block_base(name, breakline, {
    wording
    if proof != [] {
      par[*Доказательство*:]
      par(proof)
      set align(right)
      $square.filled$
      set align(left)
    }
  })
}

#let theorem = (name: "Теорема", breakline: false, wording, proof) => block_proofable(name, breakline, wording, proof)
#let definition = (name: "Определение", breakline: false, content) => block_base(name, breakline, content)
#let consequence = (name: "Следствие", breakline: false, wording, proof) => block_proofable(
  name,
  breakline,
  wording,
  proof,
)
#let property = (name: "Свойство", breakline: false, wording, proof) => block_proofable(name, breakline, wording, proof)
#let lets = box(
  " ",
  stroke: (
    top: 0.5pt,
    left: none,
    right: 0.5pt,
    bottom: 0.5pt,
  ),
  width: 4pt,
  height: auto,
  fill: none,
  inset: 2pt,
  baseline: 15%,
)

// Функция для нумерования формул #eq($y = x$, id: <eq:eq1>)
#let equ(eq, id: none) = {
  let body = if type(id) == none { eq } else if type(id) == label [#eq #id] else [#eq <#id>]
  let numbering = if type(id) != none { "(1)" } else { none }
  set math.equation(numbering: numbering, supplement: [])
  body
}

#let split-paragraphs(content) = {
  let children = if content.has("children") {
    content.children
  } else {
    ()
  }

  let paragraphs = ()
  let current = ()

  for child in children {
    if child == parbreak() {
      if current.len() > 0 {
        paragraphs.push(current.join())
        current = ()
      }
    } else {
      current.push(child)
    }
  }

  if current.len() > 0 {
    paragraphs.push(current.join())
  }

  paragraphs
}

/// Описание функции DOS или BIOS
///
/// - name (str, content): Назначение функции
/// - code (int): Код вызова: `0x09`
/// - input (content): Действия при вызове. Каждый #par становится членом #list
/// - output (content): Возврат
/// - add_ah (bool): Если `true`, добавить первой строкой в действия при вызове строку с установкой регистра AH
/// -> content
#let int_XXh(name, code, add_ah: true, input, output) = context {
  set terms(separator: ": ", hanging-indent: 1em)

  let code_str = upper(str(code, base: 16)) + "h"
  if (code_str.len() < 3) {
    code_str = "0" + code_str
  }

  let input_array = split-paragraphs(input)
  if (add_ah) {
    if (input_array.len() == 0) {
      input_array.insert(0, [AH $<-$ #code_str.])
    } else {
      input_array.insert(0, [AH $<-$ #code_str\;])
    }
  }

  [*#name --- #code_str*]
  [
    / При вызове: #list(..input_array)
    / Возврат: #linebreak() #output
  ]
}
