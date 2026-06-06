#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win


^+!v:: {
    caseMenu := Menu()
    caseMenu.Add("ALL CAPS", ApplyCase)
    caseMenu.Add("Title Case", ApplyCase)
    caseMenu.Add("Capitalize Each Word", ApplyCase)
    caseMenu.Show()
}

ApplyCase(itemName, itemPos, menu) {
    text := A_Clipboard
    switch itemName {
        case "ALL CAPS":
            result := StrUpper(text)
        case "Title Case":
            result := ToTitleCase(text)
        case "Capitalize Each Word":
            result := CapEachWord(text)
        default:
            return
    }
    SendText result
}

ToTitleCase(text) {
    ; Articles, coordinating conjunctions, and short prepositions stay lowercase
    minor := ["a", "an", "the", "and", "but", "or", "nor", "for", "so", "yet",
              "at", "by", "in", "of", "on", "to", "up", "as", "via"]
    words := StrSplit(StrLower(text), " ")
    total := words.Length
    result := ""
    for i, word in words {
        if (word = "") {
            result .= (i > 1 ? " " : "")
            continue
        }
        ; First and last word always capitalized
        capitalize := (i = 1 || i = total || !HasMinorVal(minor, word))
        result .= (i > 1 ? " " : "") . (capitalize ? StrUpper(SubStr(word, 1, 1)) . SubStr(word, 2) : word)
    }
    return result
}

HasMinorVal(arr, val) {
    for v in arr
        if (v = val)
            return true
    return false
}

CapEachWord(text) {
    words := StrSplit(text, " ")
    result := ""
    for i, word in words
        result .= (i > 1 ? " " : "") . (word != "" ? StrUpper(SubStr(word, 1, 1)) . SubStr(word, 2) : "")
    return result
}