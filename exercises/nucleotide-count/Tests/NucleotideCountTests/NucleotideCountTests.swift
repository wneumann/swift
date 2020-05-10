import XCTest
@testable import NucleotideCount

class NucleotideCountTests: XCTestCase {
    func testEmptyDNAStringHasNoAdenosine() throws {
        let dna = try XCTUnwrap(DNA(strand: ""), "Empty strands are valid strands and should not return nil")
        let result = dna.count("A")
        let expected = 0
        XCTAssertEqual(result, expected)
    }

    func testEmptyDNAStringHasNoNucleotides() throws {
        let dna = try XCTUnwrap(DNA(strand: ""), "Empty strands are valid strands and should not return nil")
        let results = dna.counts()
        let expected = ["T": 0, "A": 0, "C": 0, "G": 0]
        XCTAssertEqual(results, expected)
    }

    func testSingleNoNucleotideStrand() throws {
        let dna = try XCTUnwrap(DNA(strand: "T"))
        let results = dna.counts()
        let expected = ["T": 1, "A": 0, "C": 0, "G": 0]
        XCTAssertEqual(results, expected)
    }

    func testRepetitiveCytidineGetsCounted() throws {
        let dna = try XCTUnwrap(DNA(strand: "CCCCC"))
        let result = dna.count("C")
        let expected = 5
        XCTAssertEqual(result, expected)
    }

    func testRepetitiveSequenceHasOnlyGuanosine() throws {
        let dna = try XCTUnwrap(DNA(strand: "GGGGGGGG"))
        let results = dna.counts()
        let expected = [ "A": 0, "T": 0, "C": 0, "G": 8 ]
        XCTAssertEqual(results, expected)
    }

    func testCountsByThymidine() throws {
        let dna = try XCTUnwrap(DNA(strand: "GGGGGTAACCCGG"))
        let result = dna.count("T")
        let expected = 1
        XCTAssertEqual(result, expected)
    }

    func testCountsANucleotideOnlyOnce() throws {
        let dna = try XCTUnwrap(DNA(strand: "CGATTGGG"))
        let result = dna.count("T")
        let expected = 2
        XCTAssertEqual(result, expected)
    }

    func testValidatesDNA() {
        XCTAssertNil(DNA(strand: "John"))
    }

    func testValidatesDNAWithValidPortion() {
        XCTAssertNil(DNA(strand: "CATTAX"), "All characters in a strand need to be valid nucleotides.")
    }

    func testCountsAllNucleotides() throws {
        let longStrand = "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        let dna = try XCTUnwrap(DNA(strand: longStrand))
        let results = dna.counts()
        let expected = [ "A": 20, "T": 21, "C": 12, "G": 17 ]
        XCTAssertEqual(results, expected)
    }

    static var allTests: [(String, (NucleotideCountTests) -> () throws -> Void)] {
        return [
            ("testEmptyDNAStringHasNoAdenosine", testEmptyDNAStringHasNoAdenosine),
            ("testEmptyDNAStringHasNoNucleotides", testEmptyDNAStringHasNoNucleotides),
            ("testSingleNoNucleotideStrand", testSingleNoNucleotideStrand),
            ("testRepetitiveCytidineGetsCounted", testRepetitiveCytidineGetsCounted),
            ("testRepetitiveSequenceHasOnlyGuanosine", testRepetitiveSequenceHasOnlyGuanosine),
            ("testCountsByThymidine", testCountsByThymidine),
            ("testCountsANucleotideOnlyOnce", testCountsANucleotideOnlyOnce),
            ("testValidatesDNA", testValidatesDNA),
            ("testCountsAllNucleotides", testCountsAllNucleotides),
            ("testValidatesDNAWithValidPortion", testValidatesDNAWithValidPortion),
        ]
    }
}
