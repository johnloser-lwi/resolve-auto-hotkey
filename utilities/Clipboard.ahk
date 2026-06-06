#Requires AutoHotkey v2.0

; ! = Alt
; + = Shift
; ^ = Ctrl
; # = Win


^+!v:: {
    caseMenu := Menu()
    caseMenu.Add("ALL CAPS", ApplyCase)
    caseMenu.Add("lowercase", ApplyCase)
    caseMenu.Add("Title Case", ApplyCase)
    caseMenu.Add("Capitalize Each Word", ApplyCase)
    caseMenu.Add("Sentence case", ApplyCase)
    caseMenu.Show()
}

ApplyCase(itemName, itemPos, menu) {
    text := A_Clipboard
    switch itemName {
        case "ALL CAPS":
            result := StrUpper(text)
        case "lowercase":
            result := StrLower(text)
        case "Title Case":
            result := ToTitleCase(text)
        case "Capitalize Each Word":
            result := CapEachWord(text)
        case "Sentence case":
            result := ToSentenceCase(text)
        default:
            return
    }
    A_Clipboard := result
    Send "^v"
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

ToSentenceCase(text) {
    text := StrLower(text)
    result := ""
    capitalizeNext := true
    loop StrLen(text) {
        ch := SubStr(text, A_Index, 1)
        if capitalizeNext && ch ~= "[a-z]" {
            ch := StrUpper(ch)
            capitalizeNext := false
        }
        if ch ~= "[.!?]"
            capitalizeNext := true
        result .= ch
    }
    return result
}

CapEachWord(text) {
    words := StrSplit(text, " ")
    result := ""
    for i, word in words
        result .= (i > 1 ? " " : "") . (word != "" ? StrUpper(SubStr(word, 1, 1)) . SubStr(word, 2) : "")
    return result
}