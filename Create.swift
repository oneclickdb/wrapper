//
//  Create.swift
//  SQLiteWrapper
//
//  Created by OneClickDB on 1/1/2023.
//

import Foundation
import SQLite3

extension DataManager
{
    //Open or create a database in the form *.db -> must be completd in initialiser
    func openDatabase(named fileName: String) async -> OpaquePointer?
    {
        do
        {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            let filePath = documentDirectory.appendingPathComponent(fileName)
            
            var db : OpaquePointer? = nil
            
            if sqlite3_open_v2(filePath.path, &db, SQLITE_OPEN_READWRITE|SQLITE_OPEN_FULLMUTEX|SQLITE_OPEN_CREATE, nil) != SQLITE_OK
            {
                print("Error creating/connecting to database")
                sqlite3_close(db)
                return nil
            }
            else
            {
                print("Database created/connected to at: \(filePath.absoluteString)")
                return db
            }
        }
        catch
        {
            print("There was an error getting the document folder: \(error.localizedDescription)")
            
            return nil
        }
    }
    
    //Check that a table exists in the database
    func tableExists(named tableName: String) -> Bool
    {
        let query = "SELECT count(name) FROM sqlite_master WHERE type = 'table' AND name = '\(tableName)';"
        
        var tableExists : Bool = false
        
        if let statement = prepare(query)
        {
            while sqlite3_step(statement) == SQLITE_ROW
            {
                if Int(sqlite3_column_int(statement, 0)) == 1
                {
                    tableExists = true
                }
                else
                {
                    tableExists = false
                }
            }
            
            sqlite3_finalize(statement)
        }
        
        return tableExists
    }
    
    //Create a table for an SQL query
    func createTable(_ query: String) async
    {
        //Check that the table doesn't already exist
        guard !tableExists(named: query.tableName) else { return }
        
        //Prepare the query
        if let statement = prepare(query)
        {
            //Run the query
            if sqlite3_step(statement) == SQLITE_DONE
            {
                print("Table created: \n\(query)")
            }
            else
            {
                print("Table not created: \n\(query)")
            }
            
            sqlite3_finalize(statement)
        }
        else
        {
            print("Preparation of database to create table failed: \n\(query)")
        }
    }
    
    //Create tables for an array of SQL queries
    func createTables(_ queries: [String]) async
    {
        for table in tables
        {
            await createTable(table)
        }
    }
}
