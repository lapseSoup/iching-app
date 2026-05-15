#!/usr/bin/env swift
// A-46: Verify (or regenerate) Shared/hexagram_basic.json against the canonical
// IChing/Resources/hexagrams.json. Defaults to verify-only mode so it's safe to
// wire into an Xcode "Run Script" build phase or CI step.
//
// Usage:
//   swift scripts/generate_hexagram_basic.swift            # verify only; exit 1 on drift
//   swift scripts/generate_hexagram_basic.swift --write    # overwrite Shared/hexagram_basic.json
//
// Verifies four fields (id, chineseName, character, lines). The englishName field
// is intentionally NOT verified: hexagrams.json carries verbose academic translations
// (e.g. "Waiting (Nourishment)") while hexagram_basic.json carries shorter widget-
// friendly variants ("Waiting"). Those names are curated separately by design.

import Foundation

struct FullHexagram: Codable {
    let id: Int
    let chineseName: String
    let pinyin: String
    let englishName: String
    let character: String
    let upperTrigram: String
    let lowerTrigram: String
}

struct BasicHexagram: Codable {
    let id: Int
    let englishName: String
    let chineseName: String
    let character: String
    let lines: [Bool]
}

let trigramLines: [String: [Bool]] = [
    "heaven":   [true, true, true],
    "lake":     [true, true, false],
    "fire":     [true, false, true],
    "thunder":  [true, false, false],
    "wind":     [false, true, true],
    "water":    [false, true, false],
    "mountain": [false, false, true],
    "earth":    [false, false, false]
]

let writeMode = CommandLine.arguments.contains("--write")

let cwd = FileManager.default.currentDirectoryPath
let canonicalURL = URL(fileURLWithPath: cwd).appendingPathComponent("IChing/Resources/hexagrams.json")
let basicURL = URL(fileURLWithPath: cwd).appendingPathComponent("Shared/hexagram_basic.json")

func fail(_ message: String) -> Never {
    FileHandle.standardError.write("error: \(message)\n".data(using: .utf8)!)
    exit(1)
}

guard let canonicalData = try? Data(contentsOf: canonicalURL) else {
    fail("cannot read \(canonicalURL.path)")
}
guard let basicData = try? Data(contentsOf: basicURL) else {
    fail("cannot read \(basicURL.path)")
}

let decoder = JSONDecoder()
let canonical: [FullHexagram]
let basic: [BasicHexagram]
do {
    canonical = try decoder.decode([FullHexagram].self, from: canonicalData).sorted { $0.id < $1.id }
    basic = try decoder.decode([BasicHexagram].self, from: basicData).sorted { $0.id < $1.id }
} catch {
    fail("decoding failed: \(error)")
}

guard canonical.count == 64 else { fail("hexagrams.json has \(canonical.count) entries, expected 64") }
guard basic.count == 64 else { fail("hexagram_basic.json has \(basic.count) entries, expected 64") }

// Derive expected lines from canonical trigrams and compare each field.
var drift: [String] = []
for (full, b) in zip(canonical, basic) {
    if full.id != b.id { drift.append("id mismatch at position: canonical=\(full.id) basic=\(b.id)") }
    if full.chineseName != b.chineseName { drift.append("chineseName drift on \(full.id): canonical=\(full.chineseName) basic=\(b.chineseName)") }
    if full.character != b.character { drift.append("character drift on \(full.id): canonical=\(full.character) basic=\(b.character)") }
    guard let lower = trigramLines[full.lowerTrigram], let upper = trigramLines[full.upperTrigram] else {
        drift.append("\(full.id): unknown trigram name(s) — upper=\(full.upperTrigram) lower=\(full.lowerTrigram)")
        continue
    }
    let derivedLines = lower + upper
    if derivedLines != b.lines {
        drift.append("lines drift on \(full.id): canonical-derived=\(derivedLines) basic=\(b.lines)")
    }
}

if drift.isEmpty {
    print("ok: hexagram_basic.json matches canonical source (64 hexagrams verified)")
    exit(0)
}

if !writeMode {
    FileHandle.standardError.write("drift detected (run with --write to regenerate):\n".data(using: .utf8)!)
    for d in drift { FileHandle.standardError.write("  - \(d)\n".data(using: .utf8)!) }
    exit(1)
}

// --write mode: regenerate from canonical, preserving curated englishName from existing basic.
let basicById = Dictionary(uniqueKeysWithValues: basic.map { ($0.id, $0) })
let regenerated: [BasicHexagram] = canonical.map { full in
    let lower = trigramLines[full.lowerTrigram] ?? []
    let upper = trigramLines[full.upperTrigram] ?? []
    let curatedName = basicById[full.id]?.englishName ?? full.englishName
    return BasicHexagram(
        id: full.id,
        englishName: curatedName,
        chineseName: full.chineseName,
        character: full.character,
        lines: lower + upper
    )
}

func jsonString(_ s: String) -> String {
    let escaped = s
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "\"", with: "\\\"")
    return "\"\(escaped)\""
}

func encodeLine(_ hex: BasicHexagram) -> String {
    let linesJSON = hex.lines.map { $0 ? "true" : "false" }.joined(separator: ",")
    let parts = [
        "\"id\":\(hex.id)",
        "\"englishName\":\(jsonString(hex.englishName))",
        "\"chineseName\":\(jsonString(hex.chineseName))",
        "\"character\":\(jsonString(hex.character))",
        "\"lines\":[\(linesJSON)]"
    ]
    return "  {\(parts.joined(separator: ","))}"
}

let body = regenerated.map(encodeLine).joined(separator: ",\n")
let output = "[\n\(body)\n]\n"

try output.write(to: basicURL, atomically: true, encoding: .utf8)
print("wrote \(basicURL.path) (\(regenerated.count) hexagrams)")
