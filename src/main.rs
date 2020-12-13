#![feature(proc_macro_hygiene, decl_macro)]

extern crate rocket_contrib;

use rocket_contrib::serve::StaticFiles;

fn main() {
   rocket::ignite().mount("/", StaticFiles::from("dist")).launch();
}
