//
//  Database.swift
//  SQLiteWrapper
//
//  Created by OneClickDB on 2/1/2023.
//

import Foundation
import SQLite3

@MainActor
class DataManager: ObservableObject
{
    //The connection to the database
    var db : OpaquePointer?
    var fileName : String = "nameYourDatabase.db"
    let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    let tables: [String] = ["CREATE TABLE IF NOT EXISTS tableName(fieldText TEXT, fieldInteger INTEGER, fieldDouble REAL, fieldBool BOOL)"]

    
    init()
    {
        Task
        {
            db = await openDatabase(named: fileName)
            
            await createTables(tables)
        }
    }
}
