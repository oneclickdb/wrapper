//
//  Delete.swift
//  SQLiteWrapper
//
//  Created by OneClickDB on 31/12/2022.
//

import Foundation

extension DataManager
{
    func deleteRecord(id: Int, in table: String)
    {
        let query = "DELETE FROM \(table) WHERE id = \(id)"
        
        if let statement = prepare(query)
        {
            runQuery(statement)
            
            print("Deleted row \(id) from \(table)")
        }
    }
    
    func deleteRecords(ids: [Int], in table: String)
    {
        let query = "DELETE FROM \(table) WHERE id IN (\(ids.searchInteger))"
        
        if let statement = prepare(query)
        {
            runQuery(statement)
            
            print("Deleted rows \(ids.singleInteger) from \(table)")
        }
    }
    
    //Delete all the records in a table
    func truncateTable(_ tableName: String)
    {
        let query = "DELETE FROM \(tableName)"
        
        if let statement = prepare(query)
        {
            runQuery(statement)
            
            print("Deleted all data in the table \(tableName)")
        }
    }
}
