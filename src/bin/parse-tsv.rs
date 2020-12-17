use serde::Deserialize;
use std::error::Error;

#[derive(Debug, Deserialize)]
struct Study {
    pmid: String,
    archive: String,
    library: String,
    organism: String,
    biosample: String,
    assay: String,
    genes: String,
    enzyme: String,
}

//qpmid	archive	library	gene	enzyme	assay	biosample	organism


fn read_csv<T: serde::de::DeserializeOwned>(path: &str) -> Result<Vec<T>, Box<dyn Error>> {
    //let mut rdr = csv::Reader::from_path(path)?;
    let mut rdr = csv::ReaderBuilder::new()
    .has_headers(true)
    .delimiter(b'\t')
    .from_path(path)?;
    let mut entries = Vec::new();
    for result in rdr.deserialize() {
        let row: T = result?;
        entries.push(row);
    }
    Ok(entries)
}

fn main() {
    let studies = read_csv::<Study>("data/gtc.tsv").expect("Could not import GTC data.");
    for study in studies {
        println!("{{organism: '{}', biosample: '{}', assay: '{}', genes: '{}', enzyme: '{}', archive: '{}', library: '{}', pmid: '{}'}},", study.organism, study.biosample, study.assay, study.genes, study.enzyme, study.archive, study.library, study.pmid);
    }
}