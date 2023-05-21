//
//  Update.swift
//  SQLiteWrapper
//
//  Created by OneClickDB on 1/1/2023.
//

import Foundation

extension DataManager
{
    /*
    //Inset a single object
    func updateObject(_ object: Object)
    {
        //Create query
        let query = "UPDATE tableName SET fieldText = ?, fieldInteger = ?, fieldDouble = ?, fieldBool = ? WHERE id = ?"
        
        //Check the query is valid
        if let statement = prepare(query)
        {
            //Bind the values to the question marks
            bind(value: .text(object.variableString), to: 1, in: statement)
            
            bind(value: .integer(object.variableInteger), to: 2, in: statement)
            
            bind(value: .double(object.variableDouble), to: 3, in: statement)
            
            bind(value: .bool(object.variableBool), to: 4, in: statement)
            
            //Bind the id to the final ? so the recorded updated is one where the id equals the object.id
            bind(value: .integer(object.id), to: 5, in: statement)
            
            //Run the query
            runQuery(statement)
            
            close(statement)
        }
    }*/
}
